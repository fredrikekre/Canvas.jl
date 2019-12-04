# User
struct User <: CanvasObject
    # The ID of the user.
    id::Union{Int,Nothing}
    # The name of the user.
    name::Union{String,Nothing}
    # The name of the user that is should be used for sorting groups of users, such as
    # in the gradebook.
    sortable_name::Union{String,Nothing}
    # A short name the user has selected, for use in conversations or other less formal
    # places through the site.
    short_name::Union{String,Nothing}
    # The SIS ID associated with the user. This field is only included if the user came
    # from a SIS import and has permissions to view SIS information.
    sis_user_id::Union{String,Nothing}
    # The id of the SIS import. This field is only included if the user came from a SIS
    # import and has permissions to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # The integration_id associated with the user. This field is only included if the user
    # came from a SIS import and has permissions to view SIS information.
    integration_id::Union{String,Nothing}
    # The unique login id for the user. This is what the user uses to log in to Canvas.
    login_id::Union{String,Nothing}
    # If avatars are enabled, this field will be included and contain a url to retrieve
    # the user's avatar.
    avatar_url::Union{String,Nothing}
    # Optional: This field can be requested with certain API calls, and will return a list
    # of the users active enrollments. See the List enrollments API for more details about
    # the format of these records.
    enrollments::Union{Vector,Nothing}
    # Optional: This field can be requested with certain API calls, and will return the
    # users primary email address.
    email::Union{String,Nothing}
    # Optional: This field can be requested with certain API calls, and will return the
    # users locale in RFC 5646 format.
    locale::Union{String,Nothing}
    # Optional: This field is only returned in certain API calls, and will return a timestamp
    # representing the last time the user logged in to canvas.
    last_login::Union{String,Nothing}
    # Optional: This field is only returned in certain API calls, and will return the IANA
    # time zone name of the user's preferred timezone.
    time_zone::Union{String,Nothing}
    # Optional: The user's bio.
    bio::Union{String,Nothing}
end
User(data::Dict) = json2canvas(User, data)

# CalendarLink
struct CalendarLink <: CanvasObject
    # The URL of the calendar in ICS format
    ics::Union{String,Nothing}
end
CalendarLink(data::Dict) = json2canvas(CalendarLink, data)

# Term
struct Term <: CanvasObject
    id::Union{Int,Nothing}
    name::Union{String,Nothing}
    start_at::Union{Dates.DateTime,Nothing}
    end_at::Union{Dates.DateTime,Nothing}
end
Term(data::Dict) = json2canvas(Term, data)

# CourseProgress
struct CourseProgress <: CanvasObject
    # total number of requirements from all modules
    requirement_count::Union{Int,Nothing}
    # total number of requirements the user has completed from all modules
    requirement_completed_count::Union{Int,Nothing}
    # url to next module item that has an unmet requirement. null if the user has completed
    # the course or the current module does not require sequential progress
    next_requirement_url::Union{String,Nothing}
    # date the course was completed. null if the course has not been completed by this
    # user
    completed_at::Union{Dates.DateTime,Nothing}
end
CourseProgress(data::Dict) = json2canvas(CourseProgress, data)

# Course
struct Course <: CanvasObject
    # the unique identifier for the course
    id::Union{Int,Nothing}
    # the SIS identifier for the course, if defined. This field is only included if the
    # user has permission to view SIS information.
    sis_course_id::Union{String,Nothing}
    # the UUID of the course
    uuid::Union{String,Nothing}
    # the integration identifier for the course, if defined. This field is only included
    # if the user has permission to view SIS information.
    integration_id::Union{String,Nothing}
    # the unique identifier for the SIS import. This field is only included if the user
    # has permission to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # the full name of the course
    name::Union{String,Nothing}
    # the course code
    course_code::Union{String,Nothing}
    # the current state of the course one of 'unpublished', 'available', 'completed', or
    # 'deleted'
    workflow_state::Union{String,Nothing}
    # the account associated with the course
    account_id::Union{Int,Nothing}
    # the root account associated with the course
    root_account_id::Union{Int,Nothing}
    # the enrollment term associated with the course
    enrollment_term_id::Union{Int,Nothing}
    # the grading standard associated with the course
    grading_standard_id::Union{Int,Nothing}
    # the grade_passback_setting set on the course
    grade_passback_setting::Union{String,Nothing}
    # the date the course was created.
    created_at::Union{Dates.DateTime,Nothing}
    # the start date for the course, if applicable
    start_at::Union{Dates.DateTime,Nothing}
    # the end date for the course, if applicable
    end_at::Union{Dates.DateTime,Nothing}
    # the course-set locale, if applicable
    locale::Union{String,Nothing}
    # A list of enrollments linking the current user to the course. for student enrollments,
    # grading information may be included if include[]=total_scores
    enrollments::Union{Vector,Nothing}
    # optional: the total number of active and invited students in the course
    total_students::Union{Int,Nothing}
    # course calendar
    calendar::Union{CalendarLink,Nothing}
    # the type of page that users will see when they first visit the course - 'feed': Recent
    # Activity Dashboard - 'wiki': Wiki Front Page - 'modules': Course Modules/Sections
    # Page - 'assignments': Course Assignments List - 'syllabus': Course Syllabus Page
    # other types may be added in the future
    default_view::Union{String,Nothing}
    # optional: user-generated HTML for the course syllabus
    syllabus_body::Union{String,Nothing}
    # optional: the number of submissions needing grading returned only if the current
    # user has grading rights and include[]=needs_grading_count
    needs_grading_count::Union{Int,Nothing}
    # optional: the enrollment term object for the course returned only if include[]=term
    term::Union{Term,Nothing}
    # optional: information on progress through the course returned only if include[]=course_progress
    course_progress::Union{CourseProgress,Nothing}
    # weight final grade based on assignment group percentages
    apply_assignment_group_weights::Union{Bool,Nothing}
    # optional: the permissions the user has for the course. returned only for a single
    # course and include[]=permissions
    permissions::Union{Dict,Nothing}
    is_public::Union{Bool,Nothing}
    is_public_to_auth_users::Union{Bool,Nothing}
    public_syllabus::Union{Bool,Nothing}
    public_syllabus_to_auth::Union{Bool,Nothing}
    # optional: the public description of the course
    public_description::Union{String,Nothing}
    storage_quota_mb::Union{Int,Nothing}
    storage_quota_used_mb::Union{Float64,Nothing}
    hide_final_grades::Union{Bool,Nothing}
    license::Union{String,Nothing}
    allow_student_assignment_edits::Union{Bool,Nothing}
    allow_wiki_comments::Union{Bool,Nothing}
    allow_student_forum_attachments::Union{Bool,Nothing}
    open_enrollment::Union{Bool,Nothing}
    self_enrollment::Union{Bool,Nothing}
    restrict_enrollments_to_course_dates::Union{Bool,Nothing}
    course_format::Union{String,Nothing}
    # optional: this will be true if this user is currently prevented from viewing the
    # course because of date restriction settings
    access_restricted_by_date::Union{Bool,Nothing}
    # The course's IANA time zone name.
    time_zone::Union{String,Nothing}
    # optional: whether the course is set as a Blueprint Course (blueprint fields require
    # the Blueprint Courses feature)
    blueprint::Union{Bool,Nothing}
    # optional: Set of restrictions applied to all locked course objects
    blueprint_restrictions::Union{Dict,Nothing}
    # optional: Sets of restrictions differentiated by object type applied to locked course
    # objects
    blueprint_restrictions_by_object_type::Union{Dict,Nothing}
end
Course(data::Dict) = json2canvas(Course, data)

# Group
struct Group <: CanvasObject
    # The ID of the group.
    id::Union{Int,Nothing}
    # The display name of the group.
    name::Union{String,Nothing}
    # A description of the group. This is plain text.
    description::Union{String,Nothing}
    # Whether or not the group is public. Currently only community groups can be made public.
    # Also, once a group has been set to public, it cannot be changed back to private.
    is_public::Union{Bool,Nothing}
    # Whether or not the current user is following this group.
    followed_by_user::Union{Bool,Nothing}
    # How people are allowed to join the group. For all groups except for community groups,
    # the user must share the group's parent course or account. For student organized or
    # community groups, where a user can be a member of as many or few as they want, the
    # applicable levels are 'parent_context_auto_join', 'parent_context_request', and 'invitation_only'.
    # For class groups, where students are divided up and should only be part of one group
    # of the category, this value will always be 'invitation_only', and is not relevant.
    # * If 'parent_context_auto_join', anyone can join and will be automatically accepted.
    # * If 'parent_context_request', anyone can request to join, which must be approved
    # by a group moderator. * If 'invitation_only', only those how have received an invitation
    # my join the group, by accepting that invitation.
    join_level::Union{String,Nothing}
    # The number of members currently in the group
    members_count::Union{Int,Nothing}
    # The url of the group's avatar
    avatar_url::Union{String,Nothing}
    # The course or account that the group belongs to. The pattern here is that whatever
    # the context_type is, there will be an _id field named after that type. So if instead
    # context_type was 'account', the course_id field would be replaced by an account_id
    # field.
    context_type::Union{String,Nothing}
    course_id::Union{Int,Nothing}
    # Certain types of groups have special role designations. Currently, these include:
    # 'communities', 'student_organized', and 'imported'. Regular course/account groups
    # have a role of null.
    role::Union{String,Nothing}
    # The ID of the group's category.
    group_category_id::Union{Int,Nothing}
    # The SIS ID of the group. Only included if the user has permission to view SIS information.
    sis_group_id::Union{String,Nothing}
    # The id of the SIS import if created through SIS. Only included if the user has permission
    # to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # the storage quota for the group, in megabytes
    storage_quota_mb::Union{Int,Nothing}
    # optional: the permissions the user has for the group. returned only for a single
    # group and include[]=permissions
    permissions::Union{Dict,Nothing}
end
Group(data::Dict) = json2canvas(Group, data)

# LockInfo
struct LockInfo <: CanvasObject
    # Asset string for the object causing the lock
    asset_string::Union{String,Nothing}
    # (Optional) Time at which this was/will be unlocked. Must be before the due date.
    unlock_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be locked. Must be after the due date.
    lock_at::Union{Dates.DateTime,Nothing}
    # (Optional) Context module causing the lock.
    context_module::Union{String,Nothing}
    manually_locked::Union{Bool,Nothing}
end
LockInfo(data::Dict) = json2canvas(LockInfo, data)

# File
struct File <: CanvasObject
    id::Union{Int,Nothing}
    uuid::Union{String,Nothing}
    folder_id::Union{Int,Nothing}
    display_name::Union{String,Nothing}
    filename::Union{String,Nothing}
    content_type::Union{String,Nothing}
    url::Union{String,Nothing}
    # file size in bytes
    size::Union{Int,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    updated_at::Union{Dates.DateTime,Nothing}
    unlock_at::Union{Dates.DateTime,Nothing}
    locked::Union{Bool,Nothing}
    hidden::Union{Bool,Nothing}
    lock_at::Union{Dates.DateTime,Nothing}
    hidden_for_user::Union{Bool,Nothing}
    thumbnail_url::Union{String,Nothing}
    modified_at::Union{Dates.DateTime,Nothing}
    # simplified content-type mapping
    mime_class::Union{String,Nothing}
    # identifier for file in third-party transcoding service
    media_entry_id::Union{String,Nothing}
    locked_for_user::Union{Bool,Nothing}
    lock_info::Union{LockInfo,Nothing}
    lock_explanation::Union{String,Nothing}
    # optional: url to the document preview. This url is specific to the user making the
    # api call. Only included in submission endpoints.
    preview_url::Union{String,Nothing}
    # The following fields are specific to file upload
    location::Union{String,Nothing}
    instfs_uuid::Union{String,Nothing}
    upload_status::Union{String,Nothing}
end
File(data::Dict) = json2canvas(File, data)

# Folder
struct Folder <: CanvasObject
    context_type::Union{String,Nothing}
    context_id::Union{Int,Nothing}
    files_count::Union{Int,Nothing}
    position::Union{Int,Nothing}
    updated_at::Union{Dates.DateTime,Nothing}
    folders_url::Union{String,Nothing}
    files_url::Union{String,Nothing}
    full_name::Union{String,Nothing}
    lock_at::Union{Dates.DateTime,Nothing}
    id::Union{Int,Nothing}
    folders_count::Union{Int,Nothing}
    name::Union{String,Nothing}
    parent_folder_id::Union{Int,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    unlock_at::Union{Dates.DateTime,Nothing}
    hidden::Union{Bool,Nothing}
    hidden_for_user::Union{Bool,Nothing}
    locked::Union{Bool,Nothing}
    locked_for_user::Union{Bool,Nothing}
    # If true, indicates this is a read-only folder containing files submitted to assignments
    for_submissions::Union{Bool,Nothing}
end
Folder(data::Dict) = json2canvas(Folder, data)

# TurnitinSettings
struct TurnitinSettings <: CanvasObject
    originality_report_visibility::Union{String,Nothing}
    s_paper_check::Union{Bool,Nothing}
    internet_check::Union{Bool,Nothing}
    journal_check::Union{Bool,Nothing}
    exclude_biblio::Union{Bool,Nothing}
    exclude_quoted::Union{Bool,Nothing}
    exclude_small_matches_type::Union{String,Nothing}
    exclude_small_matches_value::Union{Int,Nothing}
end
TurnitinSettings(data::Dict) = json2canvas(TurnitinSettings, data)

# ExternalToolTagAttributes
struct ExternalToolTagAttributes <: CanvasObject
    # URL to the external tool
    url::Union{String,Nothing}
    # Whether or not there is a new tab for the external tool
    new_tab::Union{Bool,Nothing}
    # the identifier for this tool_tag
    resource_link_id::Union{String,Nothing}
end
ExternalToolTagAttributes(data::Dict) = json2canvas(ExternalToolTagAttributes, data)


# DiscussionTopic
struct DiscussionTopic <: CanvasObject
    # The ID of this topic.
    id::Union{Int,Nothing}
    # The topic title.
    title::Union{String,Nothing}
    # The HTML content of the message body.
    message::Union{String,Nothing}
    # The URL to the discussion topic in canvas.
    html_url::Union{String,Nothing}
    # The datetime the topic was posted. If it is null it hasn't been posted yet. (see
    # delayed_post_at)
    posted_at::Union{Dates.DateTime,Nothing}
    # The datetime for when the last reply was in the topic.
    last_reply_at::Union{Dates.DateTime,Nothing}
    # If true then a user may not respond to other replies until that user has made an
    # initial reply. Defaults to false.
    require_initial_post::Union{Bool,Nothing}
    # Whether or not posts in this topic are visible to the user.
    user_can_see_posts::Union{Bool,Nothing}
    # The count of entries in the topic.
    discussion_subentry_count::Union{Int,Nothing}
    # The read_state of the topic for the current user, 'read' or 'unread'.
    read_state::Union{String,Nothing}
    # The count of unread entries of this topic for the current user.
    unread_count::Union{Int,Nothing}
    # Whether or not the current user is subscribed to this topic.
    subscribed::Union{Bool,Nothing}
    # (Optional) Why the user cannot subscribe to this topic. Only one reason will be returned
    # even if multiple apply. Can be one of: 'initial_post_required': The user must post
    # a reply first; 'not_in_group_set': The user is not in the group set for this graded
    # group discussion; 'not_in_group': The user is not in this topic's group; 'topic_is_announcement':
    # This topic is an announcement
    subscription_hold::Union{String,Nothing}
    # The unique identifier of the assignment if the topic is for grading, otherwise null.
    assignment_id::Union{Int,Nothing}
    # The datetime to publish the topic (if not right away).
    delayed_post_at::Union{Dates.DateTime,Nothing}
    # Whether this discussion topic is published (true) or draft state (false)
    published::Union{Bool,Nothing}
    # The datetime to lock the topic (if ever).
    lock_at::Union{Dates.DateTime,Nothing}
    # Whether or not the discussion is 'closed for comments'.
    locked::Union{Bool,Nothing}
    # Whether or not the discussion has been 'pinned' by an instructor
    pinned::Union{Bool,Nothing}
    # Whether or not this is locked for the user.
    locked_for_user::Union{Bool,Nothing}
    # (Optional) Information for the user about the lock. Present when locked_for_user
    # is true.
    lock_info::Union{LockInfo,Nothing}
    # (Optional) An explanation of why this is locked for the user. Present when locked_for_user
    # is true.
    lock_explanation::Union{String,Nothing}
    # The username of the topic creator.
    user_name::Union{String,Nothing}
    # DEPRECATED An array of topic_ids for the group discussions the user is a part of.
    topic_children::Union{Vector,Nothing}
    # An array of group discussions the user is a part of. Fields include: id, group_id
    group_topic_children::Union{Vector,Nothing}
    # If the topic is for grading and a group assignment this will point to the original
    # topic in the course.
    root_topic_id::Union{Int,Nothing}
    # If the topic is a podcast topic this is the feed url for the current user.
    podcast_url::Union{String,Nothing}
    # The type of discussion. Values are 'side_comment', for discussions that only allow
    # one level of nested comments, and 'threaded' for fully threaded discussions.
    discussion_type::Union{String,Nothing}
    # The unique identifier of the group category if the topic is a group discussion, otherwise
    # null.
    group_category_id::Union{Int,Nothing}
    # Array of file attachments.
    attachments::Union{Vector,Nothing}
    # The current user's permissions on this topic.
    permissions::Union{Dict,Nothing}
    # Whether or not users can rate entries in this topic.
    allow_rating::Union{Bool,Nothing}
    # Whether or not grade permissions are required to rate entries.
    only_graders_can_rate::Union{Bool,Nothing}
    # Whether or not entries should be sorted by rating.
    sort_by_rating::Union{Bool,Nothing}
end
DiscussionTopic(data::Dict) = json2canvas(DiscussionTopic, data)

# Submission
struct Submission <: CanvasObject
    # The submission's assignment id
    assignment_id::Union{Int,Nothing}
    # The submission's assignment (see the assignments API) (optional)
    assignment::Union{Any,Nothing}
    # The submission's course (see the course API) (optional)
    course::Union{Course,Nothing}
    # This is the submission attempt number.
    attempt::Union{Int,Nothing}
    # The content of the submission, if it was submitted directly in a text field.
    body::Union{String,Nothing}
    # The grade for the submission, translated into the assignment grading scheme (so a
    # letter grade, for example).
    grade::Union{String,Nothing}
    # A boolean flag which is false if the student has re-submitted since the submission
    # was last graded.
    grade_matches_current_submission::Union{Bool,Nothing}
    # URL to the submission. This will require the user to log in.
    html_url::Union{String,Nothing}
    # URL to the submission preview. This will require the user to log in.
    preview_url::Union{String,Nothing}
    # The raw score
    score::Union{Float64,Nothing}
    # Associated comments for a submission (optional)
    submission_comments::Union{Vector,Nothing}
    # The types of submission ex: ('online_text_entry'|'online_url'|'online_upload'|'media_recording')
    submission_type::Union{String,Nothing}
    # The timestamp when the assignment was submitted
    submitted_at::Union{Dates.DateTime,Nothing}
    # The URL of the submission (for 'online_url' submissions).
    url::Union{String,Nothing}
    # The id of the user who created the submission
    user_id::Union{Int,Nothing}
    # The id of the user who graded the submission. This will be null for submissions that
    # haven't been graded yet. It will be a positive number if a real user has graded the
    # submission and a negative number if the submission was graded by a process (e.g.
    # Quiz autograder and autograding LTI tools). Specifically autograded quizzes set grader_id
    # to the negative of the quiz id. Submissions autograded by LTI tools set grader_id
    # to the negative of the tool id.
    grader_id::Union{Int,Nothing}
    graded_at::Union{Dates.DateTime,Nothing}
    # The submissions user (see user API) (optional)
    user::Union{User,Nothing}
    # Whether the submission was made after the applicable due date
    late::Union{Bool,Nothing}
    # Whether the assignment is visible to the user who submitted the assignment. Submissions
    # where `assignment_visible` is false no longer count towards the student's grade and
    # the assignment can no longer be accessed by the student. `assignment_visible` becomes
    # false for submissions that do not have a grade and whose assignment is no longer
    # assigned to the student's section.
    assignment_visible::Union{Bool,Nothing}
    # Whether the assignment is excused. Excused assignments have no impact on a user's
    # grade.
    excused::Union{Bool,Nothing}
    # Whether the assignment is missing.
    missing::Union{Bool,Nothing}
    # The status of the submission in relation to the late policy. Can be late, missing,
    # none, or null.
    late_policy_status::Union{String,Nothing}
    # The amount of points automatically deducted from the score by the missing/late policy
    # for a late or missing assignment.
    points_deducted::Union{Float64,Nothing}
    # The amount of time, in seconds, that an submission is late by.
    seconds_late::Union{Int64,Nothing} # TODO: Report this??
    # The current state of the submission
    workflow_state::Union{String,Nothing}
    # Extra submission attempts allowed for the given user and assignment.
    extra_attempts::Union{Float64,Nothing}
    # A unique short ID identifying this submission without reference to the owning user.
    # Only included if the caller has administrator access for the current account.
    anonymous_id::Union{String,Nothing}
    # The date this submission was posted to the student, or nil if it has not been posted.
    posted_at::Union{Dates.DateTime,Nothing}
    ########################
    ## Fields added by me ##
    ########################
    # attachments::Union{Vector,Nothing} # TODO: Can this be other than File?? Or Vector{File} ??
    attachments::Union{Vector{File},Nothing} # TODO: Can this be other than File?? Or Vector{File} ??
end
Submission(data::Dict) = json2canvas(Submission, data)


# Assignment
struct Assignment <: CanvasObject
    # the ID of the assignment
    id::Union{Int,Nothing}
    # the name of the assignment
    name::Union{String,Nothing}
    # the assignment description, in an HTML fragment
    description::Union{String,Nothing}
    # The time at which this assignment was originally created
    created_at::Union{Dates.DateTime,Nothing}
    # The time at which this assignment was last modified in any way
    updated_at::Union{Dates.DateTime,Nothing}
    # the due date for the assignment. returns null if not present. NOTE: If this assignment
    # has assignment overrides, this field will be the due date as it applies to the user
    # requesting information from the API.
    due_at::Union{Dates.DateTime,Nothing}
    # the lock date (assignment is locked after this date). returns null if not present.
    # NOTE: If this assignment has assignment overrides, this field will be the lock date
    # as it applies to the user requesting information from the API.
    lock_at::Union{Dates.DateTime,Nothing}
    # the unlock date (assignment is unlocked after this date) returns null if not present
    # NOTE: If this assignment has assignment overrides, this field will be the unlock
    # date as it applies to the user requesting information from the API.
    unlock_at::Union{Dates.DateTime,Nothing}
    # whether this assignment has overrides
    has_overrides::Union{Bool,Nothing}
    # (Optional) all dates associated with the assignment, if applicable
    all_dates::Union{Vector,Nothing}
    # the ID of the course the assignment belongs to
    course_id::Union{Int,Nothing}
    # the URL to the assignment's web page
    html_url::Union{String,Nothing}
    # the URL to download all submissions as a zip
    submissions_download_url::Union{String,Nothing}
    # the ID of the assignment's group
    assignment_group_id::Union{Int,Nothing}
    # Boolean flag indicating whether the assignment requires a due date based on the account
    # level setting
    due_date_required::Union{Bool,Nothing}
    # Allowed file extensions, which take effect if submission_types includes 'online_upload'.
    allowed_extensions::Union{Vector,Nothing}
    # An integer indicating the maximum length an assignment's name may be
    max_name_length::Union{Int,Nothing}
    # Boolean flag indicating whether or not Turnitin has been enabled for the assignment.
    # NOTE: This flag will not appear unless your account has the Turnitin plugin available
    turnitin_enabled::Union{Bool,Nothing}
    # Boolean flag indicating whether or not VeriCite has been enabled for the assignment.
    # NOTE: This flag will not appear unless your account has the VeriCite plugin available
    vericite_enabled::Union{Bool,Nothing}
    # Settings to pass along to turnitin to control what kinds of matches should be considered.
    # originality_report_visibility can be 'immediate', 'after_grading', 'after_due_date',
    # or 'never' exclude_small_matches_type can be null, 'percent', 'words' exclude_small_matches_value:
    # - if type is null, this will be null also - if type is 'percent', this will be a
    # number between 0 and 100 representing match size to exclude as a percentage of the
    # document size. - if type is 'words', this will be number > 0 representing how many
    # words a match must contain for it to be considered NOTE: This flag will not appear
    # unless your account has the Turnitin plugin available
    turnitin_settings::Union{TurnitinSettings,Nothing}
    # If this is a group assignment, boolean flag indicating whether or not students will
    # be graded individually.
    grade_group_students_individually::Union{Bool,Nothing}
    # (Optional) assignment's settings for external tools if submission_types include 'external_tool'.
    # Only url and new_tab are included (new_tab defaults to false). Use the 'External
    # Tools' API if you need more information about an external tool.
    external_tool_tag_attributes::Union{ExternalToolTagAttributes,Nothing}
    # Boolean indicating if peer reviews are required for this assignment
    peer_reviews::Union{Bool,Nothing}
    # Boolean indicating peer reviews are assigned automatically. If false, the teacher
    # is expected to manually assign peer reviews.
    automatic_peer_reviews::Union{Bool,Nothing}
    # Integer representing the amount of reviews each user is assigned. NOTE: This key
    # is NOT present unless you have automatic_peer_reviews set to true.
    peer_review_count::Union{Int,Nothing}
    # String representing a date the reviews are due by. Must be a date that occurs after
    # the default due date. If blank, or date is not after the assignment's due date, the
    # assignment's due date will be used. NOTE: This key is NOT present unless you have
    # automatic_peer_reviews set to true.
    peer_reviews_assign_at::Union{Dates.DateTime,Nothing}
    # Boolean representing whether or not members from within the same group on a group
    # assignment can be assigned to peer review their own group's work
    intra_group_peer_reviews::Union{Bool,Nothing}
    # The ID of the assignment’s group set, if this is a group assignment. For group discussions,
    # set group_category_id on the discussion topic, not the linked assignment.
    group_category_id::Union{Int,Nothing}
    # if the requesting user has grading rights, the number of submissions that need grading.
    needs_grading_count::Union{Int,Nothing}
    # if the requesting user has grading rights and the 'needs_grading_count_by_section'
    # flag is specified, the number of submissions that need grading split out by section.
    # NOTE: This key is NOT present unless you pass the 'needs_grading_count_by_section'
    # argument as true. ANOTHER NOTE: it's possible to be enrolled in multiple sections,
    # and if a student is setup that way they will show an assignment that needs grading
    # in multiple sections (effectively the count will be duplicated between sections)
    needs_grading_count_by_section::Union{Vector,Nothing}
    # the sorting order of the assignment in the group
    position::Union{Int,Nothing}
    # (optional, present if Sync Grades to SIS feature is enabled)
    post_to_sis::Union{Bool,Nothing}
    # (optional, Third Party unique identifier for Assignment)
    integration_id::Union{String,Nothing}
    # (optional, Third Party integration data for assignment)
    integration_data::Union{Any,Nothing} # TODO: Report bug to Canvas
    # For courses using Old Gradebook, indicates whether the assignment is muted. For courses
    # using New Gradebook, true if the assignment has any unposted submissions, otherwise
    # false. To see the posted status of submissions, check the 'posted_attribute' on Submission.
    muted::Union{Bool,Nothing}
    # the maximum points possible for the assignment
    points_possible::Union{Number,Nothing} # TODO: Report this ???
    # the types of submissions allowed for this assignment list containing one or more
    # of the following: 'discussion_topic', 'online_quiz', 'on_paper', 'none', 'external_tool',
    # 'online_text_entry', 'online_url', 'online_upload' 'media_recording'
    submission_types::Union{Vector,Nothing}
    # If true, the assignment has been submitted to by at least one student
    has_submitted_submissions::Union{Bool,Nothing}
    # The type of grading the assignment receives; one of 'pass_fail', 'percent', 'letter_grade',
    # 'gpa_scale', 'points'
    grading_type::Union{String,Nothing}
    # The id of the grading standard being applied to this assignment. Valid if grading_type
    # is 'letter_grade' or 'gpa_scale'.
    grading_standard_id::Union{Int,Nothing}
    # Whether the assignment is published
    published::Union{Bool,Nothing}
    # Whether the assignment's 'published' state can be changed to false. Will be false
    # if there are student submissions for the assignment.
    unpublishable::Union{Bool,Nothing}
    # Whether the assignment is only visible to overrides.
    only_visible_to_overrides::Union{Bool,Nothing}
    # Whether or not this is locked for the user.
    locked_for_user::Union{Bool,Nothing}
    # (Optional) Information for the user about the lock. Present when locked_for_user
    # is true.
    lock_info::Union{LockInfo,Nothing}
    # (Optional) An explanation of why this is locked for the user. Present when locked_for_user
    # is true.
    lock_explanation::Union{String,Nothing}
    # (Optional) id of the associated quiz (applies only when submission_types is ['online_quiz'])
    quiz_id::Union{Int,Nothing}
    # (Optional) whether anonymous submissions are accepted (applies only to quiz assignments)
    anonymous_submissions::Union{Bool,Nothing}
    # (Optional) the DiscussionTopic associated with the assignment, if applicable
    discussion_topic::Union{DiscussionTopic,Nothing}
    # (Optional) Boolean indicating if assignment will be frozen when it is copied. NOTE:
    # This field will only be present if the AssignmentFreezer plugin is available for
    # your account.
    freeze_on_copy::Union{Bool,Nothing}
    # (Optional) Boolean indicating if assignment is frozen for the calling user. NOTE:
    # This field will only be present if the AssignmentFreezer plugin is available for
    # your account.
    frozen::Union{Bool,Nothing}
    # (Optional) Array of frozen attributes for the assignment. Only account administrators
    # currently have permission to change an attribute in this list. Will be empty if no
    # attributes are frozen for this assignment. Possible frozen attributes are: title,
    # description, lock_at, points_possible, grading_type, submission_types, assignment_group_id,
    # allowed_extensions, group_category_id, notify_of_update, peer_reviews NOTE: This
    # field will only be present if the AssignmentFreezer plugin is available for your
    # account.
    frozen_attributes::Union{Vector,Nothing}
    # (Optional) If 'submission' is included in the 'include' parameter, includes a Submission
    # object that represents the current user's (user who is requesting information from
    # the api) current submission for the assignment. See the Submissions API for an example
    # response. If the user does not have a submission, this key will be absent.
    submission::Union{Submission,Nothing}
    # (Optional) If true, the rubric is directly tied to grading the assignment. Otherwise,
    # it is only advisory. Included if there is an associated rubric.
    use_rubric_for_grading::Union{Bool,Nothing}
    # (Optional) An object describing the basic attributes of the rubric, including the
    # point total. Included if there is an associated rubric.
    rubric_settings::Union{String,Nothing}
    # (Optional) A list of scoring criteria and ratings for each rubric criterion. Included
    # if there is an associated rubric.
    rubric::Union{Vector,Nothing}
    # (Optional) If 'assignment_visibility' is included in the 'include' parameter, includes
    # an array of student IDs who can see this assignment.
    assignment_visibility::Union{Vector,Nothing}
    # (Optional) If 'overrides' is included in the 'include' parameter, includes an array
    # of assignment override objects.
    overrides::Union{Vector,Nothing}
    # (Optional) If true, the assignment will be omitted from the student's final grade
    omit_from_final_grade::Union{Bool,Nothing}
    # Boolean indicating if the assignment is moderated.
    moderated_grading::Union{Bool,Nothing}
    # The maximum number of provisional graders who may issue grades for this assignment.
    # Only relevant for moderated assignments. Must be a positive value, and must be set
    # to 1 if the course has fewer than two active instructors. Otherwise, the maximum
    # value is the number of active instructors in the course minus one, or 10 if the course
    # has more than 11 active instructors.
    grader_count::Union{Int,Nothing}
    # The user ID of the grader responsible for choosing final grades for this assignment.
    # Only relevant for moderated assignments.
    final_grader_id::Union{Int,Nothing}
    # Boolean indicating if provisional graders' comments are visible to other provisional
    # graders. Only relevant for moderated assignments.
    grader_comments_visible_to_graders::Union{Bool,Nothing}
    # Boolean indicating if provisional graders' identities are hidden from other provisional
    # graders. Only relevant for moderated assignments with grader_comments_visible_to_graders
    # set to true.
    graders_anonymous_to_graders::Union{Bool,Nothing}
    # Boolean indicating if provisional grader identities are visible to the final grader.
    # Only relevant for moderated assignments.
    grader_names_visible_to_final_grader::Union{Bool,Nothing}
    # Boolean indicating if the assignment is graded anonymously. If true, graders cannot
    # see student identities.
    anonymous_grading::Union{Bool,Nothing}
    # The number of submission attempts a student can make for this assignment. -1 is considered
    # unlimited.
    allowed_attempts::Union{Int,Nothing}
    # Whether the assignment has manual posting enabled. Only relevant for courses using
    # New Gradebook.
    post_manually::Union{Bool,Nothing}
end
Assignment(data::Dict) = json2canvas(Assignment, data)

# GradingRules
struct GradingRules <: CanvasObject
    # Number of lowest scores to be dropped for each user.
    drop_lowest::Union{Int,Nothing}
    # Number of highest scores to be dropped for each user.
    drop_highest::Union{Int,Nothing}
    # Assignment IDs that should never be dropped.
    never_drop::Union{Vector,Nothing}
end
GradingRules(data::Dict) = json2canvas(GradingRules, data)


# AssignmentGroup
struct AssignmentGroup <: CanvasObject
    # the id of the Assignment Group
    id::Union{Int,Nothing}
    # the name of the Assignment Group
    name::Union{String,Nothing}
    # the position of the Assignment Group
    position::Union{Int,Nothing}
    # the weight of the Assignment Group
    group_weight::Union{Int,Nothing}
    # the sis source id of the Assignment Group
    sis_source_id::Union{String,Nothing}
    # the integration data of the Assignment Group
    integration_data::Union{Dict,Nothing}
    # the assignments in this Assignment Group (see the Assignment API for a detailed list
    # of fields)
    assignments::Union{Vector,Nothing}
    # the grading rules that this Assignment Group has
    rules::Union{GradingRules,Nothing}
end
AssignmentGroup(data::Dict) = json2canvas(AssignmentGroup, data)


# AssignmentOverride
struct AssignmentOverride <: CanvasObject
    # the ID of the assignment override
    id::Union{Int,Nothing}
    # the ID of the assignment the override applies to
    assignment_id::Union{Int,Nothing}
    # the IDs of the override's target students (present if the override targets an ad-hoc
    # set of students)
    student_ids::Union{Vector,Nothing}
    # the ID of the override's target group (present if the override targets a group and
    # the assignment is a group assignment)
    group_id::Union{Int,Nothing}
    # the ID of the overrides's target section (present if the override targets a section)
    course_section_id::Union{Int,Nothing}
    # the title of the override
    title::Union{String,Nothing}
    # the overridden due at (present if due_at is overridden)
    due_at::Union{Dates.DateTime,Nothing}
    # the overridden all day flag (present if due_at is overridden)
    all_day::Union{Bool,Nothing} # TODO: report canvas bug
    # the overridden all day date (present if due_at is overridden)
    all_day_date::Union{Dates.DateTime,Nothing}
    # the overridden unlock at (present if unlock_at is overridden)
    unlock_at::Union{Dates.DateTime,Nothing}
    # the overridden lock at, if any (present if lock_at is overridden)
    lock_at::Union{Dates.DateTime,Nothing}
end
AssignmentOverride(data::Dict) = json2canvas(AssignmentOverride, data)

# Section
struct Section <: CanvasObject
    # The unique identifier for the section.
    id::Union{Int,Nothing}
    # The name of the section.
    name::Union{String,Nothing}
    # The sis id of the section. This field is only included if the user has permission
    # to view SIS information.
    sis_section_id::Union{String,Nothing}
    # Optional: The integration ID of the section. This field is only included if the user
    # has permission to view SIS information.
    integration_id::Union{String,Nothing}
    # The unique identifier for the SIS import if created through SIS. This field is only
    # included if the user has permission to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # The unique Canvas identifier for the course in which the section belongs
    course_id::Union{Int,Nothing}
    # The unique SIS identifier for the course in which the section belongs. This field
    # is only included if the user has permission to view SIS information.
    sis_course_id::Union{String,Nothing}
    # the start date for the section, if applicable
    start_at::Union{Dates.DateTime,Nothing}
    # the end date for the section, if applicable
    end_at::Union{Dates.DateTime,Nothing}
    # Restrict user enrollments to the start and end dates of the section
    restrict_enrollments_to_section_dates::Union{Bool,Nothing}
    # The unique identifier of the original course of a cross-listed section
    nonxlist_course_id::Union{Int,Nothing}
    # optional: the total number of active and invited students in the section
    total_students::Union{Int,Nothing}
end
Section(data::Dict) = json2canvas(Section, data)


# Account
struct Account <: CanvasObject
    # the ID of the Account object
    id::Union{Int,Nothing}
    # The display name of the account
    name::Union{String,Nothing}
    # The UUID of the account
    uuid::Union{String,Nothing}
    # The account's parent ID, or null if this is the root account
    parent_account_id::Union{Int,Nothing}
    # The ID of the root account, or null if this is the root account
    root_account_id::Union{Int,Nothing}
    # The storage quota for the account in megabytes, if not otherwise specified
    default_storage_quota_mb::Union{Int,Nothing}
    # The storage quota for a user in the account in megabytes, if not otherwise specified
    default_user_storage_quota_mb::Union{Int,Nothing}
    # The storage quota for a group in the account in megabytes, if not otherwise specified
    default_group_storage_quota_mb::Union{Int,Nothing}
    # The default time zone of the account. Allowed time zones are {http://www.iana.org/time-zones
    # IANA time zones} or friendlier {http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
    # Ruby on Rails time zones}.
    default_time_zone::Union{String,Nothing}
    # The account's identifier in the Student Information System. Only included if the
    # user has permission to view SIS information.
    sis_account_id::Union{String,Nothing}
    # The account's identifier in the Student Information System. Only included if the
    # user has permission to view SIS information.
    integration_id::Union{String,Nothing}
    # The id of the SIS import if created through SIS. Only included if the user has permission
    # to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # The account's identifier that is sent as context_id in LTI launches.
    lti_guid::Union{String,Nothing}
    # The state of the account. Can be 'active' or 'deleted'.
    workflow_state::Union{String,Nothing}
end
Account(data::Dict) = json2canvas(Account, data)
