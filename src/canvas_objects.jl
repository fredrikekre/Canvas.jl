####################
## Canvas Objects ##
####################
abstract type CanvasObject end

include("autogenerated_structs.jl")

# General constructors from dicts and kwargs...
(::Type{CO})(dict) where {CO<:CanvasObject} = Internals.json2canvas(CO, dict)
(::Type{CO})(; kwargs...) where {CO<:CanvasObject} = Internals.json2canvas(CO, kwargs)

# Extract id
Internals.id(x::Int) = x
Internals.id(x::CanvasObject) = x.id
# Get the endpoint path + id
Internals.pid(x::Account) = "/accounts/$(Internals.id(x))"
Internals.pid(x::Assignment) = "/assignments/$(Internals.id(x))"
Internals.pid(x::AssignmentOverride) = "/overrides/$(Internals.id(x))"
Internals.pid(x::Course) = "/courses/$(Internals.id(x))"
Internals.pid(x::File) = "/files/$(Internals.id(x))"
Internals.pid(x::Folder) = "/folders/$(Internals.id(x))"
Internals.pid(x::Group) = "/groups/$(Internals.id(x))"
Internals.pid(x::User) = "/users/$(Internals.id(x))"

# namefield(x) = nothing
function Base.show(io::IO, o::CanvasObject)
    if get(io, :compact, false)
        # uri_id = namefield(o)
        if true # uri_id === nothing
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
function Internals.json2canvas(::Type{CO}, data::AbstractDict{T}) where {CO<:CanvasObject,T}
    # Make sure the struct does not miss any fields
    for k in keys(data)
        if !(Symbol(k) ∈ fieldnames(CO))
            @debug "key `$(k)` missing from `$(CO)` struct definition" CO key=k value=data[k]
        end
    end
    # @assert all(k->Symbol(k) ∈ fieldnames(CO), keys(data))
    CO((begin
            v = get(data, T(x), nothing)
            if v === nothing
                nothing
            else
                # https://github.com/JuliaLang/julia/issues/269
                S = Internals.adjust_fieldtype(fieldtype(CO, x), CO, x)
                Internals.convert′(S, v)
            end
        end
        for x in fieldnames(CO))...)
end

# Work around https://github.com/JuliaLang/julia/issues/269
Internals.adjust_fieldtype(::Type{T}, ::Type, ::Symbol) where T = T

Internals.convert′(::Type{T}, val::T) where T = val
Internals.convert′(::Type{T}, val) where T = error("T=$T, val=$val")
function Internals.convert′(::Type{Union{CO,Nothing}}, val) where CO <: CanvasObject
    return CO(val)
end
function Internals.convert′(::Type{Union{Vector{CO},Nothing}}, val) where CO <: CanvasObject
    return CO.(val)
end
function Internals.convert′(::Type{Union{TimeZones.ZonedDateTime,Nothing}}, val)
    df = Dates.dateformat"yyyy-mm-ddTHH:MM:SSz"
    zdt = parse(TimeZones.ZonedDateTime, val, df)
    zdt′ = TimeZones.astimezone(zdt, TimeZones.localzone())
    return convert(Union{TimeZones.ZonedDateTime,Nothing}, zdt′)
end
function Internals.convert′(::Type{Union{Dates.Date,Nothing}}, val)
    df = Dates.dateformat"yyyy-mm-dd"
    d = parse(Dates.Date, val, df)
    return convert(Union{Dates.Date,Nothing}, d)
end
