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
    json = JSON.parse(HTTP.payload(r, String))
    return json
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
    json = JSON.parse(HTTP.payload(r, String))
    page_data = Dict{String, String}()
    if HTTP.hasheader(r, "Link")
        page_count = 1
        while page_count < page_limit
            links = split(HTTP.header(r, "Link"), ",")
            idx = findfirst(x->occursin("rel=\"next\"", x), links)
            idx === nothing && break
            r = HTTP.request(method, match(r"<(.*)>", links[idx]).captures[1], headers; kwargs...)
            json′ = JSON.parse(HTTP.payload(r, String))
            append!(json, json′)
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
    return json, page_data
end

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
    json, page_data = paged_request("GET", "/api/v1/courses"; api=api, kwargs...)
    return Course.(json), page_data
end

"""
    course(c; kwargs...) -> Course

Access the `/api/v1/courses/:id` endpoint, where `:id`
is determined by the `c` argument.
"""
function course(c; api::CanvasAPI=getapi(), kwargs...)
    json = request("GET", "/api/v1/courses/$(id(c))"; api=api, kwargs...)
    return Course(json)
end

"""
    files(c; kwargs...) -> Vector{File}, page_data

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function files(c; api::CanvasAPI=getapi(), kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(c))/files"; api=api, kwargs...)
    return File.(json), page_data
end

"""
    file(f; kwargs...) -> File

Access the `/api/v1/courses/:course_id/files` endpoint,
where `:course_id` is determined by the `c` argument.
"""
function file(f; api::CanvasAPI=getapi(), kwargs...)
    json = request("GET", "/api/v1/files/$(id(f))"; api=api, kwargs...)
    return File(json)
end

function download(f::File, path=tempdir(); kwargs...)
    mkpath(path)
    r = HTTP.download(f.url, joinpath(path, f.display_name); kwargs...)
    return r
end

function announcements(c; api::CanvasAPI=getapi(), query=nothing, kwargs...)
    query = something(query, Dict("context_codes"=>"course_$(id(c))"))
    json, page_data = paged_request("GET", "/api/v1/announcements"; api=api, query=query, kwargs...)
    return DiscussionTopic.(json), page_data
end
function create_announcement(c; api::CanvasAPI=getapi(), kwargs...)
    json = request("POST", "/api/v1/courses/$(id(c))/discussion_topics"; api=api, kwargs...)
    return DiscussionTopic(json)
end

function create_conversation(c; api::CanvasAPI=getapi(), params::Dict, kwargs...)
    if !haskey(params, "recipients[]")
        params = Dict("recipients[]"=>["$(id(c))"], params...)
    end
    json = request("POST", "/api/v1/conversations"; api=api, params=params, kwargs...)
    @assert length(json) == 1
    return Conversation(json[1])
end

function whoami(; api::CanvasAPI=getapi(), kwargs...)
    json = request("GET", "/api/v1/users/self"; api=api, kwargs...)
    return User(json)
end

function user(u; api::CanvasAPI=getapi(), kwargs...)
    json = request("GET", "/api/v1/users/$(id(u))"; api=api, kwargs...)
    return User(json)
end

function conversations(; api::CanvasAPI=getapi(), kwargs...)
    json, page_data = paged_request("GET", "/api/v1/conversations"; api=api, kwargs...)
    return Conversation.(json), page_data
end

function conversation(c; api::CanvasAPI=getapi(), kwargs...)
    json = request("GET", "/api/v1/conversations/$(id(c))"; api=api, kwargs...)
    return Conversation(json)
end

function upload_file(c, file; api::CanvasAPI=getapi(), params::Dict=Dict(), headers=Dict{String, String}(), kwargs...)
    get!(params, "name", basename(file))
    get!(params, "size", stat(file).size)
    # update_headers!(headers, api)
    # uri = HTTP.merge(api.uri, path="/api/v1/courses/$(id(c))/files")
    # r = HTTP.request("POST", uri, headers; query=params, kwargs...)

    # Step 1: ...
    json = request("POST", "/api/v1/courses/$(id(c))/files"; api=api, params=params, kwargs...)
    # Step 2: ...
    uri = HTTP.URI(json["upload_url"])
    io = open(file)
    multipart = HTTP.Multipart(json["upload_params"]["filename"], io, json["upload_params"]["content_type"])
    # query = join((uri.query, HTTP.escapeuri(json["upload_params"]), HTTP.escapeuri("file"=>"@$(file)")), "&")
    # uri = merge(uri; )
    json["upload_params"]["file"] = multipart
    form = HTTP.Form(json["upload_params"])
    req = HTTP.request("POST", uri, Dict("User-Agent"=>"Canvas.jl"), body=json["upload_params"])
end

# function request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
#                  headers=Dict{String, String}(), params=nothing, kwargs...)
#     json = JSON.parse(HTTP.payload(r, String))
#     return json
# end


end # module
