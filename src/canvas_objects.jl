##################
# Canvas Objects #
##################
abstract type CanvasObject end

id(x) = x
id(x::CanvasObject) = x.id
namefield(x) = nothing

function Base.show(io::IO, o::CanvasObject)
    if get(io, :compact, false)
        uri_id = namefield(o)
        if uri_id === nothing
            print(io, typeof(o), "(…)")
        else
            print(io, typeof(o), "($(repr(uri_id)))")
        end
    else
        print(io, "$(typeof(o)) (all fields are Union{T,Nothing}):")
        for field in fieldnames(typeof(o))
            val = getfield(o, field)
            if !(val === nothing)
                println(io)
                print(io, "  $field: ")
                if isa(val, Vector)
                    print(io, typeof(val))
                else
                    show(IOContext(io, :compact => true), val)
                end
            end
        end
    end
end

############
## Course ##
############
struct Course <: CanvasObject
    id::Union{Int,Nothing}
    sis_course_id::Union{String,Nothing}
    uuid::Union{String,Nothing}
    integration_id::Union{String,Nothing}
    sis_import_id::Union{Int,Nothing}
    name::Union{String,Nothing}
    course_code::Union{String,Nothing}
    workflow_state::Union{String,Nothing}
    account_id::Union{Int,Nothing}
    root_account_id::Union{Int,Nothing}
    enrollment_term_id::Union{Int,Nothing}
    grading_standard_id::Union{Int,Nothing}
    grade_passback_setting::Union{String,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    start_at::Union{Dates.DateTime,Nothing}
    end_at::Union{Dates.DateTime,Nothing}
    locale::Union{String,Nothing}
    enrollments::Union{Vector{Dict},Nothing}
    total_students::Union{Int,Nothing}
    calendar::Union{Vector{Dict},Nothing}
    default_view::Union{String,Nothing}
    syllabus_body::Union{String,Nothing}
    needs_grading_count::Union{Int,Nothing}
    term::Union{Dict,Nothing}
    course_progress::Union{Dict,Nothing}
    apply_assignment_group_weights::Union{Bool,Nothing}
    permissions::Union{Dict,Nothing}
    is_public::Union{Bool,Nothing}
    is_public_to_auth_users::Union{Bool,Nothing}
    public_syllabus::Union{Bool,Nothing}
    public_syllabus_to_auth::Union{Bool,Nothing}
    public_description::Union{String,Nothing}
    storage_quota_mb::Union{Int,Nothing}
    storage_quota_used_mb::Union{Int,Nothing}
    hide_final_grades::Union{Bool,Nothing}
    license::Union{String,Nothing}
    allow_student_assignment_edits::Union{Bool,Nothing}
    allow_wiki_comments::Union{Bool,Nothing}
    allow_student_forum_attachments::Union{Bool,Nothing}
    open_enrollment::Union{Bool,Nothing}
    self_enrollment::Union{Bool,Nothing}
    restrict_enrollments_to_course_dates::Union{Bool,Nothing}
    course_format::Union{String,Nothing}
    access_restricted_by_date::Union{Bool,Nothing}
    time_zone::Union{String,Nothing}
    blueprint::Union{Bool,Nothing}
    blueprint_restrictions::Union{Dict,Nothing}
    blueprint_restrictions_by_object_type::Union{Dict,Nothing}
end
Course(data::Dict) = json2canvas(Course, data)
Course(id::Int) = Course(Dict("id" => id))

##########
## File ##
##########
# TODO: This includes much more but not documented...
struct File <: CanvasObject
    size::Union{Int,Nothing}
    content_type::Union{String,Nothing}
    url::Union{String,Nothing}
    id::Union{Int,Nothing}
    display_name::Union{String,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    updated_at::Union{Dates.DateTime,Nothing}
end
File(data::Dict) = json2canvas(File, data)
File(id::Int) = File(Dict("id" => id))

## Submission
## https://canvas.instructure.com/doc/api/submissions.html#Submission
struct Submission <: CanvasObject
  # The submission's assignment id
  assignment_id::Union{Int,Nothing}
  # The submission's assignment (see the assignments API) (optional)
  assignment::Union{String,Nothing}
  # The submission's course (see the course API) (optional)
  course::Union{String,Nothing}
  # This is the submission attempt number.
  attempt::Union{Int,Nothing}
  # The content of the submission, if it was submitted directly in a text field.
  body::Union{String,Nothing}
  # The grade for the submission, translated into the assignment grading scheme
  # (so a letter grade, for example).
  grade::Union{String,Nothing}
  # A boolean flag which is false if the student has re-submitted since the
  # submission was last graded.
  grade_matches_current_submission::Union{Bool,Nothing}
  # URL to the submission. This will require the user to log in.
  html_url::Union{String,Nothing}
  # URL to the submission preview. This will require the user to log in.
  preview_url::Union{String,Nothing}
  # The raw score
  score::Union{Float64,Nothing}
  # Associated comments for a submission (optional)
  submission_comments::Union{Vector{Dict},Nothing}
  # The types of submission ex:
  # ('online_text_entry'|'online_url'|'online_upload'|'media_recording')
  submission_type::Union{String,Nothing}
  # The timestamp when the assignment was submitted
  submitted_at::Union{Dates.DateTime,Nothing}
  # The URL of the submission (for 'online_url' submissions).
  url::Union{String,Nothing}
  # The id of the user who created the submission
  user_id::Union{Int,Nothing}
  # The id of the user who graded the submission. This will be null for
  # submissions that haven't been graded yet. It will be a positive number if a
  # real user has graded the submission and a negative number if the submission
  # was graded by a process (e.g. Quiz autograder and autograding LTI tools).
  # Specifically autograded quizzes set grader_id to the negative of the quiz id.
  # Submissions autograded by LTI tools set grader_id to the negative of the tool
  # id.
  grader_id::Union{Int,Nothing}
  graded_at::Union{Dates.DateTime,Nothing}
  # The submissions user (see user API) (optional)
  user::Union{String,Nothing}
  # Whether the submission was made after the applicable due date
  late::Union{Bool,Nothing}
  # Whether the assignment is visible to the user who submitted the assignment.
  # Submissions where `assignment_visible` is false no longer count towards the
  # student's grade and the assignment can no longer be accessed by the student.
  # `assignment_visible` becomes false for submissions that do not have a grade
  # and whose assignment is no longer assigned to the student's section.
  assignment_visible::Union{Bool,Nothing}
  # Whether the assignment is excused.  Excused assignments have no impact on a
  # user's grade.
  excused::Union{Bool,Nothing}
  # Whether the assignment is missing.
  missing::Union{Bool,Nothing}
  # The status of the submission in relation to the late policy. Can be late,
  # missing, none, or null.
  late_policy_status::Union{String,Nothing}
  # The amount of points automatically deducted from the score by the
  # missing/late policy for a late or missing assignment.
  points_deducted::Union{Float64,Nothing}
  # The amount of time, in seconds, that an submission is late by.
  seconds_late::Union{Int,Nothing}
  # The current state of the submission
  workflow_state::Union{String,Nothing}
  # Extra submission attempts allowed for the given user and assignment.
  extra_attempts::Union{Int,Nothing}
  # A unique short ID identifying this submission without reference to the owning
  # user. Only included if the caller has administrator access for the current
  # account.
  anonymous_id::Union{String,Nothing}
  # The date this submission was posted to the student, or nil if it has not been
  # posted.
  posted_at::Union{Dates.DateTime,Nothing}
end
