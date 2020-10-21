# This file roughly corresponds to functions documented in the
# Files API: https://canvas.instructure.com/doc/api/files

"""
    Canvas.quota(co::Union{Course,Group,User}; kwargs...) -> Dict

Return the total and used storage quota for the course/group/user.
Return a dictionary.

**Canvas API documentation**:
[Get quota information (`GET /api/v1/courses/:course_id/files/quota`,
`GET /api/v1/groups/:group_id/files/quota`, `GET /api/v1/users/:user_id/files/quota`)]
(https://canvas.instructure.com/doc/api/files#method.files.api_quota)
"""
function quota(co::Union{Course,Group,User}; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(co))/files/quota"; kwargs...)
    return json
end

"""
    Canvas.files(co::Union{Course,Group,User,Folder}; kwargs...) -> Vector{File}, page_data

Return a paginated  list of files for the course/groupt/user/folder.
Return a vector of [`File`](@ref)s and a dictionary of page data.

**Canvas API documentation**:
[List files (`GET /api/v1/courses/:course_id/files`, `GET /api/v1/users/:user_id/files`,
`GET /api/v1/groups/:group_id/files`, `GET /api/v1/folders/:id/files`)]
(https://canvas.instructure.com/doc/api/files#method.files.api_index)
"""
function files(co::Union{Course,Group,User,Folder}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/files"; kwargs...)
    return File.(json), page_data
end

"""
    Canvas.preview_url(f::File; kwargs...) -> Dict

Determine the URL that should be used for inline preview of the file.
Return a dictionary.

**Canvas API documentation**:
[Get public inline preview url (`GET /api/v1/files/:id/public_url`)]
(https://canvas.instructure.com/doc/api/files#method.files.public_url)
"""
function preview_url(f::File; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(f))/public_url"; kwargs...)
    return json
end

"""
    Canvas.file(f::File; kwargs...) -> File

Get the details of a single file. Return a [`File`](@ref).

**Canvas API documentation**:
[Get file (`GET /api/v1/files/:id`)]
(https://canvas.instructure.com/doc/api/files#method.files.api_show)
"""
function file(f::File; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.file(co::Union{Course,Group,User}, f::File; kwargs...) -> File

Get the details of a single file. Return a [`File`](@ref).

**Canvas API documentation**:
[Get file (`GET /api/v1/courses/:course_id/files/:id`,
`GET /api/v1/groups/:group_id/files/:id`, `GET /api/v1/users/:user_id/files/:id`)]
(https://canvas.instructure.com/doc/api/files#method.files.api_show)
"""
function file(co::Union{Course,Group,User}, f::File; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(co))$(Internals.pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.update_file(f::File; kwargs...) -> File

Update settings for the specified file. Return a [`File`](@ref).

**Canvas API documentation**:
[Update file (`PUT /api/v1/files/:id`)](https://canvas.instructure.com/doc/api/files#method.files.api_update)
"""
function update_file(f::File; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.delete_file(f::File; kwargs...) -> File

Delete the specified file and return the details. Return a [`File`](@ref).

**Canvas API documentation**:
[Delete file (`DELETE /api/v1/files/:id`)](https://canvas.instructure.com/doc/api/files#method.files.destroy)
"""
function delete_file(f::File; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(f))"; kwargs...)
    return File(json)
end

"""
    Canvas.folders(f::Folder; kwargs...) -> Vector{Folder}, page_data

Return a paginated list of folders in the specified folder.
Return a vector of [`Folder`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List folders (`GET /api/v1/folders/:id/folders`)]
(https://canvas.instructure.com/doc/api/files#method.folders.api_index)
"""
function folders(f::Folder; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(f))/folders"; kwargs...)
    return Folder.(json), page_data
end

"""
    Canvas.folders(co::Union{Course,Group,User}; kwargs...) -> Vector{Folder}, page_data

Return a paginated, flattened, list of all folders in the course/group/user.
Return a vector of [`Folder`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List all folders (`GET /api/v1/courses/:course_id/folders`,
`GET /api/v1/groups/:group_id/folders`, `GET /api/v1/users/:user_id/folders`)]
(https://canvas.instructure.com/doc/api/files#method.folders.list_all_folders)
"""
function folders(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/folders"; kwargs...)
    return Folder.(json), page_data
end

"""
    Canvas.resolve_path(co::Union{Course,Group,User}, path=""; kwargs...) -> Vector{Folder}

Return the list of folders from the root of the course/group/user to the path `path`.
Return a vector of [`Folder`](@ref)s.

**Canvas API documentation**:
[Resolve path (`GET /api/v1/courses/:course_id/folders/by_path`,
`GET /api/v1/groups/:group_id/folders/by_path`, `GET /api/v1/users/:user_id/folders/by_path`)]
(https://canvas.instructure.com/doc/api/files#method.folders.resolve_path)
"""
function resolve_path(co::Union{Course,Group,User}, path=""; kwargs...)
    path = isempty(path) ? "" : "/$(lstrip(path, '/'))"
    json = request("GET", "/api/v1$(Internals.pid(co))/folders/by_path$(path)"; kwargs...)
    return Folder.(json)
end

"""
    Canvas.folder(f::Folder; kwargs...) -> Folder

Return the details of a folder specified by id. Return a [`Folder`](@ref).

**Canvas API documentation**:
[Get folder (`GET /api/v1/folders/:id`)]
(https://canvas.instructure.com/doc/api/files#method.folders.show)
"""
function folder(f::Folder; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(f))"; kwargs...)
    return Folder(json)
end

# TODO: allow "root" as folder id to get the root folder
"""
    Canvas.folder(co::Union{Course,Group,User}, f::Folder; kwargs...) -> Folder

Return the details of a folder specified by id. Return a [`Folder`](@ref).

**Canvas API documentation**:
[Get folder (`GET /api/v1/courses/:course_id/folders/:id`,
`GET /api/v1/groups/:group_id/folders/:id`, `GET /api/v1/users/:user_id/folders/:id`)]
(https://canvas.instructure.com/doc/api/files#method.folders.show)
"""
function folder(co::Union{Course,Group,User}, f::Folder; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(co))$(Internals.pid(f))"; kwargs...)
    return Folder(json)
end

"""
    Canvas.update_folder(f::Folder; kwargs...) -> Folder

Update settings for the folder. Return a [`Folder`](@ref).

**Canvas API documentation**:
[Update folder (`PUT /api/v1/folders/:id`)]
(https://canvas.instructure.com/doc/api/files#method.folders.update)
"""
function update_folder(f::Folder; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(f))"; kwargs...)
    return Folder(json)
end

"""
    Canvas.create_folder(co::Union{Course,Group,User,Folder}; kwargs...) -> Folder

Create a new folder in the course/group/user/folder. Return a [`Folder`](@ref).

**Canvas API documentation**:
[Create folder (`POST /api/v1/courses/:course_id/folders`, `POST /api/v1/groups/:group_id/folders`,
`POST /api/v1/users/:user_id/folders`, `POST /api/v1/folders/:folder_id/folders`)]
(https://canvas.instructure.com/doc/api/files#method.folders.create)
"""
function create_folder(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(f))/folders"; kwargs...)
    return Folder(json)
end

"""
    Canvas.delete_folder(f::Folder; kwargs...) -> Dict

Delete the folder. Return a dictionary.

**Canvas API documentation**:
[Delete folder (`DELETE /api/v1/folders/:id`)]
(https://canvas.instructure.com/doc/api/files#method.folders.api_destroy)
"""
function delete_folder(f::Folder; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(f))"; kwargs...)
    return json # ??
end

"""
    Canvas.upload_file(f::Folder, file::String; kwargs...) -> File

Upload a file to a folder. Return a [`File`](@ref).

**Canvas API documentation**:
[Upload a file (`POST /api/v1/folders/:folder_id/files`)]
(https://canvas.instructure.com/doc/api/files#method.folders.create_file)
"""
function upload_file(f::Folder, file::String; kwargs...)
    return Internals.upload_file("/api/v1$(Internals.pid(f))/files", file; kwargs...)
end

"""
    Canvas.copy_file(f::Folder; kwargs...) -> File

Copy a file into the specified folder. Return a [`File`](@ref).

**Canvas API documentation**:
[Copy a file (`POST /api/v1/folders/:dest_folder_id/copy_file`)]
(https://canvas.instructure.com/doc/api/files#method.folders.copy_file)
"""
function copy_file(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(f))/copy_file"; kwargs...)
    return File(json)
end

"""
    Canvas.copy_folder(f::Folder; kwargs...) -> Folder

Copy a folder and its contents into the specified folder. Return a [`Folder`](@ref).

**Canvas API documentation**:
[Copy a folder (`POST /api/v1/folders/:dest_folder_id/copy_folder`)]
(https://canvas.instructure.com/doc/api/files#method.folders.copy_folder)
"""
function copy_folder(f::Folder; kwargs...)
    json = request("POST", "/api/v1$(Internals.pid(f))/copy_folder"; kwargs...)
    return Folder(json)
end

"""
    Canvas.media_folder(co::Union{Course,Group}; kwargs...) -> Folder

Return the details for a designated upload folder that the user has rights to upload to.
Return a [`Folder`](@ref).

**Canvas API documentation**:
[Get uploaded media folder for user (`GET /api/v1/courses/:course_id/folders/media`, `GET /api/v1/groups/:group_id/folders/media`)]
(https://canvas.instructure.com/doc/api/files#method.folders.media_folder)
"""
function media_folder(co::Union{Course,Group}; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(co))/folders/media"; kwargs...)
    return Folder(json)
end

"""
    Canvas.update_usage_rights(co::Union{Course,Group,User}; kwargs...) -> UsageRights

Set copyright and license information for one or more files. Return a [`UsageRights`](@ref).

**Canvas API documentation**:
[Set usage rights (`PUT /api/v1/courses/:course_id/usage_rights`,
`PUT /api/v1/groups/:group_id/usage_rights`, `PUT /api/v1/users/:user_id/usage_rights`)]
(https://canvas.instructure.com/doc/api/files#method.usage_rights.set_usage_rights)
"""
function update_usage_rights(co::Union{Course,Group,User}; kwargs...)
    json = request("PUT", "/api/v1$(Internals.pid(co))/usage_rights"; kwargs...)
    return UsageRights(json)
end

"""
    Canvas.remove_usage_rights(co::Union{Course,Group,User}; kwargs...) -> Dict

Remove copyright and license information associated with one or more files.

**Canvas API documentation**:
[Remove usage rights (`DELETE /api/v1/courses/:course_id/usage_rights`,
`DELETE /api/v1/groups/:group_id/usage_rights`, `DELETE /api/v1/users/:user_id/usage_rights`)]
(https://canvas.instructure.com/doc/api/files#method.usage_rights.remove_usage_rights)
"""
function remove_usage_rights(co::Union{Course,Group,User}; kwargs...)
    json = request("DELETE", "/api/v1$(Internals.pid(co))/usage_rights"; kwargs...)
    return json # ??
end

"""
    Canvas.licenses(co::Union{Course,Group,User}; kwargs...) -> Vector{License}, page_data

Return a paginated list of licenses that can be applied to files.
Return a vector of [`License`](@ref)s and a dictionary with page data.

**Canvas API documentation**:
[List licenses (`GET /api/v1/courses/:course_id/content_licenses`,
`GET /api/v1/groups/:group_id/content_licenses`, `GET /api/v1/users/:user_id/content_licenses`)]
(https://canvas.instructure.com/doc/api/files#method.usage_rights.licenses)
"""
function licenses(co::Union{Course,Group,User}; kwargs...)
    json, page_data = paged_request("GET", "/api/v1$(Internals.pid(co))/content_licenses"; kwargs...)
    return License.(json), page_data
end
