# This file roughly corresponds to functions documented in the

"""
    Canvas.groups(co::Course; kwargs...) -> ????


"""
function groups(co::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/groups"; kwargs...)
    return Group.(json), page_data
end
