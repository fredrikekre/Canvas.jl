# This file roughly corresponds to functions documented in the
# Courses API: https://canvas.instructure.com/doc/api/courses

"""
    Canvas.courses(; kwargs...) -> Vector{Course}, page_data

Return a paginated list of courses for the authenticated user.
Return a vector of [`Course`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List your courses (`GET /api/v1/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.index)
"""
function courses(; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.courses(user::User; kwargs...) -> Vector{Course}, page_data

Return a paginated list of courses for the specified user.
Return a vector of [`Course`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List courses for a user (`GET /api/v1/users/:user_id/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.user_index)
"""
function courses(user::User; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(user))/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.create_course(acc::Account; kwargs...) -> Course

Create a new course. Return a [`Course`](@ref).

**Canvas API documentation**:
[Create a new course (`POST /api/v1/accounts/:account_id/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.create)
"""
function create_course(acc::Account; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(acc))/courses"; kwargs...)
    return Course(json)
end

"""
    Canvas.upload_file(c::Course, file::String; kwargs...) -> File

Upload a file to the course. Return a [`File`](@ref).

**Canvas API documentation**:
[Upload a file to a course (`POST /api/v1/courses/:course_id/files`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.create_file)
"""
function upload_file(c::Course, file::String; kwargs...)
    return Internals.upload_file("/api/v1$(Internals.pid(c))/files", file; kwargs...)
end

"""
    Canvas.users(course::Course; kwargs...) -> Vector{User}, page_data

Return a paginated list of users in the course.
Return a vector of [`User`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List users in course (`GET /api/v1/courses/:course_id/users`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.users)
"""
function users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(course))/users"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.recent_students(course::Course; kwargs...) -> Vector{User}, page_data

Return a paginated list of users in the course ordered by how recently they have
logged in. Return a vector of [`User`](@ref)s and a dictionary of page data.

**Canvas API documentation**:
[List recently logged in students (`GET /api/v1/courses/:course_id/recent_students`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.recent_students)
"""
function recent_students(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(course))/recent_students"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.user(course::Course, user::User; kwargs...) -> User

Return information about a single user in the course. Return a [`User`](@ref).

**Canvas API documentation**:
[Get single user (`GET /api/v1/courses/:course_id/users/:id`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.user)
"""
function user(course::Course, user::User; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))$(Internals.pid(user))"; kwargs...)
    return User(json)
end

"""
    Canvas.content_share_users(course::Course; kwargs...) -> Vector{User}, page_data

Return a paginated list of users you can share content with.
Return a vector of [`User`](@ref)s and a dictionary of page data.

**Canvas API documentation**:
[Search for content share users (`GET /api/v1/courses/:course_id/content_share_users`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.content_share_users)
"""
function content_share_users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(course))/content_share_users"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.preview_html(course::Course; kwargs...) -> Dict

Preview HTML content processed for this course. Return a dictionary.

**Canvas API documentation**:
[Preview processed html (`POST /api/v1/courses/:course_id/preview_html`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.preview_html)
"""
function preview_html(course::Course; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))/preview_html"; kwargs...)
    return json
end

"""
    Canvas.activity_stream(course::Course; summary::Bool=false, kwargs...) -> Vector{Dict}, page_data

Return the authenticated users course-specific activity stream paginated.

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/activity_stream`
 - `GET /api/v1/courses/:course_id/activity_stream/summary`

**Canvas API documentation**:
 - [Course activity stream (`GET /api/v1/courses/:course_id/activity_stream`)]
   (https://canvas.instructure.com/doc/api/courses#method.courses.activity_stream)
 - [Course activity stream (`GET /api/v1/courses/:course_id/activity_stream/summary`)]
   (https://canvas.instructure.com/doc/api/courses#method.courses.activity_stream_summary)
"""
function activity_stream(course::Course; summary=false, kwargs...)
    endpoint = "/api/v1$(Internals.pid(course))/activity_stream"
    summary && (endpoint *= "/summary")
    json, page_data = paged_request("GET", endpoint; kwargs...)
    return json, page_data
end

"""
    Canvas.todo(course::Course; kwargs...) -> Vector{Dict}, page_data

Return the authenticated users course-specific todo items.

**Canvas API documentation**:
[Course TODO items (`GET /api/v1/courses/:course_id/todo`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.todo_items)
"""
function todo(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(course))/todo"; kwargs...)
    return json, page_data
end

"""
    Canvas.delete_course(course::Course; kwargs...) -> Dict

Delete or conclude an existing course.

**Canvas API documentation**:
[Delete/Conclude a course (`DELETE /api/v1/courses/:id`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.destroy)
"""
function delete_course(course::Course; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(course))"; kwargs...)
    return json
end

"""
    Canvas.settings(course::Course; kwargs...) -> Dict

Return course settings as a dictionary.

**Canvas API documentation**:
[Get course settings (`GET /api/v1/courses/:course_id/settings`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.api_settings)
"""
function settings(course::Course; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))/settings"; kwargs...)
    return json
end

"""
    Canvas.update_settings(course::Course; kwargs...) -> Dict

Update course settings. Return a dictionary.

**Canvas API documentation**:
[Update course settings (`PUT /api/v1/courses/:course_id/settings`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.update_settings)
"""
function update_settings(course::Course; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(course))/settings"; kwargs...)
    return json
end

# TODO: https://canvas.instructure.com/doc/api/courses#method.courses.student_view_student

"""
    Canvas.course(course::Course; kwargs...) -> Course

Return details about a single course specified by id.
Return a [`Course`](@ref).

**Canvas API documentation**:
[Get a single course (`GET /api/v1/courses/:id`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.show)
"""
function course(course::Course; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))"; kwargs...)
    return Course(json)
end

"""
    Canvas.update_course(course::Course; kwargs...) -> Course

Update an existing course and return the new details.
Return a [`Course`](@ref).

**Canvas API documentation**:
[Update a course (`PUT /api/v1/courses/:id`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.update)
"""
function update_course(course::Course; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(course))"; kwargs...)
    return Course(json) # Maybe? Or just return json?
end

# TODO: batch update
# """
#     Canvas.update_courses(acc::Account; kwargs...) -> Progress

#  - Request endpoint: `PUT /api/v1/accounts/:account_id/courses`
#  - Canvas API documentation:
#    [*Update courses*](https://canvas.instructure.com/doc/api/courses#method.courses.batch_update)
# """
# function update_courses(acc::Account; kwargs...)
#     json = request("PUT", "/api/v1$(Internals.pid(acc))/courses"; kwargs...)
#     return Progress(json)
# end

"""
    Canvas.reset_content(course::Course; kwargs...) -> Course

Delete the course and create a new equivalent course with no content but all sections
and users moved overs. Return a [`Course`](@ref).

**Canvas API documentation**:
[Reset a course (`POST /api/v1/courses/:course_id/reset_content`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.reset_content)
"""
function reset_content(course::Course; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(course))/reset_content"; kwargs...)
    return Course(json)
end

"""
    Canvas.effective_due_dates(course::Course; kwargs...) -> Dict

For each assignment in the course, returns each assigned student's ID
and their corresponding due date along with some grading period data.

**Canvas API documentation**:
[Get effective due dates (`GET /api/v1/courses/:course_id/effective_due_dates`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.effective_due_dates)
"""
function effective_due_dates(course::Course; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))/effective_due_dates"; kwargs...)
    return json
end

"""
    Canvas.permissions(course::Course; kwargs...) -> Dict

Return permissions for the authenticated user in the specified course.
Return a dictionary.

**Canvas API documentation**:
[Permissions (`GET /api/v1/courses/:course_id/permissions`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.permissions)
"""
function permissions(course::Course; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(course))/permissions"; kwargs...)
    return json
end
