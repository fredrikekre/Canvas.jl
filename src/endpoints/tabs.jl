# This file roughly corresponds to functions documented in the
# Tabs API: https://canvas.instructure.com/doc/api/tabs

"""
    Canvas.tabs(c::Union{Course,Group,User}; kwargs...) -> Vector{Tab}, page_data

Return the paginated list of tabs for the course/group/user.
Return a vector of [`Tab`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List available tabs for a course or group (`GET /api/v1/courses/:course_id/tabs`,
`GET /api/v1/groups/:group_id/tabs`, `GET /api/v1/users/:user_id/tabs`)]
(https://canvas.instructure.com/doc/api/tabs#method.tabs.index)
"""
function tabs(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/tabs"; kwargs...)
    return Tab.(json), page_data
end

"""
    Canvas.update_tab(c::Course, t::Tab; kwargs...) -> Tab

Modify an existing tab and return the new details. Return a [`Tab`](@ref).

**Canvas API documentation**:
[Update a tab for a course (`PUT /api/v1/courses/:course_id/tabs/:tab_id`)]
(https://canvas.instructure.com/doc/api/tabs#method.tabs.update)
"""
function update_tab(c::Course, t::Tab; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(c))$(Internals.pid(t))"; kwargs...)
    return Tab(json)
end
