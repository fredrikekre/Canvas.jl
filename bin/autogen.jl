#!/bin/bash
#=
exec julia --color=yes --startup-file=no "${BASH_SOURCE[0]}" "$@"
=#

# ./autogen.jl [--patch=false] [StructName...]

const patch = "--patch=false" ∈ ARGS ? (popfirst!(ARGS); false) : true

const outstructs = [
    "User", "CalendarLink", "Term", "CourseProgress", "Course", "Group", "LockInfo",
    "File", "Folder", "TurnitinSettings", "ExternalToolTagAttributes", "DiscussionTopic",
    "Assignment", "Submission", "GradingRules", "AssignmentGroup", "AssignmentOverride",
    "Section", "Account", "Tab",
]

import JSON, OrderedCollections
# git = mktempdir()
git = "/tmp/jl_NR65ip"
commit = "c72bf19e9dba9948ed6bc745f9335510fc51633c"
# run(Cmd(`git clone https://github.com/instructure/canvas-lms.git .`; dir=git))
run(pipeline(Cmd(`git checkout $(commit)`; dir=git), stdout=devnull))

model_regex = r"#\s*@model\s*(\w+)\n(#     {.*?\n#     })"s

function jsontype(v)
    if haskey(v, "type")
        t = v["type"]
        if t == "string"
            return "String"
        elseif t == "integer"
            return "Int"
        elseif t == "number"
            return "Float64"
        elseif t == "datetime"
            return "TimeZones.ZonedDateTime"
        elseif t == "boolean"
            return "Bool"
        elseif t == "array"
            return "Vector"
        elseif t == "object"
            return "Dict"
        else
            @show v["description"]
            error("unknown object type: $t")
        end
    elseif haskey(v, "\$ref")
        return v["\$ref"]
    else
        error("unknown object")
    end
end

all_structs = OrderedCollections.OrderedDict{String,Any}()
for (root, dirs, files) in walkdir(joinpath(git, "app", "controllers"))
    for f in files
        file = joinpath(root, f)
        endswith(f, ".rb") || continue
        occursin("/lti/", file) && continue
        @debug "Parsing file..." file
        content = read(joinpath(root, f), String)
        for m in eachmatch(model_regex, content)
            # Name of the object
            struct_name = String(m.captures[1])
            @debug "Parsing object '$(struct_name)'..."
            # Strip initial #'s
            json_io = IOBuffer()
            for line in eachline(IOBuffer(m.captures[2]))
                println(json_io, chop(line; head=1, tail=0))
            end
            json = JSON.parse(seekstart(json_io); dicttype=OrderedCollections.OrderedDict)
            if json["id"] != struct_name
                @warn "Object id mismatch, skipping" json["id"] struct_name f
                continue
            end
            if haskey(all_structs, struct_name)
                @debug "duplicate struct definition: $(struct_name)" file
                delete!(all_structs, struct_name)
            else
                push!(all_structs, struct_name => json)
            end
        end
    end
end

function print_json(io_out, json; patch)
    io = IOBuffer()
    println(io, "# ", json["id"])
    println(io, "struct ", json["id"], " <: CanvasObject")
    for (k, v) in json["properties"]
        field_name = replace(k, "-"=>"_") # some names have "-" in them
        field_type = jsontype(v)
        if (desc = get(v, "description", nothing); desc !== nothing)
            iob = IOBuffer()
            b = 0
            for d in split(desc)
                if b == 0
                    print(iob, "\"\"\"")
                    b += 3
                elseif b > 70
                    print(iob, "\n")
                    b = 0
                else
                    print(iob, " "); b += 1
                end
                print(iob, d); b += length(d)
            end
            print(iob, "\"\"\"")
            for line in eachline(seekstart(iob))
                print(io, "    ", line, "\n")
            end
        end
        println(io, "    ", field_name, "::Union{", field_type, ",Nothing}")
    end
    println(io, "end")
    if length(json["properties"]) == 1
        # need to print disambiguation constructor for structs with just one field
        println(io, "# Disambiguating constructor needed for single field structs")
        println(io, json["id"], "(data::AbstractDict) = Internals.json2canvas(", json["id"], ", data)")
    end
    println(io)
    # Apply patches
    patchfile = joinpath(@__DIR__, "patches", "$(json["id"]).patch")
    if patch && isfile(patchfile)
        dir = mktempdir(; cleanup=false)
        #=mktempdir() do dir;=# cd(dir) do
            # Copy the patch
            cp(patchfile, basename(patchfile))
            # Write out the source
            source = "$(json["id"]).jl"
            open(source, "w") do io_patch
                write(io_patch, seekstart(io))
            end
            # Apply the patch
            run(pipeline(`patch`, stdin=patchfile, stdout=devnull))
            # Read back in
            write(truncate(io, 0), read(source))
        end #end
    end
    write(io_out, seekstart(io))
    return nothing
end

if isempty(ARGS)
    print(stdout, """
        # This file is automatically generated from the Canvas LMS source
        # code (https://github.com/instructure/canvas-lms) using the
        # bin/autogen.jl script and should not be directly modified.

        """)
end

for struct_name in (isempty(ARGS) ? outstructs : ARGS)
    if !haskey(all_structs, struct_name)
        @warn "Struct with name '$(struct_name)' missing from parsed structs"
        continue
    end
    json = all_structs[struct_name]
    print_json(stdout, json; patch=patch)
end
