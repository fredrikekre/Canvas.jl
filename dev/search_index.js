var documenterSearchIndex = {"docs":
[{"location":"endpoints/courses/#Courses-API","page":"Courses API","title":"Courses API","text":"","category":"section"},{"location":"endpoints/courses/","page":"Courses API","title":"Courses API","text":"This page documents the Courses API of Canvas, see https://canvas.instructure.com/doc/api/courses for details.","category":"page"},{"location":"endpoints/courses/","page":"Courses API","title":"Courses API","text":"Pages = [\"courses.md\"]","category":"page"},{"location":"endpoints/courses/","page":"Courses API","title":"Courses API","text":"","category":"page"},{"location":"endpoints/courses/","page":"Courses API","title":"Courses API","text":"Canvas.courses\nCanvas.course\nCanvas.create_course\nCanvas.update_course\nCanvas.settings\nCanvas.update_settings\nCanvas.delete_course\nCanvas.reset_content\nCanvas.users\nCanvas.user\nCanvas.recent_students\nCanvas.upload_file(::Canvas.Course, ::String)\nCanvas.content_share_users\nCanvas.preview_html\nCanvas.activity_stream\nCanvas.todo\nCanvas.effective_due_dates\nCanvas.permissions","category":"page"},{"location":"endpoints/courses/#Canvas.courses","page":"Courses API","title":"Canvas.courses","text":"Canvas.courses(; kwargs...) -> Vector{Course}, page_data\n\nReturn a paginated list of courses for the authenticated user. Return a vector of Courses and a dictionary with page data.\n\nCanvas API documentation: List your courses (GET /api/v1/courses)\n\n\n\n\n\nCanvas.courses(user::User; kwargs...) -> Vector{Course}, page_data\n\nReturn a paginated list of courses for the specified user. Return a vector of Courses and a dictionary with page data.\n\nCanvas API documentation: List courses for a user (GET /api/v1/users/:user_id/courses)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.course","page":"Courses API","title":"Canvas.course","text":"Canvas.course(course::Course; kwargs...) -> Course\n\nReturn details about a single course specified by id. Return a Course.\n\nCanvas API documentation: Get a single course (GET /api/v1/courses/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.create_course","page":"Courses API","title":"Canvas.create_course","text":"Canvas.create_course(acc::Account; kwargs...) -> Course\n\nCreate a new course. Return a Course.\n\nCanvas API documentation: Create a new course (POST /api/v1/accounts/:account_id/courses)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.update_course","page":"Courses API","title":"Canvas.update_course","text":"Canvas.update_course(course::Course; kwargs...) -> Course\n\nUpdate an existing course and return the new details. Return a Course.\n\nCanvas API documentation: Update a course (PUT /api/v1/courses/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.settings","page":"Courses API","title":"Canvas.settings","text":"Canvas.settings(course::Course; kwargs...) -> Dict\n\nReturn course settings as a dictionary.\n\nCanvas API documentation: Get course settings (GET /api/v1/courses/:course_id/settings)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.update_settings","page":"Courses API","title":"Canvas.update_settings","text":"Canvas.update_settings(course::Course; kwargs...) -> Dict\n\nUpdate course settings. Return a dictionary.\n\nCanvas API documentation: Update course settings (PUT /api/v1/courses/:course_id/settings)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.delete_course","page":"Courses API","title":"Canvas.delete_course","text":"Canvas.delete_course(course::Course; kwargs...) -> Dict\n\nDelete or conclude an existing course.\n\nCanvas API documentation: Delete/Conclude a course (DELETE /api/v1/courses/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.reset_content","page":"Courses API","title":"Canvas.reset_content","text":"Canvas.reset_content(course::Course; kwargs...) -> Course\n\nDelete the course and create a new equivalent course with no content but all sections and users moved overs. Return a Course.\n\nCanvas API documentation: Reset a course (POST /api/v1/courses/:course_id/reset_content)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.users","page":"Courses API","title":"Canvas.users","text":"Canvas.users(course::Course; kwargs...) -> Vector{User}, page_data\n\nReturn a paginated list of users in the course. Return a vector of Users and a dictionary with page data.\n\nCanvas API documentation: List users in course (GET /api/v1/courses/:course_id/users)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.user","page":"Courses API","title":"Canvas.user","text":"Canvas.user(course::Course, user::User; kwargs...) -> User\n\nReturn information about a single user in the course. Return a User.\n\nCanvas API documentation: Get single user (GET /api/v1/courses/:course_id/users/:id)\n\n\n\n\n\nCanvas.user(; kwargs...) -> User\n\nReturn the details about the a user specified by id. Return a User.\n\nCanvas API documentation: Show user details (GET /api/v1/users/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.recent_students","page":"Courses API","title":"Canvas.recent_students","text":"Canvas.recent_students(course::Course; kwargs...) -> Vector{User}, page_data\n\nReturn a paginated list of users in the course ordered by how recently they have logged in. Return a vector of Users and a dictionary of page data.\n\nCanvas API documentation: List recently logged in students (GET /api/v1/courses/:course_id/recent_students)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.upload_file-Tuple{Canvas.Course,String}","page":"Courses API","title":"Canvas.upload_file","text":"Canvas.upload_file(c::Course, file::String; kwargs...) -> File\n\nUpload a file to the course. Return a File.\n\nCanvas API documentation: Upload a file to a course (POST /api/v1/courses/:course_id/files)\n\n\n\n\n\n","category":"method"},{"location":"endpoints/courses/#Canvas.content_share_users","page":"Courses API","title":"Canvas.content_share_users","text":"Canvas.content_share_users(course::Course; kwargs...) -> Vector{User}, page_data\n\nReturn a paginated list of users you can share content with. Return a vector of Users and a dictionary of page data.\n\nCanvas API documentation: Search for content share users (GET /api/v1/courses/:course_id/content_share_users)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.preview_html","page":"Courses API","title":"Canvas.preview_html","text":"Canvas.preview_html(course::Course; kwargs...) -> Dict\n\nPreview HTML content processed for this course. Return a dictionary.\n\nCanvas API documentation: Preview processed html (POST /api/v1/courses/:course_id/preview_html)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.activity_stream","page":"Courses API","title":"Canvas.activity_stream","text":"Canvas.activity_stream(course::Course; summary::Bool=false, kwargs...) -> Vector{Dict}, page_data\n\nReturn the authenticated users course-specific activity stream paginated.\n\nRequest endpoints:\n\nGET /api/v1/courses/:course_id/activity_stream\nGET /api/v1/courses/:course_id/activity_stream/summary\n\nCanvas API documentation:\n\nCourse activity stream (GET /api/v1/courses/:course_id/activity_stream)\nCourse activity stream (GET /api/v1/courses/:course_id/activity_stream/summary)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.todo","page":"Courses API","title":"Canvas.todo","text":"Canvas.todo(course::Course; kwargs...) -> Vector{Dict}, page_data\n\nReturn the authenticated users course-specific todo items.\n\nCanvas API documentation: Course TODO items (GET /api/v1/courses/:course_id/todo)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.effective_due_dates","page":"Courses API","title":"Canvas.effective_due_dates","text":"Canvas.effective_due_dates(course::Course; kwargs...) -> Dict\n\nFor each assignment in the course, returns each assigned student's ID and their corresponding due date along with some grading period data.\n\nCanvas API documentation: Get effective due dates (GET /api/v1/courses/:course_id/effective_due_dates)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/courses/#Canvas.permissions","page":"Courses API","title":"Canvas.permissions","text":"Canvas.permissions(course::Course; kwargs...) -> Dict\n\nReturn permissions for the authenticated user in the specified course. Return a dictionary.\n\nCanvas API documentation: Permissions (GET /api/v1/courses/:course_id/permissions)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Assignments-API","page":"Assignments API","title":"Assignments API","text":"","category":"section"},{"location":"endpoints/assignments/","page":"Assignments API","title":"Assignments API","text":"This page documents the Assignments API of Canvas, see https://canvas.instructure.com/doc/api/assignments for details.","category":"page"},{"location":"endpoints/assignments/","page":"Assignments API","title":"Assignments API","text":"Pages = [\"assignments.md\"]","category":"page"},{"location":"endpoints/assignments/","page":"Assignments API","title":"Assignments API","text":"","category":"page"},{"location":"endpoints/assignments/","page":"Assignments API","title":"Assignments API","text":"Canvas.assignments\nCanvas.assignment\nCanvas.create_assignment\nCanvas.update_assignment\nCanvas.delete_assignment\nCanvas.assignment_overrides\nCanvas.assignment_override\nCanvas.create_assignment_override\nCanvas.update_assignment_override\nCanvas.delete_assignment_override","category":"page"},{"location":"endpoints/assignments/#Canvas.assignments","page":"Assignments API","title":"Canvas.assignments","text":"Canvas.assignments(c::Course; kwargs...) -> Vector{Assignment}, page_data\n\nReturn the paginated list of assignments for the course. Return a vector of Assignments and a dictionary with page data.\n\nCanvas API documentation: List assignments (GET /api/v1/courses/:course_id/assignments)\n\n\n\n\n\nCanvas.assignments(c::Course, a::AssignmentGroup; kwargs...) -> Vector{Assignment}, page_data\n\nReturn the paginated list of assignments for the course and assignment group. Return a vector of Assignments and a dictionary with page data.\n\nCanvas API documentation: List assignments (GET /api/v1/courses/:course_id/assignment_groups/:assignment_group_id/assignments)\n\n\n\n\n\nCanvas.assignments(u::User, c::Course; kwargs...) -> Vector{Assignment}, page_data\n\nReturn the paginated list of assignments for the specified user and course. Return a vector of Assignments and a dictionary with page data.\n\nCanvas API documentation: List assignments for user(GET /api/v1/users/:user_id/courses/:course_id/assignments)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.assignment","page":"Assignments API","title":"Canvas.assignment","text":"Canvas.assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nReturn the assignment given by id. Return an Assignment.\n\nCanvas API documentation: Get a single assignment (GET /api/v1/courses/:course_id/assignments/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.create_assignment","page":"Assignments API","title":"Canvas.create_assignment","text":"Canvas.create_assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nCreate a new assignment for the course and return the details. Return an Assignment.\n\nCanvas API documentation: Create an assignment (POST /api/v1/courses/:course_id/assignments)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.update_assignment","page":"Assignments API","title":"Canvas.update_assignment","text":"Canvas.update_assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nModify an existing assignment and return the new details. Return an Assignment.\n\nCanvas API documentation: Edit an assignment (PUT /api/v1/courses/:course_id/assignments/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.delete_assignment","page":"Assignments API","title":"Canvas.delete_assignment","text":"Canvas.delete_assignment(c::Course, a::Assignment; kwargs...) -> Assignment\n\nDelete the given assignment and return the former details. Return an Assignment.\n\nCanvas API documentation: Delete an assignment (DELETE /api/v1/courses/:course_id/assignments/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.assignment_overrides","page":"Assignments API","title":"Canvas.assignment_overrides","text":"Canvas.assignment_overrides(c::Course, a::Assignment; kwargs...) -> Vector{AssignmentOverride}, page_data\n\nReturn the paginated list of overrides for this course and assignment. Return a vector of AssignmentOverrides and a dictionary with page data.\n\nCanvas API documentation: List assignment overrides (GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.assignment_override","page":"Assignments API","title":"Canvas.assignment_override","text":"Canvas.assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nReturn the details of override specified by id. Return an AssignmentOverride.\n\nCanvas API documentation: Get a single assignment overrides (GET /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id)\n\n\n\n\n\nCanvas.assignment_override(co::Union{Group,Section}, a::Assignment; kwargs...) -> AssignmentOverride\n\nReturn the override for the given group or section associated with the assignment (404 otherwise). Return an AssignmentOverride.\n\nCanvas API documentation:\n\nRedirect to the assignment override for a group (GET /api/v1/groups/:group_id/assignments/:assignment_id/override)\nRedirect to the assignment override for a section (GET /api/v1/sections/:course_section_id/assignments/:assignment_id/override)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.create_assignment_override","page":"Assignments API","title":"Canvas.create_assignment_override","text":"Canvas.create_assignment_override(c::Course, a::Assignment; kwargs...) -> AssignmentOverride\n\nCreate an assignment override. One of student_ids, group_id or course_section_id must be present, see API specification for details. Return the AssignmentOverride.\n\nCanvas API documentation: Create an assignment override (POST /api/v1/courses/:course_id/assignments/:assignment_id/overrides)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.update_assignment_override","page":"Assignments API","title":"Canvas.update_assignment_override","text":"Canvas.update_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nUpdate the assignment override. All current overriden values must be supplied if the should be retained, see API specification for details. Return the AssignmentOverride.\n\nCanvas API documentation: Update an assignment override (PUT /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/assignments/#Canvas.delete_assignment_override","page":"Assignments API","title":"Canvas.delete_assignment_override","text":"Canvas.delete_assignment_override(c::Course, a::Assignment, o::AssignmentOverride; kwargs...) -> AssignmentOverride\n\nDelete and override and return the former details. Return an AssignmentOverride.\n\nCanvas API documentation: Update an assignment override (DELETE /api/v1/courses/:course_id/assignments/:assignment_id/overrides/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Files-API","page":"Files API","title":"Files API","text":"","category":"section"},{"location":"endpoints/files/","page":"Files API","title":"Files API","text":"This page documents the Files API of Canvas, see https://canvas.instructure.com/doc/api/files for details.","category":"page"},{"location":"endpoints/files/","page":"Files API","title":"Files API","text":"Pages = [\"files.md\"]","category":"page"},{"location":"endpoints/files/","page":"Files API","title":"Files API","text":"","category":"page"},{"location":"endpoints/files/","page":"Files API","title":"Files API","text":"Canvas.files\nCanvas.file\nCanvas.upload_file(::Canvas.Folder, ::String)\nCanvas.update_file\nCanvas.delete_file\nCanvas.copy_file\nCanvas.folders\nCanvas.folder\nCanvas.create_folder\nCanvas.update_folder\nCanvas.delete_folder\nCanvas.copy_folder\nCanvas.quota\nCanvas.preview_url\nCanvas.resolve_path\nCanvas.media_folder\nCanvas.update_usage_rights\nCanvas.remove_usage_rights\nCanvas.licenses","category":"page"},{"location":"endpoints/files/#Canvas.files","page":"Files API","title":"Canvas.files","text":"Canvas.files(co::Union{Course,Group,User,Folder}; kwargs...) -> Vector{File}, page_data\n\nReturn a paginated  list of files for the course/groupt/user/folder. Return a vector of Files and a dictionary of page data.\n\nCanvas API documentation: List files (GET /api/v1/courses/:course_id/files, GET /api/v1/users/:user_id/files, GET /api/v1/groups/:group_id/files, GET /api/v1/folders/:id/files)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.file","page":"Files API","title":"Canvas.file","text":"Canvas.file(f::File; kwargs...) -> File\n\nGet the details of a single file. Return a File.\n\nCanvas API documentation: Get file (GET /api/v1/files/:id)\n\n\n\n\n\nCanvas.file(co::Union{Course,Group,User}, f::File; kwargs...) -> File\n\nGet the details of a single file. Return a File.\n\nCanvas API documentation: Get file (GET /api/v1/courses/:course_id/files/:id, GET /api/v1/groups/:group_id/files/:id, GET /api/v1/users/:user_id/files/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.upload_file-Tuple{Canvas.Folder,String}","page":"Files API","title":"Canvas.upload_file","text":"Canvas.upload_file(f::Folder, file::String; kwargs...) -> File\n\nUpload a file to a folder. Return a File.\n\nCanvas API documentation: Upload a file (POST /api/v1/folders/:folder_id/files)\n\n\n\n\n\n","category":"method"},{"location":"endpoints/files/#Canvas.update_file","page":"Files API","title":"Canvas.update_file","text":"Canvas.update_file(f::File; kwargs...) -> File\n\nUpdate settings for the specified file. Return a File.\n\nCanvas API documentation: Update file (PUT /api/v1/files/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.delete_file","page":"Files API","title":"Canvas.delete_file","text":"Canvas.delete_file(f::File; kwargs...) -> File\n\nDelete the specified file and return the details. Return a File.\n\nCanvas API documentation: Delete file (DELETE /api/v1/files/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.copy_file","page":"Files API","title":"Canvas.copy_file","text":"Canvas.copy_file(f::Folder; kwargs...) -> File\n\nCopy a file into the specified folder. Return a File.\n\nCanvas API documentation: Copy a file (POST /api/v1/folders/:dest_folder_id/copy_file)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.folders","page":"Files API","title":"Canvas.folders","text":"Canvas.folders(f::Folder; kwargs...) -> Vector{Folder}, page_data\n\nReturn a paginated list of folders in the specified folder. Return a vector of Folders and a dictionary with page data.\n\nCanvas API documentation: List folders (GET /api/v1/folders/:id/folders)\n\n\n\n\n\nCanvas.folders(co::Union{Course,Group,User}; kwargs...) -> Vector{Folder}, page_data\n\nReturn a paginated, flattened, list of all folders in the course/group/user. Return a vector of Folders and a dictionary with page data.\n\nCanvas API documentation: List all folders (GET /api/v1/courses/:course_id/folders, GET /api/v1/groups/:group_id/folders, GET /api/v1/users/:user_id/folders)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.folder","page":"Files API","title":"Canvas.folder","text":"Canvas.folder(f::Folder; kwargs...) -> Folder\n\nReturn the details of a folder specified by id. Return a Folder.\n\nCanvas API documentation: Get folder (GET /api/v1/folders/:id)\n\n\n\n\n\nCanvas.folder(co::Union{Course,Group,User}, f::Folder; kwargs...) -> Folder\n\nReturn the details of a folder specified by id. Return a Folder.\n\nCanvas API documentation: Get folder (GET /api/v1/courses/:course_id/folders/:id, GET /api/v1/groups/:group_id/folders/:id, GET /api/v1/users/:user_id/folders/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.create_folder","page":"Files API","title":"Canvas.create_folder","text":"Canvas.create_folder(co::Union{Course,Group,User,Folder}; kwargs...) -> Folder\n\nCreate a new folder in the course/group/user/folder. Return a Folder.\n\nCanvas API documentation: Create folder (POST /api/v1/courses/:course_id/folders, POST /api/v1/groups/:group_id/folders, POST /api/v1/users/:user_id/folders, POST /api/v1/folders/:folder_id/folders)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.update_folder","page":"Files API","title":"Canvas.update_folder","text":"Canvas.update_folder(f::Folder; kwargs...) -> Folder\n\nUpdate settings for the folder. Return a Folder.\n\nCanvas API documentation: Update folder (PUT /api/v1/folders/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.delete_folder","page":"Files API","title":"Canvas.delete_folder","text":"Canvas.delete_folder(f::Folder; kwargs...) -> Dict\n\nDelete the folder. Return a dictionary.\n\nCanvas API documentation: Delete folder (DELETE /api/v1/folders/:id)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.copy_folder","page":"Files API","title":"Canvas.copy_folder","text":"Canvas.copy_folder(f::Folder; kwargs...) -> Folder\n\nCopy a folder and its contents into the specified folder. Return a Folder.\n\nCanvas API documentation: Copy a folder (POST /api/v1/folders/:dest_folder_id/copy_folder)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.quota","page":"Files API","title":"Canvas.quota","text":"Canvas.quota(co::Union{Course,Group,User}; kwargs...) -> Dict\n\nReturn the total and used storage quota for the course/group/user. Return a dictionary.\n\nCanvas API documentation: Get quota information (GET /api/v1/courses/:course_id/files/quota, GET /api/v1/groups/:group_id/files/quota, GET /api/v1/users/:user_id/files/quota)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.preview_url","page":"Files API","title":"Canvas.preview_url","text":"Canvas.preview_url(f::File; kwargs...) -> Dict\n\nDetermine the URL that should be used for inline preview of the file. Return a dictionary.\n\nCanvas API documentation: Get public inline preview url (GET /api/v1/files/:id/public_url)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.resolve_path","page":"Files API","title":"Canvas.resolve_path","text":"Canvas.resolve_path(co::Union{Course,Group,User}, path=\"\"; kwargs...) -> Vector{Folder}\n\nReturn the list of folders from the root of the course/group/user to the path path. Return a vector of Folders.\n\nCanvas API documentation: Resolve path (GET /api/v1/courses/:course_id/folders/by_path, GET /api/v1/groups/:group_id/folders/by_path, GET /api/v1/users/:user_id/folders/by_path)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.media_folder","page":"Files API","title":"Canvas.media_folder","text":"Canvas.media_folder(co::Union{Course,Group}; kwargs...) -> Folder\n\nReturn the details for a designated upload folder that the user has rights to upload to. Return a Folder.\n\nCanvas API documentation: Get uploaded media folder for user (GET /api/v1/courses/:course_id/folders/media, GET /api/v1/groups/:group_id/folders/media)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.update_usage_rights","page":"Files API","title":"Canvas.update_usage_rights","text":"Canvas.update_usage_rights(co::Union{Course,Group,User}; kwargs...) -> UsageRights\n\nSet copyright and license information for one or more files. Return a UsageRights.\n\nCanvas API documentation: Set usage rights (PUT /api/v1/courses/:course_id/usage_rights, PUT /api/v1/groups/:group_id/usage_rights, PUT /api/v1/users/:user_id/usage_rights)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.remove_usage_rights","page":"Files API","title":"Canvas.remove_usage_rights","text":"Canvas.remove_usage_rights(co::Union{Course,Group,User}; kwargs...) -> Dict\n\nRemove copyright and license information associated with one or more files.\n\nCanvas API documentation: Remove usage rights (DELETE /api/v1/courses/:course_id/usage_rights, DELETE /api/v1/groups/:group_id/usage_rights, DELETE /api/v1/users/:user_id/usage_rights)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/files/#Canvas.licenses","page":"Files API","title":"Canvas.licenses","text":"Canvas.licenses(co::Union{Course,Group,User}; kwargs...) -> Vector{License}, page_data\n\nReturn a paginated list of licenses that can be applied to files. Return a vector of Licenses and a dictionary with page data.\n\nCanvas API documentation: List licenses (GET /api/v1/courses/:course_id/content_licenses, GET /api/v1/groups/:group_id/content_licenses, GET /api/v1/users/:user_id/content_licenses)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/submission_comments/#Submisson-Comments-API","page":"Submisson Comments API","title":"Submisson Comments API","text":"","category":"section"},{"location":"endpoints/submission_comments/","page":"Submisson Comments API","title":"Submisson Comments API","text":"This page documents the Submissons API of Canvas, see https://canvas.instructure.com/doc/api/submission_comments for details.","category":"page"},{"location":"endpoints/submission_comments/","page":"Submisson Comments API","title":"Submisson Comments API","text":"Pages = [\"submission_comments.md\"]","category":"page"},{"location":"endpoints/submission_comments/","page":"Submisson Comments API","title":"Submisson Comments API","text":"","category":"page"},{"location":"endpoints/submission_comments/","page":"Submisson Comments API","title":"Submisson Comments API","text":"Canvas.upload_file(::Canvas.Course, ::Canvas.Assignment, ::Canvas.User, ::String)","category":"page"},{"location":"endpoints/submission_comments/#Canvas.upload_file-Tuple{Canvas.Course,Canvas.Assignment,Canvas.User,String}","page":"Submisson Comments API","title":"Canvas.upload_file","text":"Canvas.upload_file(c::Course, a::Assignment, u::User, file; kwargs...) -> File\n\nUpload a file to attach to a submission comment. Return a File.\n\nCanvas API documentation: Upload a file (POST /api/v1/courses/:course_id/assignments/:assignment_id/submissions/:user_id/comments/files)\n\n\n\n\n\n","category":"method"},{"location":"endpoints/users/#Users-API","page":"Users API","title":"Users API","text":"","category":"section"},{"location":"endpoints/users/","page":"Users API","title":"Users API","text":"This page documents the Files API of Canvas, see https://canvas.instructure.com/doc/api/users for details.","category":"page"},{"location":"endpoints/users/","page":"Users API","title":"Users API","text":"Pages = [\"users.md\"]","category":"page"},{"location":"endpoints/users/","page":"Users API","title":"Users API","text":"","category":"page"},{"location":"endpoints/users/","page":"Users API","title":"Users API","text":"Canvas.whoami\nCanvas.user","category":"page"},{"location":"endpoints/users/#Canvas.whoami","page":"Users API","title":"Canvas.whoami","text":"Canvas.whoami(; kwargs...) -> User\n\nReturn the details about the authenticated users. Return a User.\n\nCanvas API documentation: Show user details (GET /api/v1/users/self)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/submissions/#Submissons-API","page":"Submissons API","title":"Submissons API","text":"","category":"section"},{"location":"endpoints/submissions/","page":"Submissons API","title":"Submissons API","text":"This page documents the Submissons API of Canvas, see https://canvas.instructure.com/doc/api/submissions for details.","category":"page"},{"location":"endpoints/submissions/","page":"Submissons API","title":"Submissons API","text":"Pages = [\"submissions.md\"]","category":"page"},{"location":"endpoints/submissions/","page":"Submissons API","title":"Submissons API","text":"","category":"page"},{"location":"endpoints/submissions/","page":"Submissons API","title":"Submissons API","text":"Canvas.submissions\nCanvas.grade_submission","category":"page"},{"location":"endpoints/submissions/#Canvas.submissions","page":"Submissons API","title":"Canvas.submissions","text":"Canvas.submissions(c::Union{Course,Section}, a::Assignment; kwargs...) -> Vector{Submission}, page_data\n\nReturn a paginated list of all existing submissions for an assignment. Return a vector of Submission and a dictionary with page data.\n\nCanvas API documentation: List assignment submissions (GET /api/v1/courses/:course_id/assignments/:assignment_id/submissions, GET /api/v1/sections/:section_id/assignments/:assignment_id/submissions)\n\n\n\n\n\n","category":"function"},{"location":"endpoints/submissions/#Canvas.grade_submission","page":"Submissons API","title":"Canvas.grade_submission","text":"Canvas.grade_submission(c::Union{Course,Section}, a::Assignment, user::User; kwargs...) -> Dict\n\nComment on and/or update the grading for a student's assignment submissions.\n\nCanvas API documentation: Grade or comment on a submission (PUT /api/v1/courses/:course_id/assignments/:assignment_id/submissions/:user_id, PUT /api/v1/sections/:section_id/assignments/:assignment_id/submissions/:user_id)\n\n\n\n\n\n","category":"function"},{"location":"#**1.**-Introduction","page":"1. Introduction","title":"1. Introduction","text":"","category":"section"},{"location":"","page":"1. Introduction","title":"1. Introduction","text":"Welcome to the documentation for Canvas.jl – a Julia interface to the Canvas LMS","category":"page"}]
}
