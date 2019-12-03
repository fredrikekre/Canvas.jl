# This file roughly corresponds to functions documented in the
# Assignments API: https://canvas.instructure.com/doc/api/assignments

"""
    Canvas.delete_assignment(co::Union{Course,Group,User}; kwargs...) -> Assignment

**Request endpoint:** `DELETE /api/v1/courses/:course_id/assignments/:id`

**Canvas API documentation:**
[*Delete an assignment*](https://canvas.instructure.com/doc/api/assignments#method.assignments.destroy)
"""
function delete_assignment(c::Course, a::Assignment; kwargs...)
    json = request("DELETE", "/api/v1$(pid(c))$(pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.assignments(c::Course; kwargs...) -> Vector{Assignment}, page_data

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments`

**Canvas API documentation:**
[*List assignments*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.index)
"""
function assignments(c::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(c))/assignments"; kwargs...)
    return Assignment.(json), page_data
end
# TODO collapse ^ and below
"""
    Canvas.assignments(c::Course, a::AssignmentGroup; kwargs...) -> Vector{Assignment}, page_data

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments`

**Canvas API documentation:**
[*List assignments*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.index)
"""
function assignments(c::Course, a::AssignmentGroup; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(c))$(pid(a))/assignments"; kwargs...)
    return Assignment.(json), page_data
end

"""
    Canvas.assignments(u::User, c::Course; kwargs...) -> Vector{Assignment}, page_data

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments`

**Canvas API documentation:**
[*List assignments for user*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.user_index)
"""
function assignments(u::User, c::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(u))$(pid(c))/assignments"; kwargs...)
    return Assignment.(json), page_data
end

"""
    Canvas.assignment(c::Course, a::Assignment; kwargs...) -> Assignment

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments/:id`

**Canvas API documentation:**
[*Get a single assignment*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.show)
"""
function assignment(c::Course, a::Assignment; kwargs...)
    json = request("GET", "/api/v1$(pid(c))$(pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.create_assignment(c::Course, a::Assignment; kwargs...) -> Assignment

**Request endpoint:** `POST /api/v1/courses/:course_id/assignments`

**Canvas API documentation:**
[*Create an assignment*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.create)
"""
function create_assignment(c::Course; kwargs...)
    json = request("POST", "/api/v1$(pid(c))/assignments"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.update_assignment(c::Course, a::Assignment; kwargs...) -> Assignment

**Request endpoint:** `PUT /api/v1/courses/:course_id/assignments/:id`

**Canvas API documentation:**
[*Edit an assignment*](https://canvas.instructure.com/doc/api/assignments#method.assignments_api.update)
"""
function update_assignment(c::Course, a::Assignment; kwargs...)
    json = request("PUT", "/api/v1$(pid(c))$(pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.assignment_overrides(c::Course, a::Assignment; kwargs...) -> Vector{AssignmentOverride}, page_data

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides`

**Canvas API documentation:**
[*List assignment overrides*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.index)
"""
function assignment_overrides(c::Course, a::Assignment; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(c))$(pid(a))/overrides"; kwargs...)
    return AssignmentOverride.(json), page_data
end

"""
    Canvas.assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

**Request endpoint:** `GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`

**Canvas API documentation:**
[*Get a single assignment overrides*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.show)
"""
function assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("GET", "/api/v1$(pid(c))$(pid(a))$(pid(o))"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...) -> AssignmentOverride

**Request endpoints:**
 - `GET /api/v1/groups/:group_id/assignments/:assignment_id/override`
 - `GET /api/v1/sections/:course_section_id/assignments/:assignment_id/override`

**Canvas API documentation:**
 - [*Redirect to the assignment override for a group*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.group_alias)
 - [*Redirect to the assignment override for a section*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.section_alias)
"""
function assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...)
    json = request("GET", "/api/v1$(pid(co))$(pid(a))/override"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.create_assignment_override(c::Course, a::Assignment; kwargs...) -> AssignmentOverride

**Request endpoint:** `POST /api/v1/courses/:course_id/assignments/:assignment_id/overrides`

**Canvas API documentation:**
[*Create an assignment override*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.create)
"""
function create_assignment_override(c::Course, a::Assignment; kwargs...)
    json = request("POST", "/api/v1$(pid(c))$(pid(a))/overrides"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

**Request endpoint:** `PUT /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`

**Canvas API documentation:**
[*Update an assignment override*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.update)
"""
function update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("PUT", "/api/v1$(pid(c))$(pid(a))$(pid(o))"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

**Request endpoint:** `DELETE /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`

**Canvas API documentation:**
[*Update an assignment override*](https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.update)
"""
function delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("DELETE", "/api/v1$(pid(c))$(pid(a))$(pid(o))"; kwargs...)
    return AssignmentOverride(json)
end


# TODO:
# - Batch retrieve overrides in a course
# - Batch create overrides in a course
# - Batch update overrides in a course
