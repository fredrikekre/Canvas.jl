var documenterSearchIndex = {"docs":
[{"location":"files/#Files-API-1","page":"Files API","title":"Files API","text":"","category":"section"},{"location":"files/#","page":"Files API","title":"Files API","text":"This page documents the Files API of Canvas, see https://canvas.instructure.com/doc/api/files for details.","category":"page"},{"location":"files/#Files-API-Index-1","page":"Files API","title":"Files API Index","text":"","category":"section"},{"location":"files/#","page":"Files API","title":"Files API","text":"Pages = [\"files.md\"]","category":"page"},{"location":"files/#","page":"Files API","title":"Files API","text":"Canvas.quota\nCanvas.files\nCanvas.public_url\nCanvas.file\nCanvas.update_file\nCanvas.delete_file\nCanvas.folders\nCanvas.resolve_path\nCanvas.folder\nCanvas.update_folder\nCanvas.create_folder\nCanvas.delete_folder\nCanvas.copy_file\nCanvas.copy_folder\nCanvas.media_folder\nCanvas.usage_rights\nCanvas.remove_usage_rights\nCanvas.licenses","category":"page"},{"location":"files/#Canvas.quota","page":"Files API","title":"Canvas.quota","text":"Canvas.quota(co::Union{Course,Group,User}; kwargs...) -> Dict\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/files/quota\nGET /api/v1/groups/:group_id/files/quota\nGET /api/v1/users/:user_id/files/quota\n\nCanvas API documentation: Get quota information\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.files","page":"Files API","title":"Canvas.files","text":"Canvas.files(co::Union{Course,Group,User}; kwargs...) -> Vector{File}, page_data\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/files\nGET /api/v1/users/:user_id/files\nGET /api/v1/groups/:group_id/files\nGET /api/v1/folders/:id/files\n\nCanvas API documentation: List files\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.public_url","page":"Files API","title":"Canvas.public_url","text":"Canvas.public_url(f::File; kwargs...) -> Dict\n\nRequest endpoint: GET /api/v1/files/:id/public_url\n\nCanvas API documentation: Get public inline preview url\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.file","page":"Files API","title":"Canvas.file","text":"Canvas.file(f::File; kwargs...) -> File\n\nRequest endpoint: GET /api/v1/files/:id\n\nCanvas API documentation: Get file\n\n\n\n\n\nCanvas.file(co::Union{Course,Group,User}, f::File; kwargs...) -> File\n\n**Request endpoints:*\n\nGET /api/v1/courses/:course_id/files/:id\nGET /api/v1/groups/:group_id/files/:id\nGET /api/v1/users/:user_id/files/:id\n\nCanvas API documentation: Get file\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.update_file","page":"Files API","title":"Canvas.update_file","text":"Canvas.update_file(f::File; kwargs...) -> File\n\nRequest endpoint: PUT /api/v1/files/:id\n\nCanvas API documentation: Update file\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.delete_file","page":"Files API","title":"Canvas.delete_file","text":"Canvas.delete_file(f::File; kwargs...) -> File\n\nRequest endpoint: DELETE /api/v1/files/:id\n\nCanvas API documentation: Delete file\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.folders","page":"Files API","title":"Canvas.folders","text":"Canvas.folders(f::Folder; kwargs...) -> Vector{Folder}, page_data\n\nRequest endpoint: GET /api/v1/folders/:id/folders\n\nCanvas API documentation: List folders\n\n\n\n\n\nCanvas.folders(co::Union{Course,Group,User}; kwargs...) -> Vector{Folder}, page_data\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/folders\nGET /api/v1/groups/:group_id/folders\nGET /api/v1/users/:user_id/folders\n\nCanvas API documentation: List all folders\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.resolve_path","page":"Files API","title":"Canvas.resolve_path","text":"Canvas.resolve_path(co::Union{Course,Group,User}, path=\"\"; kwargs...) -> Vector{Folder}, page_data\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/folders/by_path\nGET /api/v1/groups/:group_id/folders/by_path\nGET /api/v1/users/:user_id/folders/by_path\n\nCanvas API documentation: Resolve path\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.folder","page":"Files API","title":"Canvas.folder","text":"Canvas.folder(f::Folder; kwargs...) -> Folder\n\nRequest endpoint: GET /api/v1/folders/:id\n\nCanvas API documentation: Get folder\n\n\n\n\n\nCanvas.folder(co::Union{Course,Group,User}, f::Folder; kwargs...) -> Folder\n\n**Request endpoints:*\n\nGET /api/v1/courses/:course_id/folders/:id\nGET /api/v1/groups/:group_id/folders/:id\nGET /api/v1/users/:user_id/folders/:id\n\nCanvas API documentation: Get folder\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.update_folder","page":"Files API","title":"Canvas.update_folder","text":"Canvas.update_folder(f::Folder; kwargs...) -> Folder\n\nRequest endpoint: PUT /api/v1/folders/:id\n\nCanvas API documentation: Update folder\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.create_folder","page":"Files API","title":"Canvas.create_folder","text":"Canvas.create_folder(co::Union{Course,Group,User,Folder}; kwargs...) -> Folder\n\n**Request endpoints:*\n\nPOST /api/v1/courses/:course_id/folders\nPOST /api/v1/groups/:group_id/folders\nPOST /api/v1/users/:user_id/folders\nPOST /api/v1/folders/:folder_id/folders\n\nCanvas API documentation: Create folder\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.delete_folder","page":"Files API","title":"Canvas.delete_folder","text":"Canvas.delete_folder(f::Folder; kwargs...) -> Dict\n\nRequest endpoint: DELETE /api/v1/folders/:id\n\nCanvas API documentation: Delete folder\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.copy_file","page":"Files API","title":"Canvas.copy_file","text":"Canvas.copy_file(f::Folder; kwargs...) -> File\n\nRequest endpoint: POST /api/v1/folders/:dest_folder_id/copy_file\n\nCanvas API documentation: Copy a file\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.copy_folder","page":"Files API","title":"Canvas.copy_folder","text":"Canvas.copy_folder(f::Folder; kwargs...) -> Folder\n\nRequest endpoint: POST /api/v1/folders/:dest_folder_id/copy_folder\n\nCanvas API documentation: Copy a folder\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.media_folder","page":"Files API","title":"Canvas.media_folder","text":"Canvas.media_folder(co::Union{Course,Group}; kwargs...) -> Folder\n\n**Request endpoints:*\n\nGET /api/v1/courses/:course_id/folders/media\nGET /api/v1/groups/:group_id/folders/media\n\nCanvas API documentation: Get uploaded media folder for user\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.usage_rights","page":"Files API","title":"Canvas.usage_rights","text":"Canvas.usage_rights(co::Union{Course,Group,User}; kwargs...) -> UsageRights\n\n**Request endpoints:*\n\nPUT /api/v1/courses/:course_id/usage_rights\nPUT /api/v1/groups/:group_id/usage_rights\nPUT /api/v1/users/:user_id/usage_rights\n\nCanvas API documentation: Set usage rights\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.remove_usage_rights","page":"Files API","title":"Canvas.remove_usage_rights","text":"Canvas.remove_usage_rights(co::Union{Course,Group,User}; kwargs...) -> Dict\n\n**Request endpoints:*\n\nDELETE /api/v1/courses/:course_id/usage_rights\nDELETE /api/v1/groups/:group_id/usage_rights\nDELETE /api/v1/users/:user_id/usage_rights\n\nCanvas API documentation: Remove usage rights\n\n\n\n\n\n","category":"function"},{"location":"files/#Canvas.licenses","page":"Files API","title":"Canvas.licenses","text":"Canvas.licenses(co::Union{Course,Group,User}; kwargs...) -> Vector{License}, page_data\n\n**Request endpoints:*\n\nGET /api/v1/courses/:course_id/content_licenses\nGET /api/v1/groups/:group_id/content_licenses\nGET /api/v1/users/:user_id/content_licenses\n\nCanvas API documentation: List licenses\n\n\n\n\n\n","category":"function"},{"location":"#**1.**-Introduction-1","page":"1. Introduction","title":"1. Introduction","text":"","category":"section"},{"location":"#","page":"1. Introduction","title":"1. Introduction","text":"Welcome to the documentation for Canvas.jl – a Julia interface to the Canvas LMS","category":"page"},{"location":"courses/#Courses-API-1","page":"Courses API","title":"Courses API","text":"","category":"section"},{"location":"courses/#","page":"Courses API","title":"Courses API","text":"This page documents the Courses API of Canvas, see https://canvas.instructure.com/doc/api/courses for details.","category":"page"},{"location":"courses/#Courses-API-Index-1","page":"Courses API","title":"Courses API Index","text":"","category":"section"},{"location":"courses/#","page":"Courses API","title":"Courses API","text":"Pages = [\"courses.md\"]","category":"page"},{"location":"courses/#","page":"Courses API","title":"Courses API","text":"Canvas.courses\nCanvas.create_course\nCanvas.upload_file\nCanvas.users\nCanvas.recent_students\nCanvas.user\nCanvas.content_share_users\nCanvas.preview_html\nCanvas.activity_stream\nCanvas.todo\nCanvas.delete_course\nCanvas.settings\nCanvas.update_settings\nCanvas.course\nCanvas.update_course\nCanvas.update_courses\nCanvas.reset_content\nCanvas.effective_due_dates\nCanvas.permissions","category":"page"},{"location":"courses/#Canvas.courses","page":"Courses API","title":"Canvas.courses","text":"Canvas.courses(; kwargs...) -> Vector{Course}, page_data\n\nCanvas API documentation: List your courses (GET /api/v1/courses)\n\n\n\n\n\nCanvas.courses(user::User; kwargs...) -> Vector{Course}, page_data\n\nCanvas API documentation: List courses for a user (GET /api/v1/users/:user_id/courses)\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.create_course","page":"Courses API","title":"Canvas.create_course","text":"Canvas.create_course(acc::Account; kwargs...) -> Course\n\nCanvas API documentation: Create a new course (POST /api/v1/accounts/:account_id/courses)\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.upload_file","page":"Courses API","title":"Canvas.upload_file","text":"Canvas.upload_file(c::Course, file; kwargs...) -> File\n\nCanvas API documentation: Upload a file to a course (POST /api/v1/courses/:course_id/files)\n\n\n\n\n\nCanvas.upload_file(f::Folder, file; kwargs...) -> File\n\nRequest endpoint: POST /api/v1/folders/:folder_id/files\n\nCanvas API documentation: Upload a file to a folder\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.users","page":"Courses API","title":"Canvas.users","text":"Canvas.users(course::Course; kwargs...) -> Vector{Course}, page_data\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/users\nGET /api/v1/courses/:course_id/search_users\nCanvas API documentation: List users in course\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.recent_students","page":"Courses API","title":"Canvas.recent_students","text":"Canvas.recent_students(course::Course; kwargs...) -> Vector{User}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/recent_students\nCanvas API documentation: List recently logged in students\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.user","page":"Courses API","title":"Canvas.user","text":"Canvas.user(course::Course, user::User; kwargs...) -> User\n\nRequest endpoint: GET /api/v1/courses/:course_id/users/:id\nCanvas API documentation: Get single user\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.content_share_users","page":"Courses API","title":"Canvas.content_share_users","text":"Canvas.content_share_users(course::Course; kwargs...) -> Vector{User}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/content_share_users\nCanvas API documentation: Search for content share users\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.preview_html","page":"Courses API","title":"Canvas.preview_html","text":"Canvas.preview_html(course::Course; kwargs...) -> Dict\n\nRequest endpoint: POST /api/v1/courses/:course_id/preview_html\nCanvas API documentation: Preview processed html\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.activity_stream","page":"Courses API","title":"Canvas.activity_stream","text":"Canvas.activity_stream(course::Course; summary::Bool=false, kwargs...) -> Vector{Dict}, page_data\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/activity_stream\nGET /api/v1/courses/:course_id/activity_stream/summary\nCanvas API documentation: Course activity stream\n\nand Course activity stream summary\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.todo","page":"Courses API","title":"Canvas.todo","text":"Canvas.todo(course::Course; kwargs...) -> Vector{Dict}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/todo\nCanvas API documentation: Course TODO items\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.delete_course","page":"Courses API","title":"Canvas.delete_course","text":"Canvas.delete_course(course::Course; kwargs...) -> Dict\n\nRequest endpoint: DELETE /api/v1/courses/:id\nCanvas API documentation: Delete/Conclude a course\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.settings","page":"Courses API","title":"Canvas.settings","text":"Canvas.settings(course::Course; kwargs...) -> Dict\n\nRequest endpoint: GET /api/v1/courses/:course_id/settings\nCanvas API documentation: Get course settings\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.update_settings","page":"Courses API","title":"Canvas.update_settings","text":"Canvas.update_settings(course::Course; kwargs...) -> Dict\n\nRequest endpoint: PUT /api/v1/courses/:course_id/settings\nCanvas API documentation: Update course settings\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.course","page":"Courses API","title":"Canvas.course","text":"Canvas.course(course::Course; kwargs...) -> Course\n\nRequest endpoint: GET /api/v1/courses/:id\nCanvas API documentation: Get a single course\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.update_course","page":"Courses API","title":"Canvas.update_course","text":"Canvas.update_course(course::Course; kwargs...) -> Course\n\nRequest endpoint: PUT /api/v1/courses/:id\nCanvas API documentation: Update a course\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.update_courses","page":"Courses API","title":"Canvas.update_courses","text":"Canvas.update_courses(acc::Account; kwargs...) -> Progress\n\nRequest endpoint: PUT /api/v1/accounts/:account_id/courses\nCanvas API documentation: Update courses\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.reset_content","page":"Courses API","title":"Canvas.reset_content","text":"Canvas.reset_content(course::Course; kwargs...) -> Course\n\nRequest endpoint: POST /api/v1/courses/:course_id/reset_content\nCanvas API documentation: Reset a course\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.effective_due_dates","page":"Courses API","title":"Canvas.effective_due_dates","text":"Canvas.effective_due_dates(course::Course; kwargs...) -> Dict\n\nRequest endpoint: GET /api/v1/courses/:course_id/effective_due_dates\nCanvas API documentation: Get effective due dates\n\n\n\n\n\n","category":"function"},{"location":"courses/#Canvas.permissions","page":"Courses API","title":"Canvas.permissions","text":"Canvas.permissions(course::Course; kwargs...) -> Dict\n\nRequest endpoint: GET /api/v1/courses/:course_id/permissions\nCanvas API documentation: Permissions\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Assignments-API-1","page":"Assignments API","title":"Assignments API","text":"","category":"section"},{"location":"assignments/#","page":"Assignments API","title":"Assignments API","text":"This page documents the Assignments API of Canvas, see https://canvas.instructure.com/doc/api/assignments for details.","category":"page"},{"location":"assignments/#Assignments-API-Index-1","page":"Assignments API","title":"Assignments API Index","text":"","category":"section"},{"location":"assignments/#","page":"Assignments API","title":"Assignments API","text":"Pages = [\"assignments.md\"]","category":"page"},{"location":"assignments/#","page":"Assignments API","title":"Assignments API","text":"Canvas.delete_assignment\nCanvas.assignments\nCanvas.assignment\nCanvas.update_assignment\nCanvas.assignment_overrides\nCanvas.assignment_override\nCanvas.create_assignment_override\nCanvas.update_assignment_override\nCanvas.delete_assignment_override","category":"page"},{"location":"assignments/#Canvas.delete_assignment","page":"Assignments API","title":"Canvas.delete_assignment","text":"Canvas.delete_assignment(co::Union{Course,Group,User}; kwargs...) -> Assignment\n\nRequest endpoint: DELETE /api/v1/courses/:course_id/assignments/:id\nCanvas API documentation: Delete an assignment\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.assignments","page":"Assignments API","title":"Canvas.assignments","text":"Canvas.assignments(c::Course; kwargs...) -> Vector{Assignment}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments\nCanvas API documentation: List assignments\n\n\n\n\n\nCanvas.assignments(c::Course, a::AssignmentGroup; kwargs...) -> Vector{Assignment}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments\nCanvas API documentation: List assignments\n\n\n\n\n\nCanvas.assignments(u::User, c::Course; kwargs...) -> Vector{Assignment}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments\nCanvas API documentation: List assignments for user\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.assignment","page":"Assignments API","title":"Canvas.assignment","text":"Canvas.assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments/:id\nCanvas API documentation: Get a single assignment\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.update_assignment","page":"Assignments API","title":"Canvas.update_assignment","text":"Canvas.update_assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nRequest endpoint: PUT /api/v1/courses/:course_id/assignments/:id\nCanvas API documentation: Edit an assignment\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.assignment_overrides","page":"Assignments API","title":"Canvas.assignment_overrides","text":"Canvas.assignment_overrides(c::Course, a::Assignment; kwargs...) -> Vector{AssignmentOverride}, page_data\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides\nCanvas API documentation: List assignment overrides\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.assignment_override","page":"Assignments API","title":"Canvas.assignment_override","text":"Canvas.assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nRequest endpoint: GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id\nCanvas API documentation: Get a single assignment overrides\n\n\n\n\n\nCanvas.assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...) -> AssignmentOverride\n\nRequest endpoints:\n\nGET /api/v1/groups/:group_id/assignments/:assignment_id/override\nGET /api/v1/sections/:course_section_id/assignments/:assignment_id/override\nCanvas API documentation:\nRedirect to the assignment override for a group\nRedirect to the assignment override for a section\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.create_assignment_override","page":"Assignments API","title":"Canvas.create_assignment_override","text":"Canvas.create_assignment_override(c::Course, a::Assignment; kwargs...) -> AssignmentOverride\n\nRequest endpoint: POST /api/v1/courses/:course_id/assignments/:assignment_id/overrides\nCanvas API documentation: Create an assignment override\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.update_assignment_override","page":"Assignments API","title":"Canvas.update_assignment_override","text":"Canvas.update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nRequest endpoint: PUT /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id\nCanvas API documentation: Update an assignment override\n\n\n\n\n\n","category":"function"},{"location":"assignments/#Canvas.delete_assignment_override","page":"Assignments API","title":"Canvas.delete_assignment_override","text":"Canvas.delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nRequest endpoint: DELETE /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id\nCanvas API documentation: Update an assignment override\n\n\n\n\n\n","category":"function"}]
}
