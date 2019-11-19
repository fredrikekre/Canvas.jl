##################
# Canvas Objects #
##################
abstract type CanvasObject end

id(x) = x
id(x::CanvasObject) = x.id
namefield(x) = nothing

function Base.show(io::IO, o::CanvasObject)
    if get(io, :compact, false)
        uri_id = namefield(o)
        if uri_id === nothing
            print(io, typeof(o), "(…)")
        else
            print(io, typeof(o), "($(repr(uri_id)))")
        end
    else
        print(io, "$(typeof(o)) (all fields are Union{T,Nothing}):")
        for field in fieldnames(typeof(o))
            val = getfield(o, field)
            if !(val === nothing)
                println(io)
                print(io, "  $field: ")
                if isa(val, Vector)
                    print(io, typeof(val))
                else
                    show(IOContext(io, :compact => true), val)
                end
            end
        end
    end
end

################
# JSON parsing #
################
function json2canvas(::Type{CO}, data::AbstractDict{T}) where {CO<:CanvasObject,T}
    # Make sure the struct does not miss any fields
    @assert all(k->Symbol(k) ∈ fieldnames(CO), keys(data))
    CO((begin
            v = get(data, T(x), nothing)
            if v === nothing
                nothing
            else
                convert′(fieldtype(CO, x), v)
            end
        end
        for x in fieldnames(CO))...)
end

convert′(::Type{T}, val::T) where T = val
convert′(::Type{T}, val) where T = error("T=$T, val=$val")
function convert′(::Type{Union{CO,Nothing}}, val) where CO <: CanvasObject
    return CO(val)
end
function convert′(::Type{Union{Dates.DateTime,Nothing}}, val)
    if !(isempty(val)) && last(val) == 'Z'
        val = String(chop(val))
    end
    return convert(Union{Dates.DateTime,Nothing}, Dates.DateTime(val))
end
