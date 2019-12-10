# This file roughly corresponds to functions documented in the
# Courses API: https://canvas.instructure.com/doc/api/courses

"""
    Canvas.courses(; kwargs...) -> Vector{Course}, page_data

*Canvas API documentation*: [List your courses (`GET /api/v1/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.index)
"""
function courses(; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.courses(user::User; kwargs...) -> Vector{Course}, page_data

*Canvas API documentation*: [List courses for a user (`GET /api/v1/users/:user_id/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.user_index)
"""
function courses(user::User; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/users/$(id(user))/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.create_course(acc::Account; kwargs...) -> Course

*Canvas API documentation*: [Create a new course (`POST /api/v1/accounts/:account_id/courses`)]
(https://canvas.instructure.com/doc/api/courses#method.courses.create)
"""
function create_course(acc::Account; kwargs...)
    json = request("POST", "/api/v1/accounts/$(id(acc))/courses"; kwargs...)
    return Course(json)
end

"""
    Canvas.upload_file(c::Course, file; kwargs...) -> File

Canvas API documentation: [Upload a file to a course (`POST /api/v1/courses/:course_id/files`)]
(https://canvas.instructure.com/doc/api/courses.html#method.courses.create_file)
"""
function upload_file(c::Course, file; kwargs...)
    return _upload_file("/api/v1/$(pid(c))/files", file; kwargs...)
end

"""
    Canvas.users(course::Course; kwargs...) -> Vector{Course}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/users`
 - `GET /api/v1/courses/:course_id/search_users`
 - Canvas API documentation:
   [*List users in course*](https://canvas.instructure.com/doc/api/courses#method.courses.users)
"""
function users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/users"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.recent_students(course::Course; kwargs...) -> Vector{User}, page_data

 - Request endpoint: `GET /api/v1/courses/:course_id/recent_students`
 - Canvas API documentation:
   [*List recently logged in students*](https://canvas.instructure.com/doc/api/courses#method.courses.recent_students)
"""
function recent_students(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/recent_students"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.user(course::Course, user::User; kwargs...) -> User

 - Request endpoint: `GET /api/v1/courses/:course_id/users/:id`
 - Canvas API documentation:
   [*Get single user*](https://canvas.instructure.com/doc/api/courses#method.courses.user)
"""
function user(course::Course, user::User; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/users/$(id(user))"; kwargs...)
    return User(json)
end

"""
    Canvas.content_share_users(course::Course; kwargs...) -> Vector{User}, page_data

 - Request endpoint: `GET /api/v1/courses/:course_id/content_share_users`
 - Canvas API documentation:
   [*Search for content share users*](https://canvas.instructure.com/doc/api/courses#method.courses.content_share_users)
"""
function content_share_users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/content_share_users"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.preview_html(course::Course; kwargs...) -> Dict

 - Request endpoint: `POST /api/v1/courses/:course_id/preview_html`
 - Canvas API documentation:
   [*Preview processed html*](https://canvas.instructure.com/doc/api/courses#method.courses.preview_html)
"""
function preview_html(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/preview_html"; kwargs...)
    return json
end

"""
    Canvas.activity_stream(course::Course; summary::Bool=false, kwargs...) -> Vector{Dict}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/activity_stream`
 - `GET /api/v1/courses/:course_id/activity_stream/summary`
 - Canvas API documentation:
   [*Course activity stream*](https://canvas.instructure.com/doc/api/courses#method.courses.activity_stream)
and [Course activity stream summary](https://canvas.instructure.com/doc/api/courses#method.courses.activity_stream_summary)
"""
function activity_stream(course::Course; summary=false, kwargs...)
    endpoint = "/api/v1/courses/$(id(course))/activity_stream"
    summary && (endpoint *= "/summary")
    json, page_data = paged_request("GET", endpoint; kwargs...)
    return json, page_data
end

"""
    Canvas.todo(course::Course; kwargs...) -> Vector{Dict}, page_data

 - Request endpoint: `GET /api/v1/courses/:course_id/todo`
 - Canvas API documentation:
   [*Course TODO items*](https://canvas.instructure.com/doc/api/courses#method.courses.destroy)
"""
function todo(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/todo"; kwargs...)
    return json, page_data
end

"""
    Canvas.delete_course(course::Course; kwargs...) -> Dict

 - Request endpoint: `DELETE /api/v1/courses/:id`
 - Canvas API documentation:
   [Delete/Conclude a course](https://canvas.instructure.com/doc/api/courses#method.courses.destroy)
"""
function delete_course(course::Course; kwargs...)
    json = request("DELETE", "/api/v1/courses/$(id(course))"; kwargs...)
    return json
end

"""
    Canvas.settings(course::Course; kwargs...) -> Dict

 - Request endpoint: `GET /api/v1/courses/:course_id/settings`
 - Canvas API documentation:
   [*Get course settings*](https://canvas.instructure.com/doc/api/courses#method.courses.api_settings)
"""
function settings(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/settings"; kwargs...)
    return json
end

"""
    Canvas.update_settings(course::Course; kwargs...) -> Dict

 - Request endpoint: `PUT /api/v1/courses/:course_id/settings`
 - Canvas API documentation:
   [*Update course settings*](https://canvas.instructure.com/doc/api/courses#method.courses.update_settings)
"""
function update_settings(course::Course; kwargs...)
    json = request("PUT", "/api/v1/courses/$(id(course))/settings"; kwargs...)
    return json
end

"""
    Canvas.course(course::Course; kwargs...) -> Course

 - Request endpoint: `GET /api/v1/courses/:id`
 - Canvas API documentation:
   [*Get a single course*](https://canvas.instructure.com/doc/api/courses#method.courses.show)
"""
function course(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))"; kwargs...)
    return Course(json)
end

"""
    Canvas.update_course(course::Course; kwargs...) -> Course

 - Request endpoint: `PUT /api/v1/courses/:id`
 - Canvas API documentation:
   [*Update a course*](https://canvas.instructure.com/doc/api/courses#method.courses.update)
"""
function update_course(course::Course; kwargs...)
    json = request("PUT", "/api/v1/courses/$(id(course))"; kwargs...)
    return Course(json) # Maybe? Or just return json?
end

"""
    Canvas.update_courses(acc::Account; kwargs...) -> Progress

 - Request endpoint: `PUT /api/v1/accounts/:account_id/courses`
 - Canvas API documentation:
   [*Update courses*](https://canvas.instructure.com/doc/api/courses#method.courses.batch_update)
"""
function update_courses(acc::Account; kwargs...)
    json = request("PUT", "/api/v1/accounts/$(id(acc))/courses"; kwargs...)
    return Progress(json)
end

"""
    Canvas.reset_content(course::Course; kwargs...) -> Course

 - Request endpoint: `POST /api/v1/courses/:course_id/reset_content`
 - Canvas API documentation:
   [*Reset a course*](https://canvas.instructure.com/doc/api/courses#method.courses.reset_content)
"""
function reset_content(course::Course; kwargs...)
    json = request("POST", "/api/v1/courses/$(id(course))/reset_content"; kwargs...)
    return Course(json)
end

"""
    Canvas.effective_due_dates(course::Course; kwargs...) -> Dict

 - Request endpoint: `GET /api/v1/courses/:course_id/effective_due_dates`
 - Canvas API documentation:
   [*Get effective due dates*](https://canvas.instructure.com/doc/api/courses#method.courses.effective_due_dates)
"""
function effective_due_dates(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/effective_due_dates"; kwargs...)
    return json
end

"""
    Canvas.permissions(course::Course; kwargs...) -> Dict

 - Request endpoint: `GET /api/v1/courses/:course_id/permissions`
 - Canvas API documentation:
   [*Permissions*](https://canvas.instructure.com/doc/api/courses#method.courses.permissions)
"""
function permissions(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/permissions"; kwargs...)
    return json
end

# Get course copy status (deprecated)
# https://canvas.instructure.com/doc/api/courses#method.content_imports.copy_course_status

# Copy course content (deprecated)
# https://canvas.instructure.com/doc/api/courses#method.content_imports.copy_course_content
