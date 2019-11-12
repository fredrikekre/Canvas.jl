import JSON, OrderedCollections
# git = mktempdir()
# run(Cmd(`git clone https://github.com/instructure/canvas-lms.git .`; dir=git))
git = "/tmp/jl_NR65ip"

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
            return "Dates.DateTime"
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
                @warn "duplicate struct definition: $(struct_name)" file
                delete!(all_structs, struct_name)
            else
                push!(all_structs, struct_name => json)
            end
        end
    end
end

function print_json(io, json)
    # print to io
    println(io, "# ", json["id"])
    println(io, "struct ", json["id"], " <: CanvasObject")
    for (k, v) in json["properties"]
        field_name = replace(k, "-"=>"_") # some names have "-" in them
        field_type = jsontype(v)
        if (desc = get(v, "description", nothing); desc !== nothing)
            b = 0
            for d in split(desc)
                if b == 0
                    print(io, "    #")
                elseif b > 80
                    print(io, "\n    #")
                    b = 0
                end
                print(io, " ", d)
                b += length(d) + 1
            end
            println(io)
        end
        println(io, "    ", field_name, "::Union{", field_type, ",Nothing}")
    end
    println(io, "end")
    println(io, json["id"], "(data::Dict) = json2canvas(", json["id"], ", data)")
    println(io)
    return nothing
end

io = IOBuffer()
printed_structs = Set{String}()
queued_structs = OrderedCollections.OrderedDict{String,Any}()

for (struct_name, json) in all_structs
    function all_deps_are_printed(json)
        for (k, v) in json["properties"]
            if haskey(v, "\$ref")
                if v["\$ref"] ∉ printed_structs
                    return false
                end
            end
        end
        return true
    end
    if all_deps_are_printed(json)
        print_json(io, json)
        push!(printed_structs, struct_name)
    else
        push!(queued_structs, struct_name => json)
    end
    for (struct_name′, json′) in queued_structs
        if all_deps_are_printed(json′)
            print_json(io, json′)
            push!(printed_structs, struct_name′)
            delete!(queued_structs, struct_name′)
        end
    end
end
if !(isempty(queued_structs))
    @warn "the following dependencies was excluded due to missing dependencies" structs=collect(keys(queued_structs))
end

write("/tmp/autogen.jl", seekstart(io))

cp("/tmp/autogen.jl", joinpath(pwd(), "src", "autogen-gen.jl"); force=true)
