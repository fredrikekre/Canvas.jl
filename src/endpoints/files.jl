# This file roughly corresponds to functions documented in the
# Files API: https://canvas.instructure.com/doc/api/files

"""
    Canvas.quota(co::Union{Course,Group,User}; kwargs...) -> Dict

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/files/quota`
 - `GET /api/v1/groups/:group_id/files/quota`
 - `GET /api/v1/users/:user_id/files/quota`

**Canvas API documentation:**
[*Get quota information*](https://canvas.instructure.com/doc/api/files#method.files.api_quota)
"""
function quota(co::Union{Course,Group,User}; kwargs...)
    json = request("GET", "/api/v1$(pid(co))/files/quota"; kwargs...)
    return json
end

"""
    Canvas.files(co::Union{Course,Group,User}; kwargs...) -> Vector{File}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/files`
 - `GET /api/v1/users/:user_id/files`
 - `GET /api/v1/groups/:group_id/files`
 - `GET /api/v1/folders/:id/files`

**Canvas API documentation:**
[*List files*](https://canvas.instructure.com/doc/api/files#method.files.api_index)
"""
function files(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(co))/files"; kwargs...)
    return File.(json), page_data
end

"""
    Canvas.public_url(f::File; kwargs...) -> Dict

**Request endpoint:* `GET /api/v1/files/:id/public_url`

**Canvas API documentation:**
[*Get public inline preview url*](https://canvas.instructure.com/doc/api/files#method.files.public_url)
"""
function public_url(f::File; kwargs...)
    json = request("GET", "/api/v1$(pid(f))/public_url"; kwargs...)
    return json
end

"""
    Canvas.file(f::File; kwargs...) -> File

**Request endpoint:* `GET /api/v1/files/:id`

**Canvas API documentation:**
[*Get file*](https://canvas.instructure.com/doc/api/files#method.files.api_show)
"""
function file(f::File; kwargs...)
    json = request("GET", "/api/v1$(pid(f))"; kwargs...)
    return File(json)
end
"""
    Canvas.file(co::Union{Course,Group,User}, f::File; kwargs...) -> File

**Request endpoints:*
 - `GET /api/v1/courses/:course_id/files/:id`
 - `GET /api/v1/groups/:group_id/files/:id`
 - `GET /api/v1/users/:user_id/files/:id`

**Canvas API documentation:**
[*Get file*](https://canvas.instructure.com/doc/api/files#method.files.api_show)
"""
function file(co::Union{Course,Group,User}, f::File; kwargs...)
    json = request("GET", "/api/v1$(pid(co))$(pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.update_file(f::File; kwargs...) -> File

**Request endpoint:* `PUT /api/v1/files/:id`

**Canvas API documentation:**
[*Update file*](https://canvas.instructure.com/doc/api/files#method.files.api_update)
"""
function update_file(f::File; kwargs...)
    json = request("PUT", "/api/v1$(pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.delete_file(f::File; kwargs...) -> File

**Request endpoint:* `DELETE /api/v1/files/:id`

**Canvas API documentation:**
[*Delete file*](https://canvas.instructure.com/doc/api/files#method.files.destroy)
"""
function delete_file(f::File; kwargs...)
    json = request("DELETE", "/api/v1$(pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.folders(f::Folder; kwargs...) -> Vector{Folder}, page_data

**Request endpoint:** `GET /api/v1/folders/:id/folders`

**Canvas API documentation:**
[*List folders*](https://canvas.instructure.com/doc/api/files#method.folders.api_index)
"""
function folders(f::Folder; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(f))/folders"; kwargs...)
    return Folder.(json), page_data
end

"""
    Canvas.folders(co::Union{Course,Group,User}; kwargs...) -> Vector{Folder}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/folders`
 - `GET /api/v1/groups/:group_id/folders`
 - `GET /api/v1/users/:user_id/folders`

**Canvas API documentation:**
[*List all folders*](https://canvas.instructure.com/doc/api/files#method.folders.list_all_folders)
"""
function folders(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(co))/folders"; kwargs...)
    return Folder.(json), page_data
end

"""
    Canvas.resolve_path(co::Union{Course,Group,User}, path=""; kwargs...) -> Vector{Folder}, page_data

**Request endpoints:**
 - `GET /api/v1/courses/:course_id/folders/by_path`
 - `GET /api/v1/groups/:group_id/folders/by_path`
 - `GET /api/v1/users/:user_id/folders/by_path`

**Canvas API documentation:**
[*Resolve path*](https://canvas.instructure.com/doc/api/files#method.folders.resolve_path)
"""
function resolve_path(co::Union{Course,Group,User}, path=""; kwargs...)
    path = isempth(path) ? "" : "/$path"
    json, page_data = paged_request("GET", "/api/v1$(pid(co))/folders/by_path$(path)"; kwargs...)
    return Folder.(json), page_data
end

"""
    Canvas.folder(f::Folder; kwargs...) -> Folder

**Request endpoint:* `GET /api/v1/folders/:id`

**Canvas API documentation:**
[*Get folder*](https://canvas.instructure.com/doc/api/files#method.folders.show)
"""
function folder(f::Folder; kwargs...)
    json = request("GET", "/api/v1$(pid(f))"; kwargs...)
    return Folder(json)
end
"""
    Canvas.folder(co::Union{Course,Group,User}, f::Folder; kwargs...) -> Folder

**Request endpoints:*
 - `GET /api/v1/courses/:course_id/folders/:id`
 - `GET /api/v1/groups/:group_id/folders/:id`
 - `GET /api/v1/users/:user_id/folders/:id`

**Canvas API documentation:**
[*Get folder*](https://canvas.instructure.com/doc/api/files#method.folders.show)
"""
function folder(co::Union{Course,Group,User}, f::Folder; kwargs...)
    json = request("GET", "/api/v1$(pid(co))$(pid(f))"; kwargs...)
    return Folder(json)
end

"""
    Canvas.update_folder(f::Folder; kwargs...) -> Folder

**Request endpoint:* `PUT /api/v1/folders/:id`

**Canvas API documentation:**
[*Update folder*](https://canvas.instructure.com/doc/api/files#method.folders.update)
"""
function update_folder(f::Folder; kwargs...)
    json = request("PUT", "/api/v1$(pid(f))"; kwargs...)
    return Folder(json)
end

"""
    Canvas.create_folder(co::Union{Course,Group,User,Folder}; kwargs...) -> Folder

**Request endpoints:*
 - `POST /api/v1/courses/:course_id/folders`
 - `POST /api/v1/groups/:group_id/folders`
 - `POST /api/v1/users/:user_id/folders`
 - `POST /api/v1/folders/:folder_id/folders`

**Canvas API documentation:**
[*Create folder*](https://canvas.instructure.com/doc/api/files#method.folders.create)
"""
function create_folder(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(pid(f))/folders"; kwargs...)
    return Folder(json)
end

"""
    Canvas.delete_folder(f::Folder; kwargs...) -> Dict

**Request endpoint:* `DELETE /api/v1/folders/:id`

**Canvas API documentation:**
[*Delete folder*](https://canvas.instructure.com/doc/api/files#method.folders.api_destroy)
"""
function delete_folder(f::Folder; kwargs...)
    json = request("DELETE", "/api/v1$(pid(f))"; kwargs...)
    return json # ??
end

"""
    Canvas.upload_file(f::Folder, file; kwargs...) -> File

**Request endpoint:** `POST /api/v1/folders/:folder_id/files`

**Canvas API documentation:**
[*Upload a file to a folder*](https://canvas.instructure.com/doc/api/files#method.folders.create_file)

"""
function upload_file(f::Folder, file; kwargs...)
    return _upload_file("/api/v1/$(pid(f))/files", file; kwargs...)
end

"""
    Canvas.copy_file(f::Folder; kwargs...) -> File

**Request endpoint:* `POST /api/v1/folders/:dest_folder_id/copy_file`

**Canvas API documentation:**
[*Copy a file*](https://canvas.instructure.com/doc/api/files#method.folders.copy_file)
"""
function copy_file(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(pid(f))/copy_file"; kwargs...)
    return File(json)
end

"""
    Canvas.copy_folder(f::Folder; kwargs...) -> Folder

**Request endpoint:* `POST /api/v1/folders/:dest_folder_id/copy_folder`

**Canvas API documentation:**
[*Copy a folder*](https://canvas.instructure.com/doc/api/files#method.folders.copy_folder)
"""
function copy_folder(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(pid(f))/copy_folder"; kwargs...)
    return Folder(json)
end

"""
    Canvas.media_folder(co::Union{Course,Group}; kwargs...) -> Folder

**Request endpoints:*
 - `GET /api/v1/courses/:course_id/folders/media`
 - `GET /api/v1/groups/:group_id/folders/media`

**Canvas API documentation:**
[*Get uploaded media folder for user*](https://canvas.instructure.com/doc/api/files#method.folders.media_folder)
"""
function media_folder(co::Union{Course,Group}; kwargs...)
    json = request("GET", "/api/v1$(pid(co))/folders/media"; kwargs...)
    return Folder(json)
end

"""
    Canvas.usage_rights(co::Union{Course,Group,User}; kwargs...) -> UsageRights

**Request endpoints:*
 - `PUT /api/v1/courses/:course_id/usage_rights`
 - `PUT /api/v1/groups/:group_id/usage_rights`
 - `PUT /api/v1/users/:user_id/usage_rights`

**Canvas API documentation:**
[*Set usage rights*](https://canvas.instructure.com/doc/api/files#method.usage_rights.set_usage_rights)
"""
function usage_rights(co::Union{Course,Group,User}; kwargs...)
    json = request("PUT", "/api/v1$(pid(co))/usage_rights"; kwargs...)
    return UsageRights(json)
end

"""
    Canvas.remove_usage_rights(co::Union{Course,Group,User}; kwargs...) -> Dict

**Request endpoints:*
 - `DELETE /api/v1/courses/:course_id/usage_rights`
 - `DELETE /api/v1/groups/:group_id/usage_rights`
 - `DELETE /api/v1/users/:user_id/usage_rights`

**Canvas API documentation:**
[*Remove usage rights*](https://canvas.instructure.com/doc/api/files#method.usage_rights.remove_usage_rights)
"""
function remove_usage_rights(co::Union{Course,Group,User}; kwargs...)
    json = request("DELETE", "/api/v1$(pid(co))/usage_rights"; kwargs...)
    return json # ??
end

"""
    Canvas.licenses(co::Union{Course,Group,User}; kwargs...) -> Vector{License}, page_data

**Request endpoints:*
 - `GET /api/v1/courses/:course_id/content_licenses`
 - `GET /api/v1/groups/:group_id/content_licenses`
 - `GET /api/v1/users/:user_id/content_licenses`

**Canvas API documentation:**
[*List licenses*](https://canvas.instructure.com/doc/api/files#method.usage_rights.licenses)
"""
function licenses(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(pid(co))/content_licenses"; kwargs...)
    return License.(json), page_data
end
