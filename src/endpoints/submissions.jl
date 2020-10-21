# This file roughly corresponds to functions documented in the
# Submissions API: https://canvas.instructure.com/doc/api/submissions

"""
    Canvas.submissions(c::Union{Course,Section}, a::Assignment; kwargs...) -> Vector{Submission}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/assignments/:assignment_id/submissions`
 - `GET /api/v1/sections/:section_id/assignments/:assignment_id/submissions`

**Canvas API documentation:**
[*List assignment submissions*](https://canvas.instructure.com/doc/api/submissions#method.submissions_api.index)
"""
function submissions(co::Union{Course,Section}, a::Assignment; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))$(Internals.pid(a))/submissions"; kwargs...)
    return Submission.(json), page_data
end

function submissions(co::Union{Course,Section}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/students/submissions")
    return Submission.(json), page_data
end

"""
    Canvas.grade_submission(c::Union{Course,Section}, a::Assignment, user::User; kwargs...) -> ??

**Request endpoints:**
 - `PUT /api/v1/courses/:course_id/assignments/:assignment_id/submissions/:user_id`
 - `PUT /api/v1/sections/:section_id/assignments/:assignment_id/submissions/:user_id`

**Canvas API documentation:**
[*Grade or comment on a submission*](https://canvas.instructure.com/doc/api/submissions#method.submissions_api.update)
"""
function grade_submission(co::Union{Course,Section}, a::Assignment, u::User; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(co))$(Internals.pid(a))/submissions/$(Internals.id(u))"; kwargs...)
    return json
end
