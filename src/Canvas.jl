"""
    Canvas

Julia package for interacting with the Canvas API.
"""
module Canvas

import HTTP, JSON, Dates

##################
# Authentication #
##################
mutable struct OAuth2
    token::Base.SecretBuffer
    function OAuth2(sb::Base.SecretBuffer)
        finalizer(x -> Base.shred!(x), sb)
        return new(sb)
    end
end
OAuth2(str::String) = OAuth2(Base.SecretBuffer(str))
OAuth2() = OAuth2(ENV["CANVAS_TOKEN"])

################
# API endpoint #
################

struct CanvasAPI
    uri::HTTP.URI
    auth::Union{OAuth2,Nothing}
end
CanvasAPI(uri::HTTP.URI; auth::Union{OAuth2,Nothing}=nothing) = CanvasAPI(uri, auth)
CanvasAPI(str::String; auth::Union{OAuth2,Nothing}=nothing) = CanvasAPI(HTTP.URI(str), auth)

# Set Authorization and User-Agent
function update_headers(headers, api::CanvasAPI)
    if !haskey(headers, "Authorization") && api.auth !== nothing
        headers["Authorization"] = "Bearer $(String(copy(api.auth.token.data)))"
    end
    if !haskey(headers, "User-Agent")
        headers["User-Agent"] = "Canvas.jl"
    end
    return headers
end

# function get(api::CanvasAPI, endpoint::String=""; kwargs...)
#     return request("GET", api, endpoint; kwargs...)
# end

function request(method::String, api::CanvasAPI, endpoint::String="";
                 headers=Dict{String, String}(), kwargs...)
    headers = update_headers(headers, api)
    uri = HTTP.merge(api.uri, path=endpoint)
    r = HTTP.request(method, uri, headers; kwargs...)
    return r
end

function paged_request(method::String, api::CanvasAPI, endpoint::String="";
                       headers=Dict{String, String}(), page_limit=typemax(Int),
                       start_page="", query=nothing, kwargs...)
    headers = update_headers(headers, api)
    if isempty(start_page) # first request
        uri = HTTP.merge(api.uri, path=endpoint)
        r = HTTP.request(method, uri, headers; query=query, kwargs...)
    else
        # isempty(endpoint) || throw(ArgumentError("`start_page` kwarg is incompatible with `endpoint` argument"))
        query === nothing || throw(ArgumentError("`start_page` kwarg is incompatible with `query` kwarg"))
        r = HTTP.request(method, start_page, headers; kwargs...)
    end
    rs = [r]
    page_data = Dict{String, String}()
    if HTTP.hasheader(r, "Link")
        page_count = 1
        while page_count < page_limit
            links = split(HTTP.header(r, "Link"), ",")
            idx = findfirst(x->occursin("rel=\"next\"", x), links)
            idx === nothing && break
            r = HTTP.request(method, match(r"<(.*)>", links[idx]).captures[1], headers; kwargs...)
            push!(rs, r)
            page_count += 1
        end
        links = split(HTTP.header(r, "Link"), ",")
        for page in ("current", "next", "prev", "first", "last")
            idx = findfirst(x->occursin("rel=\"$(page)\"", x), links)
            if idx !== nothing
                page_data[page] = match(r"<(.*)>", links[idx]).captures[1]
            end
        end
    end
    return rs, page_data
end

# function canvas_get_json(api::CanvasAPI, endpoint=""; kwargs...)
#     r = canvas_get(api, endpoint; kwargs...)
#     return JSON.parse(payload)
# end

##################
# Canvas Objects #
##################
abstract type CanvasObject end

struct Course <: CanvasObject
    id::Union{Int,Nothing}
    sis_course_id::Union{String,Nothing}
    uuid::Union{String,Nothing}
    integration_id::Union{String,Nothing}
    sis_import_id::Union{Int,Nothing}
    name::Union{String,Nothing}
    course_code::Union{String,Nothing}
    workflow_state::Union{String,Nothing}
    account_id::Union{Int,Nothing}
    root_account_id::Union{Int,Nothing}
    enrollment_term_id::Union{Int,Nothing}
    grading_standard_id::Union{Int,Nothing}
    grade_passback_setting::Union{String,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    start_at::Union{Dates.DateTime,Nothing}
    end_at::Union{Dates.DateTime,Nothing}
    locale::Union{String,Nothing}
    enrollments::Union{Vector{Dict},Nothing}
    total_students::Union{Int,Nothing}
    calendar::Union{Vector{Dict},Nothing}
    default_view::Union{String,Nothing}
    syllabus_body::Union{String,Nothing}
    needs_grading_count::Union{Int,Nothing}
end

#### GitHub.jl ####
unwrap_union_types(T) = T
unwrap_union_types(T::Union) = T.a === Nothing ? T.b : T.a

function extract_nullable(data::Dict, key, ::Type{T}) where {T}
    # @show key
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
#### GitHub.jl ####

#####################
# Exposed endpoints #
#####################
function courses(api::CanvasAPI; kwargs...)
    rs, page_data = paged_request("GET", api, "/api/v1/courses"; kwargs...)
    cs = Canvas.Course[]
    for r in rs
        append!(cs, map(x->Canvas.json2canvas(Canvas.Course, x), JSON.parse(HTTP.payload(r, String))))
    end
    return cs, page_data
end

end # module
