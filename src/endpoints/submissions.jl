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
    json, page_data = paged_request("GET", "/api/v1$(pid(co))$(pid(a))/submissions"; kwargs...)
    return Submission.(json), page_data
end
