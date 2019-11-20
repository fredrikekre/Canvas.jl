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
    function OAuth2(auth::Base.SecretBuffer)
        finalizer(x -> Base.shred!(x), auth)
        return new(auth)
    end
    OAuth2(auth::String) = OAuth2(Base.SecretBuffer(auth))
    OAuth2(auth::OAuth2) = auth
end

##################
## API endpoint ##
##################
struct CanvasAPI
    uri::HTTP.URI
    auth::OAuth2
    CanvasAPI(uri, auth) = new(HTTP.URI(uri), OAuth2(auth))
end

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

function __init__()
    url = get(ENV, "CANVAS_URL", nothing)
    auth = get(ENV, "CANVAS_TOKEN", nothing)
    if url !== nothing && auth !== nothing
        try
            setapi!(Canvas.CanvasAPI(url, auth))
        catch
            @warn "Both ENV[\"CANVAS_URL\"] and ENV[\"CANVAS_TOKEN\"] found " *
                  "but did not manage to initialize the default API."
        end
    end
end

###############
## Utilities ##
###############

# Set Authorization and User-Agent
function canvas_headers(headers=nothing; auth=nothing)
    if headers === nothing
        headers = Dict{String,String}()
    else
        headers = Dict{String,String}(h for h in headers)
    end
    if isa(auth, OAuth2) && !haskey(headers, "Authorization")
        headers["Authorization"] = "Bearer $(String(copy(auth.token.data)))"
    end
    if !haskey(headers, "User-Agent")
        headers["User-Agent"] = "Canvas.jl" # Always overwrite this?
    end
    return headers
end

"""
    Canvas.request(method, endpoint; kwargs...) -> JSON

General method for HTTP requests to `endpoint`.
Return the resulting JSON structure.

**Keyword arguments:**

 - `api`: the Canvas API with authentication;
 - `params`: dictionary with request parameters.

Remaining keyword arguments are passed to
[`HTTP.request`](https://juliaweb.github.io/HTTP.jl/stable/public_interface/#Requests-1).

**Examples**
```julia
# Get a single course
Canvas.request("GET", "/api/v1/courses/:course_id")

# Post an announcement
params = Dict(
    "title" => "Hello there!",
    "message" => "General Kenobi!",
    "is_announcement" => true,
)
Canvas.request("POST", "/api/v1/courses/:course_id/discussion_topics"; params=params)
```
"""
function request(method::String, endpoint::String=""; kwargs...)
    r = _request(method, endpoint; kwargs...)
    json = JSON.parse(IOBuffer(HTTP.payload(r)))
    return json
end
# Internal request method, returning a HTTP.Response
function _request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                 headers=nothing, params=nothing, kwargs...)
    headers = canvas_headers(headers; auth=api.auth)
    uri = HTTP.merge(api.uri, path=endpoint)
    r = HTTP.request(method, uri, headers; query=params, kwargs...)
    return r
end

"""
    Canvas.paged_request(method, endpoint; kwargs...)

General method for HTTP requests to `endpoint`.
Return the resulting JSON structure and a dictionary
with page data with links.

# Examples
```julia
Canvas.request("GET", "/api/v1/courses")
```
"""
function paged_request(method::String, endpoint::String=""; kwargs...)
    rs, page_data = _paged_request(method, endpoint; kwargs...)
    # Assume we get an JSON array in each request
    json = mapreduce(r->JSON.parse(IOBuffer(HTTP.payload(r))), append!, rs; init=Dict{String,Any}[])
    return json, page_data
end
# Internal request method for pagination, returning Vector{HTTP.Response} and page_data
function _paged_request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                       headers=nothing, page_limit=typemax(Int),
                       start_page="", params=nothing, kwargs...)
    headers = canvas_headers(headers; auth=api.auth)
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

##################
# Canvas objects #
##################
include("canvas_objects.jl")
include("autogenerated_objects.jl")

#####################
# Exposed endpoints #
#####################
include("endpoints/courses.jl")
include("endpoints/files.jl")

"""
    files(c; kwargs...) -> Vector{File}, page_data

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function files(c; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(c))/files"; kwargs...)
    return File.(json), page_data
end

"""
    file(f; kwargs...) -> File

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function file(f; kwargs...)
    json = request("GET", "/api/v1/files/$(id(f))"; kwargs...)
    return File(json)
end

function download(f::File, path=tempdir(); kwargs...)
    mkpath(path)
    r = HTTP.download(f.url, joinpath(path, f.display_name); kwargs...)
    return r
end

function announcements(c; params=nothing, kwargs...)
    params = something(params, Dict("context_codes"=>"course_$(id(c))"))
    json, page_data = paged_request("GET", "/api/v1/announcements"; params=params, kwargs...)
    return DiscussionTopic.(json), page_data
end
function create_announcement(c; kwargs...)
    json = request("POST", "/api/v1/courses/$(id(c))/discussion_topics"; kwargs...)
    return DiscussionTopic(json)
end

function create_conversation(c; params::Dict, kwargs...)
    if !haskey(params, "recipients[]")
        params = Dict("recipients[]"=>["$(id(c))"], params...)
    end
    json = request("POST", "/api/v1/conversations"; params=params, kwargs...)
    @assert length(json) == 1
    return Conversation(json[1])
end

function whoami(; kwargs...)
    json = request("GET", "/api/v1/users/self"; kwargs...)
    return User(json)
end

function user(u; kwargs...)
    json = request("GET", "/api/v1/users/$(id(u))"; kwargs...)
    return User(json)
end

function conversations(; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/conversations"; kwargs...)
    return Conversation.(json), page_data
end

function conversation(c; kwargs...)
    json = request("GET", "/api/v1/conversations/$(id(c))"; kwargs...)
    return Conversation(json)
end


function download_file(f::File, local_path=mktempdir(); update_period=Inf, kwargs...)
    if isdir(local_path) # existing directory, append filename
        local_path = joinpath(local_path, f.filename)
    elseif !isdir(dirname(local_path)) # a filepath, make sure directory exist
        error("destination directory does not exist; $(dirname(local_path))")
    end
    headers = canvas_headers()
    r = HTTP.download(f.url, local_path, headers; update_period=update_period, kwargs...)
    return r
end

function delete_file(f::File; kwargs...)
    json = request("DELETE", "/api/v1/files/$(id(f))"; kwargs...)
    return File(json)
end

end # module
