"""
    Canvas.jl

Julia package for interacting with the Canvas LMS API.
See https://fredrikekre.github.io/Canvas.jl/ for documentation.
"""
module Canvas

import HTTP, JSON, Dates, TimeZones, URIs

include("Internals.jl")

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
    uri::URIs.URI
    auth::OAuth2
    CanvasAPI(uri, auth) = new(URIs.URI(uri), OAuth2(auth))
end

# Default API
const API = Ref{CanvasAPI}()
setapi!(api::CanvasAPI) = API[] = api
function getapi()
    if isassigned(API)
        return API[]
    else # try to set
        url = get(ENV, "CANVAS_URL", nothing)
        auth = get(ENV, "CANVAS_TOKEN", nothing)
        if url !== nothing && auth !== nothing
            try
                setapi!(Canvas.CanvasAPI(url, auth))
                return getapi()
            catch
                @warn "Both ENV[\"CANVAS_URL\"] and ENV[\"CANVAS_TOKEN\"] found " *
                      "but did not manage to initialize the default API."
            end
        end
        throw(ArgumentError("no default CanvasAPI set"))
    end
end

################################
## Internal request utilities ##
################################

# Set Authorization and User-Agent
function Internals.canvas_headers(headers=nothing; auth=nothing)
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

# Preprocess parameters before sending them to HTTP.jl
Internals.process_params(params::Union{AbstractString,Nothing}) = params
function Internals.process_params(params)
    params′ = Dict{String,Any}()
    # Assume it iterates pairs
    for (k, v) in params
        params′[Internals.process_key(k)] = Internals.process_val(v)
    end
    return params′
end
Internals.process_key(k) = string(k)
Internals.process_val(v) = string(v)
Internals.process_val(v::AbstractVector) = map(Internals.process_val, v)
function Internals.process_val(zdt::TimeZones.ZonedDateTime)
    zdt = TimeZones.astimezone(zdt, TimeZones.tz"Z")
    str = Dates.format(zdt, Dates.dateformat"yyyy-mm-ddTHH:MM:SSZ")
    return str
end

############################
## Public request methods ##
############################

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
Get a single course
```julia
Canvas.request("GET", "/api/v1/courses/:course_id")
```

Post an announcement
```julia
params = Dict(
    "title" => "Hello there!",
    "message" => "General Kenobi!",
    "is_announcement" => true,
)
Canvas.request("POST", "/api/v1/courses/:course_id/discussion_topics"; params=params)
```
"""
function request(method::String, endpoint::String=""; kwargs...)
    r = Internals.request(method, endpoint; kwargs...)
    json = JSON.parse(IOBuffer(HTTP.payload(r)))
    return json
end
# Internal request method, returning a HTTP.Response
function Internals.request(method::String, endpoint::String=""; api::CanvasAPI=getapi(),
                           headers=nothing, params=nothing, kwargs...)
    headers = Internals.canvas_headers(headers; auth=api.auth)
    uri = URIs.URI(api.uri, path=endpoint)
    params = Internals.process_params(params)
    r = HTTP.request(method, uri, headers; query=params, kwargs...)
    @assert !HTTP.hasheader(r, "Link")
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
    rs, page_data = Internals.paged_request(method, endpoint; kwargs...)
    # Assume we get an JSON array in each request
    json = mapreduce(r->JSON.parse(IOBuffer(HTTP.payload(r))), append!, rs; init=Dict{String,Any}[])
    return json, page_data
end
# Internal request method for pagination, returning Vector{HTTP.Response} and page_data
function Internals.paged_request(
        method::String, endpoint::String=""; api::CanvasAPI=getapi(),
        headers=nothing, page_limit=typemax(Int),
        start_page="", params=nothing, kwargs...)
    headers = Internals.canvas_headers(headers; auth=api.auth)
    if isempty(start_page) # first request
        uri = URIs.URI(api.uri, path=endpoint)
        params = Internals.process_params(params)
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

#####################
# Exposed endpoints #
#####################
include("endpoints/file_uploads.jl")
include("endpoints/assignments.jl")
include("endpoints/courses.jl")
include("endpoints/files.jl")
include("endpoints/submissions.jl")
include("endpoints/submission_comments.jl")
include("endpoints/users.jl")
include("endpoints/tabs.jl")
# include("endpoints/groups.jl")

# function download(f::File, path=tempdir(); kwargs...)
#     mkpath(path)
#     r = HTTP.download(f.url, joinpath(path, f.display_name); kwargs...)
#     return r
# end

# function announcements(c; params=nothing, kwargs...)
#     params = something(params, Dict("context_codes"=>"course_$(Internals.id(c))"))
#     json, page_data = paged_request("GET", "/api/v1/announcements"; params=params, kwargs...)
#     return DiscussionTopic.(json), page_data
# end
# function create_announcement(c::Course; kwargs...)
#     json = request("POST", "/api/v1$(Internals.pid(c))/discussion_topics"; kwargs...)
#     return DiscussionTopic(json)
# end

# function create_conversation(c; params::Dict, kwargs...)
#     if !haskey(params, "recipients[]")
#         params = Dict("recipients[]"=>["$(Internals.id(c))"], params...)
#     end
#     json = request("POST", "/api/v1/conversations"; params=params, kwargs...)
#     @assert length(json) == 1
#     return Conversation(json[1])
# end

# function conversations(; kwargs...)
#     json, page_data = paged_request("GET", "/api/v1/conversations"; kwargs...)
#     return Conversation.(json), page_data
# end

# function conversation(c; kwargs...)
#     json = request("GET", "/api/v1$(Internals.pid(c))"; kwargs...)
#     return Conversation(json)
# end

end # module
