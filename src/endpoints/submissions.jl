# This file roughly corresponds to functions documented in the
# Submissions API: https://canvas.instructure.com/doc/api/submissions

"""
    Canvas.submissions(c::Union{Course,Section}, a::Assignment; kwargs...) -> Vector{Submission}, page_data

Return a paginated list of all existing submissions for an assignment.
Return a vector of [`Submission`](@ref) and a dictionary with page data.

**Canvas API documentation:**
[List assignment submissions (`GET /api/v1/courses/:course_id/assignments/:assignment_id/submissions`,
`GET /api/v1/sections/:section_id/assignments/:assignment_id/submissions`)]
(https://canvas.instructure.com/doc/api/submissions#method.submissions_api.index)
"""
function submissions(co::Union{Course,Section}, a::Assignment; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))$(Internals.pid(a))/submissions"; kwargs...)
    return Submission.(json), page_data
end

# TODO: Returns 401 Unauthorized
# """
#     Canvas.submissions(c::Union{Course,Section}; kwargs...) -> Vector{Submission}, page_data

# Return a paginated list of all existing submissions for the given set of students and assignments.
# Return a vector of [`Submission`](@ref) and a dictionary with page data.

# **Canvas API documentation:**
# [List submissions for multiple assignments (`GET /api/v1/courses/:course_id/students/submissions`,
# `GET /api/v1/sections/:section_id/students/submissions`)]
# (https://canvas.instructure.com/doc/api/submissions#method.submissions_api.for_students)
# """
# function submissions(co::Union{Course,Section}; kwargs...)
#     json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/students/submissions")
#     return Submission.(json), page_data
# end

"""
    Canvas.grade_submission(c::Union{Course,Section}, a::Assignment, user::User; kwargs...) -> Dict

Comment on and/or update the grading for a student's assignment submissions.

**Canvas API documentation:**
[Grade or comment on a submission (`PUT /api/v1/courses/:course_id/assignments/:assignment_id/submissions/:user_id`,
`PUT /api/v1/sections/:section_id/assignments/:assignment_id/submissions/:user_id`)]
(https://canvas.instructure.com/doc/api/submissions#method.submissions_api.update)
"""
function grade_submission(co::Union{Course,Section}, a::Assignment, u::User; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(co))$(Internals.pid(a))/submissions/$(Internals.id(u))"; kwargs...)
    return json
end
