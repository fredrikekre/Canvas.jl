# The code in this file is mostly taken from
# GitHub.jl (https://github.com/JuliaWeb/GitHub.jl),
# with some modifications to fit this package. See
# https://github.com/JuliaWeb/GitHub.jl/blob/master/LICENSE.md
# for license information (MIT).

unwrap_union_types(T) = T
unwrap_union_types(T::Union) = T.a === Nothing ? T.b : T.a

function extract_nullable(data::Dict, key, ::Type{T}) where {T}
    if haskey(data, key)
        val = data[key]
        if val !== nothing
            if T <: Vector
                V = eltype(T)
                return V[prune_canvas_value(v, unwrap_union_types(V)) for v in val]
            else
                return prune_canvas_value(val, unwrap_union_types(T))
            end
        end
    end
    return nothing
end

prune_canvas_value(val::T, ::Type{Any}) where {T} = T(val)
prune_canvas_value(val, ::Type{T}) where {T} = T(val)
prune_canvas_value(val::AbstractString, ::Type{Dates.DateTime}) = Dates.DateTime(chopz(val))

# ISO 8601 allows for a trailing 'Z' to indicate that the given time is UTC.
# Julia's Dates.DateTime constructor doesn't support this, but GitHub's time
# strings can contain it. This method ensures that a string's trailing 'Z',
# if present, has been removed.
function chopz(str::AbstractString)
    if !(isempty(str)) && last(str) == 'Z'
        return chop(str)
    end
    return str
end

# Calling `json2canvas(::Type{G<:CanvasObject}, data::Dict)` will parse the given
# dictionary into the type `G` with the expectation that the fieldnames of
# `G` are keys of `data`, and the corresponding values can be converted to the
# given field types.
@generated function json2canvas(::Type{G}, data::Dict) where {G<:CanvasObject}
    types = unwrap_union_types.(collect(G.types))
    fields = fieldnames(G)
    args = Vector{Expr}(undef, length(fields))
    for i in eachindex(fields)
        field, T = fields[i], types[i]
        key = field == :typ ? "type" : string(field)
        args[i] = :(extract_nullable(data, $key, $T))
    end
    return :(G($(args...))::G)
end

