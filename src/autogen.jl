import JSON, OrderedCollections
# git = mktempdir()
# run(Cmd(`git clone https://github.com/instructure/canvas-lms.git .`; dir=git))
git = "/tmp/jl_NR65ip"

structs = Dict[]
model_regex = r"#\s*@model\s*(\w+)\n(#\s*{.*#\s*})"s

function jsontype(t)
    if t == "string"
        return "String"
    elseif t == "integer"
        return "Int"
    elseif t == "datetime"
        return "Dates.DateTime"
    elseif t == "boolean"
        return "Bool"
    elseif t == "array"
        return "Vector"
    else
        @show t
        error()
    end
end
io = IOBuffer()
for (root, dirs, files) in walkdir(joinpath(git, "app", "controllers"))
    for f in files
        endswith(f, ".rb") || continue
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
            # print to io
            println(io, "# ", json["id"])
            println(io, "struct ", json["id"], " <: CanvasObject")
            for (k, v) in json["properties"]
                @show v
                println(io, "    ", replace(k, "-"=>"_"), "::Union{", jsontype(v["type"]), ",Nothing}")
            end
        end
    end
end


f = "files_controller.rb"
root = joinpath(git, "app", "controllers")
content = read(joinpath(root, f), String)

# model_regex = r"^# @model (\w+)"m
# model_regex = r"# @model (\w+)\n(# {.*# })"s



m = match(r, content)

for m in eachmatch(model_regex, content)
    @show m.captures[1]
end
