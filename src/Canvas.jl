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
end
CanvasAPI(str::String) = CanvasAPI(HTTP.URI(str))

function authenticate_headers!(headers, auth::Union{Nothing,OAuth2})
    if auth !== nothing
        headers["Authorization"] = "Bearer $(String(copy(auth.token.data)))"
    end
    !haskey(headers, "User-Agent") && (headers["User-Agent"] = "Canvas.jl")
    return headers
end

function canvas_get(api::CanvasAPI, endpoint=""; headers=Dict(), params=Dict(), auth::Union{Nothing,OAuth2}=nothing)
    headers = convert(Dict{String, String}, headers)
    authenticate_headers!(headers, auth)
    url = HTTP.merge(api.uri, path=endpoint, query=params)
    r = HTTP.get(url, headers)
    return r
end

function canvas_get_json(api::CanvasAPI, endpoint=""; kwargs...)
    r = canvas_get(api, endpoint; kwargs...)
    payload = HTTP.payload(r, String)
    return JSON.parse(payload)
end


#####################
# Exposed endpoints #
#####################
function courses(api; auth::Union{Nothing,OAuth2}=nothing, params=Dict())
    canvas_get_json(api, "/api/v1/courses"; auth=auth, params=params)
end

end # module
