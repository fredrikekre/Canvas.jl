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
                 headers=Dict{String, String}(), kwargs...)
    update_headers!(headers, api)
    uri = HTTP.merge(api.uri, path=endpoint)
    r = HTTP.request(method, uri, headers; kwargs...)
    return r
end

function paged_request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                       headers=Dict{String, String}(), page_limit=typemax(Int),
                       start_page="", query=nothing, kwargs...)
    update_headers!(headers, api)
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
    cs = Course[]
    for r in rs
        append!(cs, map(Course, JSON.parse(HTTP.payload(r, String))))
    end
    return cs, page_data
end

"""
    course(c; kwargs...) -> Course

Access the `/api/v1/courses/:id` endpoint, where `:id`
is determined by the `c` argument.
"""
function course(c; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/courses/$(id(c))"; api=api, kwargs...)
    c = Course(JSON.parse(HTTP.payload(r, String)))
    return c
end

"""
    files(c; kwargs...) -> Vector{File}, page_data

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function files(c; api::CanvasAPI=getapi(), kwargs...)
    rs, page_data = paged_request("GET", "/api/v1/courses/$(id(c))/files"; api=api, kwargs...)
    fs = File[]
    for r in rs
        append!(fs, map(File, JSON.parse(HTTP.payload(r, String))))
    end
    return fs, page_data
end

"""
    file(f; kwargs...) -> File

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function file(f; api::CanvasAPI=getapi(), kwargs...)
    r = request("GET", "/api/v1/files/$(id(f))"; api=api, kwargs...)
    f = File(JSON.parse(HTTP.payload(r, String)))
    return f
end

function download(f::File, path=tempdir(); kwargs...)
    mkpath(path)
    r = HTTP.download(f.url, joinpath(path, f.display_name); kwargs...)
    return r
end

end # module
