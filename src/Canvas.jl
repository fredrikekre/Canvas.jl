"""
    Canvas

Julia package for interacting with the Canvas API.
"""
module Canvas

import HTTP, JSON

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

function update_headers!(headers, api::CanvasAPI)
    headers = convert(Dict{String, String}, headers)
    if !haskey(headers, "Authorization") && api.auth !== nothing
        headers["Authorization"] = "Bearer $(String(copy(api.auth.token.data)))"
    end
    if !haskey(headers, "User-Agent")
        headers["User-Agent"] = "Canvas.jl"
    end
    return headers
end

function get(api::CanvasAPI, endpoint="";
                   headers=Dict{String, String}(), params=Dict{String,String}(), start_page="")
    update_headers!(headers, api)

    url = HTTP.merge(api.uri, path=endpoint, query=params)
    r = HTTP.get(url, headers)
    payload = HTTP.payload(r, String)
    return JSON.parse(payload)
end

function paged_get(api::CanvasAPI, endpoint="";
                   headers=Dict{String, String}(), params=Dict{String,String}(), start_page="", page_limit=typemax(Int))
    headers = update_headers!(headers, api)
    if isempty(start_page) # first request
        url = HTTP.merge(api.uri, path=endpoint, query=params)
        r = HTTP.get(url, headers)
    else
        isempty(params) || throw(ArgumentError("`start_page` kwarg is incompatible with `params` kwarg"))
        r = HTTP.get(start_page, headers)
    end
    payload = HTTP.payload(r, String)
    results = JSON.parse(payload) # append to this
    page_data = Dict{String, String}()
    if HTTP.hasheader(r, "Link")
        page_count = 1
        while page_count < page_limit
            links = split(HTTP.header(r, "Link"), ",")
            idx = findfirst(x->occursin("rel=\"next\"", x), links)
            idx === nothing && break
            r = HTTP.get(match(r"<(.*)>", links[idx]).captures[1], headers)
            payload = HTTP.payload(r, String)
            append!(results, JSON.parse(payload))
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
    return results, page_data
end

# function canvas_get_json(api::CanvasAPI, endpoint=""; kwargs...)
#     r = canvas_get(api, endpoint; kwargs...)
#     return JSON.parse(payload)
# end


#####################
# Exposed endpoints #
#####################
function courses(api::CanvasAPI; kwargs...)
    return paged_get(api, "/api/v1/courses"; kwargs...)
end

end # module
