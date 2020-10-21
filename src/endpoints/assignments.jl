# This file roughly corresponds to functions documented in the
# Assignments API: https://canvas.instructure.com/doc/api/assignments

"""
    Canvas.delete_assignment(c::Course, a::Assignment; kwargs...) -> Assignment

Delete the given assignment and return the former details. Return an [`Assignment`](@ref).

**Canvas API documentation**:
[Delete an assignment (`DELETE /api/v1/courses/:course_id/assignments/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments.destroy)
"""
function delete_assignment(c::Course, a::Assignment; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(c))$(Internals.pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.assignments(c::Course; kwargs...) -> Vector{Assignment}, page_data

Return the paginated list of assignments for the course.
Return a vector of [`Assignment`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List assignments (`GET /api/v1/courses/:course_id/assignments`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.index)
"""
function assignments(c::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(c))/assignments"; kwargs...)
    return Assignment.(json), page_data
end

"""
    Canvas.assignments(c::Course, a::AssignmentGroup; kwargs...) -> Vector{Assignment}, page_data

Return the paginated list of assignments for the course and assignment group.
Return a vector of [`Assignment`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List assignments (`GET /api/v1/courses/:course_id/assignment_groups/:assignment_group_id/assignments`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.index)
"""
function assignments(c::Course, a::AssignmentGroup; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(c))$(Internals.pid(a))/assignments"; kwargs...)
    return Assignment.(json), page_data
end

"""
    Canvas.assignments(u::User, c::Course; kwargs...) -> Vector{Assignment}, page_data

Return the paginated list of assignments for the specified user and course.
Return a vector of [`Assignment`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List assignments for user(`GET /api/v1/users/:user_id/courses/:course_id/assignments`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.user_index)
"""
function assignments(u::User, c::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(u))$(Internals.pid(c))/assignments"; kwargs...)
    return Assignment.(json), page_data
end

"""
    Canvas.assignment(c::Course, a::Assignment; kwargs...) -> Assignment

Return the assignment given by id. Return an [`Assignment`](@ref).

**Canvas API documentation**:
[Get a single assignment (`GET /api/v1/courses/:course_id/assignments/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.show)
"""
function assignment(c::Course, a::Assignment; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(c))$(Internals.pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.create_assignment(c::Course, a::Assignment; kwargs...) -> Assignment

Create a new assignment for the course and return the details. Return an [`Assignment`](@ref).

**Canvas API documentation**:
[Create an assignment (`POST /api/v1/courses/:course_id/assignments`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.create)
"""
function create_assignment(c::Course; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(c))/assignments"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.update_assignment(c::Course, a::Assignment; kwargs...) -> Assignment

Modify an existing assignment and return the new details. Return an [`Assignment`](@ref).

**Canvas API documentation**:
[Edit an assignment (`PUT /api/v1/courses/:course_id/assignments/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignments_api.update)
"""
function update_assignment(c::Course, a::Assignment; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(c))$(Internals.pid(a))"; kwargs...)
    return Assignment(json)
end

"""
    Canvas.assignment_overrides(c::Course, a::Assignment; kwargs...) -> Vector{AssignmentOverride}, page_data

Return the paginated list of overrides for this course and assignment.
Return a vector of [`AssignmentOverride`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List assignment overrides (`GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.index)
"""
function assignment_overrides(c::Course, a::Assignment; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(c))$(Internals.pid(a))/overrides"; kwargs...)
    return AssignmentOverride.(json), page_data
end

"""
    Canvas.assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

Return the details of override specified by id. Return an [`AssignmentOverride`](@ref).

**Canvas API documentation**:
[Get a single assignment overrides (`GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.show)
"""
function assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(c))$(Internals.pid(a))$(Internals.pid(o))"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...) -> AssignmentOverride

Return the override for the given group or section associated with the assignment (404 otherwise).
Return an [`AssignmentOverride`](@ref).

**Canvas API documentation**:
 - [Redirect to the assignment override for a group (`GET /api/v1/groups/:group_id/assignments/:assignment_id/override`)]
   (https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.group_alias)
 - [Redirect to the assignment override for a section (`GET /api/v1/sections/:course_section_id/assignments/:assignment_id/override`)]
   (https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.section_alias)
"""
function assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(co))$(Internals.pid(a))/override"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.create_assignment_override(c::Course, a::Assignment; kwargs...) -> AssignmentOverride

Create an assignment override. One of `student_ids`, `group_id` or `course_section_id` must be present,
see API specification for details. Return the [`AssignmentOverride`](@ref).

**Canvas API documentation**:
[Create an assignment override (`POST /api/v1/courses/:course_id/assignments/:assignment_id/overrides`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.create)
"""
function create_assignment_override(c::Course, a::Assignment; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(c))$(Internals.pid(a))/overrides"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

Update the assignment override. All current overriden values must be supplied if the should
be retained, see API specification for details. Return the [`AssignmentOverride`](@ref).

**Canvas API documentation**:
[Update an assignment override (`PUT /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.update)
"""
function update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(c))$(Internals.pid(a))$(Internals.pid(o))"; kwargs...)
    return AssignmentOverride(json)
end

"""
    Canvas.delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride

Delete and override and return the former details. Return an [`AssignmentOverride`](@ref).

**Canvas API documentation**:
[Update an assignment override (`DELETE /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id`)]
(https://canvas.instructure.com/doc/api/assignments#method.assignment_overrides.update)
"""
function delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(c))$(Internals.pid(a))$(Internals.pid(o))"; kwargs...)
    return AssignmentOverride(json)
end


# TODO:
# - Batch retrieve overrides in a course
# - Batch create overrides in a course
# - Batch update overrides in a course
