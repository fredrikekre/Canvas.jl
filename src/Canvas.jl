"""
    Canvas

Julia package for interacting with the Canvas API.
"""
module Canvas

import HTTP, JSON, Dates

####################
## Authentication ##
####################
mutable struct OAuth2
    token::Base.SecretBuffer
    function OAuth2(sb::Base.SecretBuffer)
        finalizer(x -> Base.shred!(x), sb)
        return new(sb)
    end
end
OAuth2(str::String) = OAuth2(Base.SecretBuffer(str))
OAuth2() = OAuth2(ENV["CANVAS_TOKEN"])

##################
## API endpoint ##
##################
struct CanvasAPI
    uri::HTTP.URI
    auth::Union{OAuth2,Nothing}
end
CanvasAPI(uri::HTTP.URI; auth::Union{OAuth2,Nothing}=nothing) = CanvasAPI(uri, auth)
CanvasAPI(str::String; auth::Union{OAuth2,Nothing}=nothing) = CanvasAPI(HTTP.URI(str), auth)

# Default API
const API = Ref{CanvasAPI}()
setapi!(api::CanvasAPI) = API[] = api
function getapi()
    if isassigned(API)
        return API[]
    else
        throw(ArgumentError("no default CanvasAPI set; see `Canvas.setapi!`."))
    end
end

###############
## Utilities ##
###############

# Set Authorization and User-Agent
function update_headers!(headers, api::CanvasAPI)
    if !haskey(headers, "Authorization") && api.auth !== nothing
        headers["Authorization"] = "Bearer $(String(copy(api.auth.token.data)))"
    end
    if !haskey(headers, "User-Agent")
        headers["User-Agent"] = "Canvas.jl"
    end
    return headers
end

function request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                 headers=Dict{String, String}(), params=nothing, kwargs...)
    update_headers!(headers, api)
    uri = HTTP.merge(api.uri, path=endpoint)
    r = HTTP.request(method, uri, headers; query=params, kwargs...)
    return r
end

function paged_request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                       headers=Dict{String, String}(), page_limit=typemax(Int),
                       start_page="", params=nothing, kwargs...)
    update_headers!(headers, api)
    if isempty(start_page) # first request
        uri = HTTP.merge(api.uri, path=endpoint)
        r = HTTP.request(method, uri, headers; query=params, kwargs...)
    else
        # isempty(endpoint) || throw(ArgumentError("`start_page` kwarg is incompatible with `endpoint` argument"))
        params === nothing || throw(ArgumentError("`start_page` kwarg is incompatible with `params` kwarg"))
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

function request_to_canvas(@nospecialize(C), r::HTTP.Response)
    @assert C <: CanvasObject
    c = C(JSON.parse(HTTP.payload(r, String)))
    return c
end
function request_to_canvas(@nospecialize(C::Type{<:Vector}), r::HTTP.Response)
    C′ = first(C.parameters)
    @assert C′ <: CanvasObject
    c = C′[C′(x) for x in JSON.parse(HTTP.payload(r, String))]
    return c
end
function request_to_canvas(@nospecialize(C), rs::Vector{<:HTTP.Response})
    @assert C <: CanvasObject
    cs = C[]
    for r in rs, c in JSON.parse(HTTP.payload(r, String))
        push!(cs, C(c))
    end
    return cs
end

# function canvas_get_json(api::CanvasAPI, endpoint=""; kwargs...)
#     r = canvas_get(api, endpoint; kwargs...)
#     return JSON.parse(payload)
# end

include("canvas_objects.jl")
include("github.jl")

#####################
# Exposed endpoints #
#####################

"""
    courses(; kwargs...) -> Vector{Course}, page_data

Access the `/api/v1/courses` endpoint.
"""
function courses(; api::CanvasAPI=getapi(), kwargs...)
    rs, page_data = paged_request("GET", "/api/v1/courses"; api=api, kwargs...)
    return request_to_canvas(Course, rs), page_data
end

"""
    course(c; kwargs...) -> Course

Access the `/api/v1/courses/:id` endpoint, where `:id`
is determined by the `c` argument.
"""
function course(c; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/courses/$(id(c))"; api=api, kwargs...)
    return request_to_canvas(Course, r)
end

"""
    files(c; kwargs...) -> Vector{File}, page_data

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function files(c; api::CanvasAPI=getapi(), kwargs...)
    rs, page_data = paged_request("GET", "/api/v1/courses/$(id(c))/files"; api=api, kwargs...)
    return request_to_canvas(File, rs), page_data
end

"""
    file(f; kwargs...) -> File

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function file(f; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/files/$(id(f))"; api=api, kwargs...)
    return request_to_canvas(File, r)
end

function download(f::File, path=tempdir(); kwargs...)
    mkpath(path)
    r = HTTP.download(f.url, joinpath(path, f.display_name); kwargs...)
    return r
end

function announcements(c; api::CanvasAPI=getapi(), query=nothing, kwargs...)
    query = something(query, Dict("context_codes"=>"course_$(id(c))"))
    rs, page_data = paged_request("GET", "/api/v1/announcements"; api=api, query=query, kwargs...)
    return request_to_canvas(DiscussionTopic, rs), page_data
end
function create_announcement(c; api::CanvasAPI=getapi(), kwargs...)
    r = request("POST", "/api/v1/courses/$(id(c))/discussion_topics"; api=api, kwargs...)
    return request_to_canvas(DiscussionTopic, r)
end

function create_conversation(c; api::CanvasAPI=getapi(), params::Dict, kwargs...)
    if !haskey(params, "recipients[]")
        params = Dict("recipients[]"=>["$(id(c))"], params...)
    end
    r = request("POST", "/api/v1/conversations"; api=api, params=params, kwargs...)
    return request_to_canvas(Vector{Conversation}, r)
end

function whoami(; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/users/self"; api=api, kwargs...)
    return request_to_canvas(User, r)
end

function user(u; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/users/$(id(u))"; api=api, kwargs...)
    return request_to_canvas(User, r)
end

function conversations(; api::CanvasAPI=getapi(), kwargs...)
    rs, page_data = paged_request("GET", "/api/v1/conversations"; api=api, kwargs...)
    return request_to_canvas(Conversation, rs), page_data
end

function conversation(c; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/conversations/$(id(c))"; api=api, kwargs...)
    return request_to_canvas(Conversation, r)
end


end # module
