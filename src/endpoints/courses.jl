# This file roughly corresponds to functions documented in the
# Courses API: https://canvas.instructure.com/doc/api/courses.html

"""
    Canvas.courses(; kwargs...) -> Vector{Course}, page_data

Request endpoint: `GET /api/v1/courses`.

See [List your courses](https://canvas.instructure.com/doc/api/courses.html#method.courses.index)
for more information and available request parameters.

**Examples**
```julia
# List courses where authenticated user enrolled as student
Canvas.courses(; params=Dict("enrollment_type"=>"student"))
```
"""
function courses(; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.courses(user::User; kwargs...) -> Vector{Course}, page_data

Request endpoint: `GET /api/v1/users/:user_id/courses`.

See [List courses for a user](https://canvas.instructure.com/doc/api/courses.html#method.courses.user_index)
for more information and available request parameters.
"""
function courses(user::User; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/users/$(id(user))/courses"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.create_course(acc::Account; kwargs...) -> Course

Request endpoint: `POST /api/v1/accounts/:account_id/courses`

See [Create a new course](https://canvas.instructure.com/doc/api/courses.html#method.courses.create)
for more information and available request parameters.
"""
function create_course(acc::Account; kwargs...)
    json = request("POST", "/api/v1/accounts/$(id(acc))/courses"; kwargs...)
    return Course(json)
end

# Upload a file (implemented in endpoints/files.jl)
# https://canvas.instructure.com/doc/api/courses.html#method.courses.create_file

"""
    Canvas.users(course::Course; kwargs...) -> Vector{Course}, page_data

Request endpoint: `GET /api/v1/courses/:course_id/users`,
`GET /api/v1/courses/:course_id/search_users`.

See [List users in course](https://canvas.instructure.com/doc/api/courses.html#method.courses.users)
for more information and available request parameters.
"""
function users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/users"; kwargs...)
    return Course.(json), page_data
end

"""
    Canvas.recent_students(course::Course; kwargs...) -> Vector{User}, page_data

Request endpoint: `GET /api/v1/courses/:course_id/recent_students`.

See [List recently logged in students](https://canvas.instructure.com/doc/api/courses.html#method.courses.recent_students)
for more information and available request parameters.
"""
function recent_students(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/recent_students"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.user(course::Course, user::User; kwargs...) -> User

Request endpoint: `GET /api/v1/courses/:course_id/users/:id`.

See [Get single user](https://canvas.instructure.com/doc/api/courses.html#method.courses.user)
for more information and available request parameters.
"""
function user(course::Course, user::User; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/users/$(id(user))"; kwargs...)
    return User(json)
end

"""
    Canvas.content_share_users(course::Course; kwargs...) -> Vector{User}, page_data

Request endpoint: `GET /api/v1/courses/:course_id/content_share_users`.

See [List recently logged in students](https://canvas.instructure.com/doc/api/courses.html#method.courses.content_share_users)
for more information and available request parameters.
"""
function content_share_users(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/content_share_users"; kwargs...)
    return User.(json), page_data
end

"""
    Canvas.preview_html(course::Course; kwargs...) -> Dict

Request endpoint: `POST /api/v1/courses/:course_id/preview_html`.

See [Preview processed html](https://canvas.instructure.com/doc/api/courses.html#method.courses.preview_html)
for more information and available request parameters.
"""
function preview_html(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/preview_html"; kwargs...)
    return json
end

"""
    Canvas.activity_stream(course::Course; summary::Bool=false, kwargs...) -> Vector{Dict}, page_data

Request endpoint: `GET /api/v1/courses/:course_id/activity_stream`,
`GET /api/v1/courses/:course_id/activity_stream/summary`.

See [Course activity stream](https://canvas.instructure.com/doc/api/courses.html#method.courses.activity_stream)
and [Course activity stream summary](https://canvas.instructure.com/doc/api/courses.html#method.courses.activity_stream_summary)
for more information and available request parameters.
"""
function activity_stream(course::Course; summary=false, kwargs...)
    endpoint = "/api/v1/courses/$(id(course))/activity_stream"
    summary && (endpoint *= "/summary")
    json, page_data = paged_request("GET", endpoint; kwargs...)
    return json, page_data
end

"""
    Canvas.todo(course::Course; kwargs...) -> Vector{Dict}, page_data

Request endpoint: `GET /api/v1/courses/:course_id/todo`.

See [Course TODO items](https://canvas.instructure.com/doc/api/courses.html#method.courses.destroy)
for more information and available request parameters.
"""
function todo(course::Course; kwargs...)
    json, page_data = paged_request("GET", "/api/v1/courses/$(id(course))/todo"; kwargs...)
    return json, page_data
end

"""
    Canvas.delete(course::Course; kwargs...) -> Dict

Request endpoint: `DELETE /api/v1/courses/:id`.

See [Delete/Conclude a course](https://canvas.instructure.com/doc/api/courses.html#method.courses.destroy)
for more information and available request parameters.
"""
function delete(course::Course; kwargs...)
    json = request("DELETE", "/api/v1/courses/$(id(course))"; kwargs...)
    return json
end

"""
    Canvas.settings(course::Course; kwargs...) -> Dict

Request endpoint: `GET /api/v1/courses/:course_id/settings`.

See [Get course settings](https://canvas.instructure.com/doc/api/courses.html#method.courses.api_settings)
for more information and available request parameters.
"""
function settings(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/settings"; kwargs...)
    return json
end

"""
    Canvas.update_settings(course::Course; kwargs...) -> Dict

Request endpoint: `PUT /api/v1/courses/:course_id/settings`.

See [Update course settings](https://canvas.instructure.com/doc/api/courses.html#method.courses.update_settings)
for more information and available request parameters.
"""
function update_settings(course::Course; kwargs...)
    json = request("PUT", "/api/v1/courses/$(id(course))/settings"; kwargs...)
    return json
end

"""
    Canvas.course(course::Course; kwargs...) -> Course

Request endpoint: `GET /api/v1/courses/:id`.

See [Get a single course](https://canvas.instructure.com/doc/api/courses.html#method.courses.show)
for more information and available request parameters.
"""
function course(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))"; kwargs...)
    return Course(json)
end

"""
    Canvas.update_course(course::Course; kwargs...) -> Course

Request endpoint: `PUT /api/v1/courses/:id`

See [Update a course](https://canvas.instructure.com/doc/api/courses.html#method.courses.update)
for more information and available request parameters.
"""
function update_course(course::Course; kwargs...)
    json = request("PUT", "/api/v1/courses/$(id(course))"; kwargs...)
    return Course(json) # Maybe? Or just return json?
end

"""
    Canvas.update_courses(acc::Account; kwargs...) -> Progress

Request endpoint: `PUT /api/v1/accounts/:account_id/courses`

See [Update courses](https://canvas.instructure.com/doc/api/courses.html#method.courses.batch_update)
for more information and available request parameters.
"""
function update_courses(acc::Account; kwargs...)
    json = request("PUT", "/api/v1/accounts/$(id(acc))/courses"; kwargs...)
    return Progress(json)
end

"""
    Canvas.reset_content(course::Course; kwargs...) -> Course

Request endpoint: `POST /api/v1/courses/:course_id/reset_content`

See [Reset a course](https://canvas.instructure.com/doc/api/courses.html#method.courses.reset_content)
for more information and available request parameters.
"""
function reset_content(course::Course; kwargs...)
    json = request("POST", "/api/v1/courses/$(id(course))/reset_content"; kwargs...)
    return Course(json)
end

"""
    Canvas.effective_due_dates(course::Course; kwargs...) -> Dict

Request endpoint: `GET /api/v1/courses/:course_id/effective_due_dates`

See [Get effective due dates](https://canvas.instructure.com/doc/api/courses.html#method.courses.effective_due_dates)
for more information and available request parameters.
"""
function effective_due_dates(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/effective_due_dates"; kwargs...)
    return json
end

"""
    Canvas.permissions(course::Course; kwargs...) -> Dict

Request endpoint: `GET /api/v1/courses/:course_id/permissions`

See [Permissions](https://canvas.instructure.com/doc/api/courses.html#method.courses.permissions)
for more information and available request parameters.
"""
function permissions(course::Course; kwargs...)
    json = request("GET", "/api/v1/courses/$(id(course))/permissions"; kwargs...)
    return json
end

# Get course copy status (deprecated)
# https://canvas.instructure.com/doc/api/courses.html#method.content_imports.copy_course_status

# Copy course content (deprecated)
# https://canvas.instructure.com/doc/api/courses.html#method.content_imports.copy_course_content
