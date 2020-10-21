# This file roughly corresponds to functions documented in the
# Submission Comments API: https://canvas.instructure.com/doc/api/submission_comments

"""
    Canvas.upload_file(c::Course, a::Assignment, u::User, file; kwargs...) -> File

**Request endpoint:** `POST /api/v1/courses/:course_id/assignments/:assignment_id/submissions/:user_id/comments/files`

**Canvas API documentation:**
[*Upload a file*](https://canvas.instructure.com/doc/api/submission_comments#method.submission_comments_api.create_file)

"""
function upload_file(c::Course, a::Assignment, u::User, file; kwargs...)
    endpoint = "/api/v1$(Internals.pid(c))$(Internals.pid(a))/submissions/$(Internals.id(u))/comments/files"
    return Internals.upload_file(endpoint, file; kwargs...)
end
