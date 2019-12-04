# AccountNotification
struct AccountNotification <: CanvasObject
    # The subject of the notifications
    subject::Union{String,Nothing}
    # The message to be sent in the notification.
    message::Union{String,Nothing}
    # When to send out the notification.
    start_at::Union{Dates.DateTime,Nothing}
    # When to expire the notification.
    end_at::Union{Dates.DateTime,Nothing}
    # The icon to display with the message. Defaults to warning.
    icon::Union{String,Nothing}
    # (Deprecated) The roles to send the notification to. If roles is not passed it defaults
    # to all roles
    roles::Union{Vector,Nothing}
    # The roles to send the notification to. If roles is not passed it defaults to all
    # roles
    role_ids::Union{Vector,Nothing}
end
AccountNotification(data::Dict) = json2canvas(AccountNotification, data)

# ReportParameters
struct ReportParameters <: CanvasObject
    # The canvas id of the term to get grades from
    enrollment_term_id::Union{Int,Nothing}
    # If true, deleted objects will be included. If false, deleted objects will be omitted.
    include_deleted::Union{Bool,Nothing}
    # The id of the course to report on
    course_id::Union{Int,Nothing}
    # The sort order for the csv, Options: 'users', 'courses', 'outcomes'.
    order::Union{String,Nothing}
    # If true, user data will be included. If false, user data will be omitted.
    users::Union{Bool,Nothing}
    # If true, account data will be included. If false, account data will be omitted.
    accounts::Union{Bool,Nothing}
    # If true, term data will be included. If false, term data will be omitted.
    terms::Union{Bool,Nothing}
    # If true, course data will be included. If false, course data will be omitted.
    courses::Union{Bool,Nothing}
    # If true, section data will be included. If false, section data will be omitted.
    sections::Union{Bool,Nothing}
    # If true, enrollment data will be included. If false, enrollment data will be omitted.
    enrollments::Union{Bool,Nothing}
    # If true, group data will be included. If false, group data will be omitted.
    groups::Union{Bool,Nothing}
    # If true, data for crosslisted courses will be included. If false, data for crosslisted
    # courses will be omitted.
    xlist::Union{Bool,Nothing}
    sis_terms_csv::Union{Int,Nothing}
    sis_accounts_csv::Union{Int,Nothing}
    # If true, enrollment state will be included. If false, enrollment state will be omitted.
    # Defaults to false.
    include_enrollment_state::Union{Bool,Nothing}
    # Include enrollment state. Defaults to 'all' Options: ['active'| 'invited'| 'creation_pending'|
    # 'deleted'| 'rejected'| 'completed'| 'inactive'| 'all']
    enrollment_state::Union{Vector,Nothing}
    # The beginning date for submissions. Max time range is 2 weeks.
    start_at::Union{Dates.DateTime,Nothing}
    # The end date for submissions. Max time range is 2 weeks.
    end_at::Union{Dates.DateTime,Nothing}
end
ReportParameters(data::Dict) = json2canvas(ReportParameters, data)

# TermsOfService
struct TermsOfService <: CanvasObject
    # Terms Of Service id
    id::Union{Int,Nothing}
    # The given type for the Terms of Service
    terms_type::Union{String,Nothing}
    # Boolean dictating if the user must accept Terms of Service
    passive::Union{Bool,Nothing}
    # The id of the root account that owns the Terms of Service
    account_id::Union{Int,Nothing}
    # Content of the Terms of Service
    content::Union{String,Nothing}
end
TermsOfService(data::Dict) = json2canvas(TermsOfService, data)

# HelpLink
struct HelpLink <: CanvasObject
    # The ID of the help link
    id::Union{String,Nothing}
    # The name of the help link
    text::Union{String,Nothing}
    # The description of the help link
    subtext::Union{String,Nothing}
    # The URL of the help link
    url::Union{String,Nothing}
    # The type of the help link
    type::Union{String,Nothing}
    # The roles that have access to this help link
    available_to::Union{Vector,Nothing}
end
HelpLink(data::Dict) = json2canvas(HelpLink, data)

# HelpLinks
struct HelpLinks <: CanvasObject
    # Help link button title
    help_link_name::Union{String,Nothing}
    # Help link button icon
    help_link_icon::Union{String,Nothing}
    # Help links defined by the account. Could include default help links.
    custom_help_links::Union{Vector,Nothing}
    # Default help links provided when account has not set help links of their own.
    default_help_links::Union{Vector,Nothing}
end
HelpLinks(data::Dict) = json2canvas(HelpLinks, data)

# Appointment
struct Appointment <: CanvasObject
    # The appointment identifier.
    id::Union{Int,Nothing}
    # Start time for the appointment
    start_at::Union{Dates.DateTime,Nothing}
    # End time for the appointment
    end_at::Union{Dates.DateTime,Nothing}
end
Appointment(data::Dict) = json2canvas(Appointment, data)

# AppointmentGroup
struct AppointmentGroup <: CanvasObject
    # The ID of the appointment group
    id::Union{Int,Nothing}
    # The title of the appointment group
    title::Union{String,Nothing}
    # The start of the first time slot in the appointment group
    start_at::Union{Dates.DateTime,Nothing}
    # The end of the last time slot in the appointment group
    end_at::Union{Dates.DateTime,Nothing}
    # The text description of the appointment group
    description::Union{String,Nothing}
    # The location name of the appointment group
    location_name::Union{String,Nothing}
    # The address of the appointment group's location
    location_address::Union{String,Nothing}
    # The number of participant who have reserved slots (see include[] argument)
    participant_count::Union{Int,Nothing}
    # The start and end times of slots reserved by the current user as well as the id of
    # the calendar event for the reservation (see include[] argument)
    reserved_times::Union{Vector,Nothing}
    # The context codes (i.e. courses) this appointment group belongs to. Only people in
    # these courses will be eligible to sign up.
    context_codes::Union{Vector,Nothing}
    # The sub-context codes (i.e. course sections and group categories) this appointment
    # group is restricted to
    sub_context_codes::Union{Vector,Nothing}
    # Current state of the appointment group ('pending', 'active' or 'deleted'). 'pending'
    # indicates that it has not been published yet and is invisible to participants.
    workflow_state::Union{String,Nothing}
    # Boolean indicating whether the current user needs to sign up for this appointment
    # group (i.e. it's reservable and the min_appointments_per_participant limit has not
    # been met by this user).
    requiring_action::Union{Bool,Nothing}
    # Number of time slots in this appointment group
    appointments_count::Union{Int,Nothing}
    # Calendar Events representing the time slots (see include[] argument) Refer to the
    # Calendar Events API for more information
    appointments::Union{Vector,Nothing}
    # Newly created time slots (same format as appointments above). Only returned in Create/Update
    # responses where new time slots have been added
    new_appointments::Union{Vector,Nothing}
    # Maximum number of time slots a user may register for, or null if no limit
    max_appointments_per_participant::Union{Int,Nothing}
    # Minimum number of time slots a user must register for. If not set, users do not need
    # to sign up for any time slots
    min_appointments_per_participant::Union{Int,Nothing}
    # Maximum number of participants that may register for each time slot, or null if no
    # limit
    participants_per_appointment::Union{Int,Nothing}
    # 'private' means participants cannot see who has signed up for a particular time slot,
    # 'protected' means that they can
    participant_visibility::Union{String,Nothing}
    # Indicates how participants sign up for the appointment group, either as individuals
    # ('User') or in student groups ('Group'). Related to sub_context_codes (i.e. 'Group'
    # signups always have a single group category)
    participant_type::Union{String,Nothing}
    # URL for this appointment group (to update, delete, etc.)
    url::Union{String,Nothing}
    # URL for a user to view this appointment group
    html_url::Union{String,Nothing}
    # When the appointment group was created
    created_at::Union{Dates.DateTime,Nothing}
    # When the appointment group was last updated
    updated_at::Union{Dates.DateTime,Nothing}
end
AppointmentGroup(data::Dict) = json2canvas(AppointmentGroup, data)






# RubricCriteria
struct RubricCriteria <: CanvasObject
    points::Union{Int,Nothing}
    # The id of rubric criteria.
    id::Union{String,Nothing}
    # (Optional) The id of the learning outcome this criteria uses, if any.
    learning_outcome_id::Union{String,Nothing}
    # (Optional) The 3rd party vendor's GUID for the outcome this criteria references,
    # if any.
    vendor_guid::Union{String,Nothing}
    description::Union{String,Nothing}
    long_description::Union{String,Nothing}
    criterion_use_range::Union{Bool,Nothing}
    ratings::Union{Vector,Nothing}
    ignore_for_scoring::Union{Bool,Nothing}
end
RubricCriteria(data::Dict) = json2canvas(RubricCriteria, data)

# AssignmentDate
struct AssignmentDate <: CanvasObject
    # (Optional, missing if 'base' is present) id of the assignment override this date
    # represents
    id::Union{Int,Nothing}
    # (Optional, present if 'id' is missing) whether this date represents the assignment's
    # or quiz's default due date
    base::Union{Bool,Nothing}
    title::Union{String,Nothing}
    # The due date for the assignment. Must be between the unlock date and the lock date
    # if there are lock dates
    due_at::Union{Dates.DateTime,Nothing}
    # The unlock date for the assignment. Must be before the due date if there is a due
    # date.
    unlock_at::Union{Dates.DateTime,Nothing}
    # The lock date for the assignment. Must be after the due date if there is a due date.
    lock_at::Union{Dates.DateTime,Nothing}
end
AssignmentDate(data::Dict) = json2canvas(AssignmentDate, data)

# NeedsGradingCount
struct NeedsGradingCount <: CanvasObject
    # The section ID
    section_id::Union{String,Nothing}
    # Number of submissions that need grading
    needs_grading_count::Union{Int,Nothing}
end
NeedsGradingCount(data::Dict) = json2canvas(NeedsGradingCount, data)

# AuthenticationEvent
struct AuthenticationEvent <: CanvasObject
    # timestamp of the event
    created_at::Union{Dates.DateTime,Nothing}
    # authentication event type ('login' or 'logout')
    event_type::Union{String,Nothing}
    # ID of the pseudonym (login) associated with the event
    pseudonym_id::Union{Int,Nothing}
    # ID of the account associated with the event. will match the account_id in the associated
    # pseudonym.
    account_id::Union{Int,Nothing}
    # ID of the user associated with the event will match the user_id in the associated
    # pseudonym.
    user_id::Union{Int,Nothing}
end
AuthenticationEvent(data::Dict) = json2canvas(AuthenticationEvent, data)

# SSOSettings
struct SSOSettings <: CanvasObject
    # The label used for unique login identifiers.
    login_handle_name::Union{String,Nothing}
    # The url to redirect users to for password resets. Leave blank for default Canvas
    # behavior
    change_password_url::Union{String,Nothing}
    # If a discovery url is set, canvas will forward all users to that URL when they need
    # to be authenticated. That page will need to then help the user figure out where they
    # need to go to log in. If no discovery url is configured, the first configuration
    # will be used to attempt to authenticate the user.
    auth_discovery_url::Union{String,Nothing}
    # If an unknown user url is set, Canvas will forward to that url when a service authenticates
    # a user, but that user does not exist in Canvas. The default behavior is to present
    # an error.
    unknown_user_url::Union{String,Nothing}
end
SSOSettings(data::Dict) = json2canvas(SSOSettings, data)

# FederatedAttributesConfig
struct FederatedAttributesConfig <: CanvasObject
    # A comma separated list of role names to grant to the user. Note that these only apply
    # at the root account level, and not sub-accounts. If the attribute is not marked for
    # provisioning only, the user will also be removed from any other roles they currently
    # hold that are not still specified by the IdP.
    admin_roles::Union{String,Nothing}
    # The full display name of the user
    display_name::Union{String,Nothing}
    # The user's e-mail address
    email::Union{String,Nothing}
    # The first, or given, name of the user
    given_name::Union{String,Nothing}
    # The secondary unique identifier for SIS purposes
    integration_id::Union{String,Nothing}
    # The user's preferred locale/language
    locale::Union{String,Nothing}
    # The full name of the user
    name::Union{String,Nothing}
    # The unique SIS identifier
    sis_user_id::Union{String,Nothing}
    # The full name of the user for sorting purposes
    sortable_name::Union{String,Nothing}
    # The surname, or last name, of the user
    surname::Union{String,Nothing}
    # The user's preferred time zone
    timezone::Union{String,Nothing}
end
FederatedAttributesConfig(data::Dict) = json2canvas(FederatedAttributesConfig, data)

# AuthenticationProvider
struct AuthenticationProvider <: CanvasObject
    # Valid for SAML providers.
    identifier_format::Union{String,Nothing}
    # Valid for all providers.
    auth_type::Union{String,Nothing}
    # Valid for all providers.
    id::Union{Int,Nothing}
    # Valid for SAML providers.
    log_out_url::Union{String,Nothing}
    # Valid for SAML and CAS providers.
    log_in_url::Union{String,Nothing}
    # Valid for SAML providers.
    certificate_fingerprint::Union{String,Nothing}
    # Valid for SAML providers.
    requested_authn_context::Union{String,Nothing}
    # Valid for LDAP providers.
    auth_host::Union{String,Nothing}
    # Valid for LDAP providers.
    auth_filter::Union{String,Nothing}
    # Valid for LDAP providers.
    auth_over_tls::Union{Int,Nothing}
    # Valid for LDAP and CAS providers.
    auth_base::Union{String,Nothing}
    # Valid for LDAP providers.
    auth_username::Union{String,Nothing}
    # Valid for LDAP providers.
    auth_port::Union{Int,Nothing}
    # Valid for all providers.
    position::Union{Int,Nothing}
    # Valid for SAML providers.
    idp_entity_id::Union{String,Nothing}
    # Valid for SAML providers.
    login_attribute::Union{String,Nothing}
    # Valid for SAML providers.
    sig_alg::Union{String,Nothing}
    # Just In Time provisioning. Valid for all providers except Canvas (which has the similar
    # in concept self_registration setting).
    jit_provisioning::Union{Bool,Nothing}
    federated_attributes::Union{FederatedAttributesConfig,Nothing}
end
AuthenticationProvider(data::Dict) = json2canvas(AuthenticationProvider, data)

# FederatedAttributeConfig
struct FederatedAttributeConfig <: CanvasObject
    # The name of the attribute as it will be sent from the authentication provider
    attribute::Union{String,Nothing}
    # If the attribute should be applied only when provisioning a new user, rather than
    # all logins
    provisioning_only::Union{Bool,Nothing}
end
FederatedAttributeConfig(data::Dict) = json2canvas(FederatedAttributeConfig, data)

# CalendarEvent
struct CalendarEvent <: CanvasObject
    # The ID of the calendar event
    id::Union{Int,Nothing}
    # The title of the calendar event
    title::Union{String,Nothing}
    # The start timestamp of the event
    start_at::Union{Dates.DateTime,Nothing}
    # The end timestamp of the event
    end_at::Union{Dates.DateTime,Nothing}
    # The HTML description of the event
    description::Union{String,Nothing}
    # The location name of the event
    location_name::Union{String,Nothing}
    # The address where the event is taking place
    location_address::Union{String,Nothing}
    # the context code of the calendar this event belongs to (course, user or group)
    context_code::Union{String,Nothing}
    # if specified, it indicates which calendar this event should be displayed on. for
    # example, a section-level event would have the course's context code here, while the
    # section's context code would be returned above)
    effective_context_code::Union{String,Nothing}
    # a comma-separated list of all calendar contexts this event is part of
    all_context_codes::Union{String,Nothing}
    # Current state of the event ('active', 'locked' or 'deleted') 'locked' indicates that
    # start_at/end_at cannot be changed (though the event could be deleted). Normally only
    # reservations or time slots with reservations are locked (see the Appointment Groups
    # API)
    workflow_state::Union{String,Nothing}
    # Whether this event should be displayed on the calendar. Only true for course-level
    # events with section-level child events.
    hidden::Union{Bool,Nothing}
    # Normally null. If this is a reservation (see the Appointment Groups API), the id
    # will indicate the time slot it is for. If this is a section-level event, this will
    # be the course-level parent event.
    parent_event_id::Union{Int,Nothing}
    # The number of child_events. See child_events (and parent_event_id)
    child_events_count::Union{Int,Nothing}
    # Included by default, but may be excluded (see include[] option). If this is a time
    # slot (see the Appointment Groups API) this will be a list of any reservations. If
    # this is a course-level event, this will be a list of section-level events (if any)
    child_events::Union{Vector,Nothing}
    # URL for this calendar event (to update, delete, etc.)
    url::Union{String,Nothing}
    # URL for a user to view this event
    html_url::Union{String,Nothing}
    # The date of this event
    all_day_date::Union{Dates.DateTime,Nothing}
    # Boolean indicating whether this is an all-day event (midnight to midnight)
    all_day::Union{Bool,Nothing}
    # When the calendar event was created
    created_at::Union{Dates.DateTime,Nothing}
    # When the calendar event was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # Various Appointment-Group-related fields.These fields are only pertinent to time
    # slots (appointments) and reservations of those time slots. See the Appointment Groups
    # API. The id of the appointment group
    appointment_group_id::Union{Int,Nothing}
    # The API URL of the appointment group
    appointment_group_url::Union{String,Nothing}
    # If the event is a reservation, this a boolean indicating whether it is the current
    # user's reservation, or someone else's
    own_reservation::Union{Bool,Nothing}
    # If the event is a time slot, the API URL for reserving it
    reserve_url::Union{String,Nothing}
    # If the event is a time slot, a boolean indicating whether the user has already made
    # a reservation for it
    reserved::Union{Bool,Nothing}
    # The type of participant to sign up for a slot: 'User' or 'Group'
    participant_type::Union{String,Nothing}
    # If the event is a time slot, this is the participant limit
    participants_per_appointment::Union{Int,Nothing}
    # If the event is a time slot and it has a participant limit, an integer indicating
    # how many slots are available
    available_slots::Union{Int,Nothing}
    # If the event is a user-level reservation, this will contain the user participant
    # JSON (refer to the Users API).
    user::Union{String,Nothing}
    # If the event is a group-level reservation, this will contain the group participant
    # JSON (refer to the Groups API).
    group::Union{String,Nothing}
end
CalendarEvent(data::Dict) = json2canvas(CalendarEvent, data)

# Collaboration
struct Collaboration <: CanvasObject
    # The unique identifier for the collaboration
    id::Union{Int,Nothing}
    # A name for the type of collaboration
    collaboration_type::Union{String,Nothing}
    # The collaboration document identifier for the collaboration provider
    document_id::Union{String,Nothing}
    # The canvas id of the user who created the collaboration
    user_id::Union{Int,Nothing}
    # The canvas id of the course or group to which the collaboration belongs
    context_id::Union{Int,Nothing}
    # The canvas type of the course or group to which the collaboration belongs
    context_type::Union{String,Nothing}
    # The LTI launch url to view collaboration.
    url::Union{String,Nothing}
    # The timestamp when the collaboration was created
    created_at::Union{Dates.DateTime,Nothing}
    # The timestamp when the collaboration was last modified
    updated_at::Union{Dates.DateTime,Nothing}
    description::Union{String,Nothing}
    title::Union{String,Nothing}
    # Another representation of the collaboration type
    type::Union{String,Nothing}
    # The LTI launch url to edit the collaboration
    update_url::Union{String,Nothing}
    # The name of the user who owns the collaboration
    user_name::Union{String,Nothing}
end
Collaboration(data::Dict) = json2canvas(Collaboration, data)

# Collaborator
struct Collaborator <: CanvasObject
    # The unique user or group identifier for the collaborator.
    id::Union{Int,Nothing}
    # The type of collaborator (e.g. 'user' or 'group').
    type::Union{String,Nothing}
    # The name of the collaborator.
    name::Union{String,Nothing}
end
Collaborator(data::Dict) = json2canvas(Collaborator, data)

# CommMessage
struct CommMessage <: CanvasObject
    # The ID of the CommMessage.
    id::Union{Int,Nothing}
    # The date and time this message was created
    created_at::Union{Dates.DateTime,Nothing}
    # The date and time this message was sent
    sent_at::Union{Dates.DateTime,Nothing}
    # The workflow state of the message. One of 'created', 'staged', 'sending', 'sent',
    # 'bounced', 'dashboard', 'cancelled', or 'closed'
    workflow_state::Union{String,Nothing}
    # The address that was put in the 'from' field of the message
    from::Union{String,Nothing}
    # The display name for the from address
    from_name::Union{String,Nothing}
    # The address the message was sent to:
    to::Union{String,Nothing}
    # The reply_to header of the message
    reply_to::Union{String,Nothing}
    # The message subject
    subject::Union{String,Nothing}
    # The plain text body of the message
    body::Union{String,Nothing}
    # The HTML body of the message.
    html_body::Union{String,Nothing}
end
CommMessage(data::Dict) = json2canvas(CommMessage, data)

# CommunicationChannel
struct CommunicationChannel <: CanvasObject
    # The ID of the communication channel.
    id::Union{Int,Nothing}
    # The address, or path, of the communication channel.
    address::Union{String,Nothing}
    # The type of communcation channel being described. Possible values are: 'email', 'push',
    # 'sms', or 'twitter'. This field determines the type of value seen in 'address'.
    type::Union{String,Nothing}
    # The position of this communication channel relative to the user's other channels
    # when they are ordered.
    position::Union{Int,Nothing}
    # The ID of the user that owns this communication channel.
    user_id::Union{Int,Nothing}
    # The current state of the communication channel. Possible values are: 'unconfirmed'
    # or 'active'.
    workflow_state::Union{String,Nothing}
end
CommunicationChannel(data::Dict) = json2canvas(CommunicationChannel, data)

# ConferenceRecording
struct ConferenceRecording <: CanvasObject
    duration_minutes::Union{Int,Nothing}
    title::Union{String,Nothing}
    updated_at::Union{Dates.DateTime,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    playback_url::Union{String,Nothing}
end
ConferenceRecording(data::Dict) = json2canvas(ConferenceRecording, data)

# Conference
struct Conference <: CanvasObject
    # The id of the conference
    id::Union{Int,Nothing}
    # The type of conference
    conference_type::Union{String,Nothing}
    # The 3rd party's ID for the conference
    conference_key::Union{String,Nothing}
    # The description for the conference
    description::Union{String,Nothing}
    # The expected duration the conference is supposed to last
    duration::Union{Int,Nothing}
    # The date that the conference ended at, null if it hasn't ended
    ended_at::Union{Dates.DateTime,Nothing}
    # The date the conference started at, null if it hasn't started
    started_at::Union{Dates.DateTime,Nothing}
    # The title of the conference
    title::Union{String,Nothing}
    # Array of user ids that are participants in the conference
    users::Union{Vector,Nothing}
    # True if the conference type has advanced settings.
    has_advanced_settings::Union{Bool,Nothing}
    # If true the conference is long running and has no expected end time
    long_running::Union{Bool,Nothing}
    # A collection of settings specific to the conference type
    user_settings::Union{Dict,Nothing}
    # A List of recordings for the conference
    recordings::Union{Vector,Nothing}
    # URL for the conference, may be null if the conference type doesn't set it
    url::Union{String,Nothing}
    # URL to join the conference, may be null if the conference type doesn't set it
    join_url::Union{String,Nothing}
end
Conference(data::Dict) = json2canvas(Conference, data)

# ContentMigration
struct ContentMigration <: CanvasObject
    # the unique identifier for the migration
    id::Union{Int,Nothing}
    # the type of content migration
    migration_type::Union{String,Nothing}
    # the name of the content migration type
    migration_type_title::Union{String,Nothing}
    # API url to the content migration's issues
    migration_issues_url::Union{String,Nothing}
    # attachment api object for the uploaded file may not be present for all migrations
    attachment::Union{String,Nothing}
    # The api endpoint for polling the current progress
    progress_url::Union{String,Nothing}
    # The user who started the migration
    user_id::Union{Int,Nothing}
    # Current state of the content migration: pre_processing, pre_processed, running, waiting_for_select,
    # completed, failed
    workflow_state::Union{String,Nothing}
    # timestamp
    started_at::Union{Dates.DateTime,Nothing}
    # timestamp
    finished_at::Union{Dates.DateTime,Nothing}
    # file uploading data, see {file:file_uploads.html File Upload Documentation} for file
    # upload workflow This works a little differently in that all the file data is in the
    # pre_attachment hash if there is no upload_url then there was an attachment pre-processing
    # error, the error message will be in the message key This data will only be here after
    # a create or update call
    pre_attachment::Union{String,Nothing}
end
ContentMigration(data::Dict) = json2canvas(ContentMigration, data)

# Migrator
struct Migrator <: CanvasObject
    # The value to pass to the create endpoint
    type::Union{String,Nothing}
    # Whether this endpoint requires a file upload
    requires_file_upload::Union{Bool,Nothing}
    # Description of the package type expected
    name::Union{String,Nothing}
    # A list of fields this system requires
    required_settings::Union{Vector,Nothing}
end
Migrator(data::Dict) = json2canvas(Migrator, data)

# CompletionRequirement
struct CompletionRequirement <: CanvasObject
    # one of 'must_view', 'must_submit', 'must_contribute', 'min_score'
    type::Union{String,Nothing}
    # minimum score required to complete (only present when type == 'min_score')
    min_score::Union{Int,Nothing}
    # whether the calling user has met this requirement (Optional; present only if the
    # caller is a student or if the optional parameter 'student_id' is included)
    completed::Union{Bool,Nothing}
end
CompletionRequirement(data::Dict) = json2canvas(CompletionRequirement, data)

# ContentDetails
struct ContentDetails <: CanvasObject
    points_possible::Union{Int,Nothing}
    due_at::Union{Dates.DateTime,Nothing}
    unlock_at::Union{Dates.DateTime,Nothing}
    lock_at::Union{Dates.DateTime,Nothing}
    locked_for_user::Union{Bool,Nothing}
    lock_explanation::Union{String,Nothing}
    lock_info::Union{LockInfo,Nothing}
end
ContentDetails(data::Dict) = json2canvas(ContentDetails, data)

# ModuleItem
struct ModuleItem <: CanvasObject
    # the unique identifier for the module item
    id::Union{Int,Nothing}
    # the id of the Module this item appears in
    module_id::Union{Int,Nothing}
    # the position of this item in the module (1-based)
    position::Union{Int,Nothing}
    # the title of this item
    title::Union{String,Nothing}
    # 0-based indent level; module items may be indented to show a hierarchy
    indent::Union{Int,Nothing}
    # the type of object referred to one of 'File', 'Page', 'Discussion', 'Assignment',
    # 'Quiz', 'SubHeader', 'ExternalUrl', 'ExternalTool'
    type::Union{String,Nothing}
    # the id of the object referred to applies to 'File', 'Discussion', 'Assignment', 'Quiz',
    # 'ExternalTool' types
    content_id::Union{Int,Nothing}
    # link to the item in Canvas
    html_url::Union{String,Nothing}
    # (Optional) link to the Canvas API object, if applicable
    url::Union{String,Nothing}
    # (only for 'Page' type) unique locator for the linked wiki page
    page_url::Union{String,Nothing}
    # (only for 'ExternalUrl' and 'ExternalTool' types) external url that the item points
    # to
    external_url::Union{String,Nothing}
    # (only for 'ExternalTool' type) whether the external tool opens in a new tab
    new_tab::Union{Bool,Nothing}
    # Completion requirement for this module item
    completion_requirement::Union{CompletionRequirement,Nothing}
    # (Present only if requested through include[]=content_details) If applicable, returns
    # additional details specific to the associated object
    content_details::Union{ContentDetails,Nothing}
    # (Optional) Whether this module item is published. This field is present only if the
    # caller has permission to view unpublished items.
    published::Union{Bool,Nothing}
end
ModuleItem(data::Dict) = json2canvas(ModuleItem, data)

# ModuleItemSequenceNode
struct ModuleItemSequenceNode <: CanvasObject
    # The previous ModuleItem in the sequence
    prev::Union{ModuleItem,Nothing}
    # The ModuleItem being queried
    current::Union{ModuleItem,Nothing}
    # The next ModuleItem in the sequence
    next::Union{ModuleItem,Nothing}
    # The conditional release rule for the module item, if applicable
    mastery_path::Union{Dict,Nothing}
end
ModuleItemSequenceNode(data::Dict) = json2canvas(ModuleItemSequenceNode, data)

# ModuleItemSequence
struct ModuleItemSequence <: CanvasObject
    # an array containing one ModuleItemSequenceNode for each appearence of the asset in
    # the module sequence (up to 10 total)
    items::Union{Vector,Nothing}
    # an array containing each Module referenced above
    modules::Union{Vector,Nothing}
end
ModuleItemSequence(data::Dict) = json2canvas(ModuleItemSequence, data)

# Module
struct Module <: CanvasObject
    # the unique identifier for the module
    id::Union{Int,Nothing}
    # the state of the module: 'active', 'deleted'
    workflow_state::Union{String,Nothing}
    # the position of this module in the course (1-based)
    position::Union{Int,Nothing}
    # the name of this module
    name::Union{String,Nothing}
    # (Optional) the date this module will unlock
    unlock_at::Union{Dates.DateTime,Nothing}
    # Whether module items must be unlocked in order
    require_sequential_progress::Union{Bool,Nothing}
    # IDs of Modules that must be completed before this one is unlocked
    prerequisite_module_ids::Union{Vector,Nothing}
    # The number of items in the module
    items_count::Union{Int,Nothing}
    # The API URL to retrive this module's items
    items_url::Union{String,Nothing}
    # The contents of this module, as an array of Module Items. (Present only if requested
    # via include[]=items AND the module is not deemed too large by Canvas.)
    items::Union{Vector,Nothing}
    # The state of this Module for the calling user one of 'locked', 'unlocked', 'started',
    # 'completed' (Optional; present only if the caller is a student or if the optional
    # parameter 'student_id' is included)
    state::Union{String,Nothing}
    # the date the calling user completed the module (Optional; present only if the caller
    # is a student or if the optional parameter 'student_id' is included)
    completed_at::Union{Dates.DateTime,Nothing}
    # if the student's final grade for the course should be published to the SIS upon completion
    # of this module
    publish_final_grade::Union{Bool,Nothing}
    # (Optional) Whether this module is published. This field is present only if the caller
    # has permission to view unpublished modules.
    published::Union{Bool,Nothing}
end
Module(data::Dict) = json2canvas(Module, data)

# ConversationParticipant
struct ConversationParticipant <: CanvasObject
    # The user ID for the participant.
    id::Union{Int,Nothing}
    # A short name the user has selected, for use in conversations or other less formal
    # places through the site.
    name::Union{String,Nothing}
    # The full name of the user.
    full_name::Union{String,Nothing}
    # If requested, this field will be included and contain a url to retrieve the user's
    # avatar.
    avatar_url::Union{String,Nothing}
end
ConversationParticipant(data::Dict) = json2canvas(ConversationParticipant, data)

# Message
struct Message <: CanvasObject
    id::Union{Int,Nothing}
    author_id::Union{Int,Nothing}
    body::Union{String,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    participating_user_ids::Union{Vector,Nothing}
    media_comment::Union{String,Nothing}
    attachments::Union{Vector,Nothing}
    generated::Union{Bool,Nothing}
    forwarded_messages::Union{Vector{Message},Nothing}
end
Message(data::Dict) = json2canvas(Message, data)

# Conversation
struct Conversation <: CanvasObject
    # the unique identifier for the conversation.
    id::Union{Int,Nothing}
    # the subject of the conversation.
    subject::Union{String,Nothing}
    # The current state of the conversation (read, unread or archived).
    workflow_state::Union{String,Nothing}
    # A <=100 character preview from the most recent message.
    last_message::Union{String,Nothing}
    # the date and time at which the last message was sent.
    start_at::Union{Dates.DateTime,Nothing}
    # the number of messages in the conversation.
    message_count::Union{Int,Nothing}
    # whether the current user is subscribed to the conversation.
    subscribed::Union{Bool,Nothing}
    # whether the conversation is private.
    private::Union{Bool,Nothing}
    # whether the conversation is starred.
    starred::Union{Bool,Nothing}
    # Additional conversation flags (last_author, attachments, media_objects). Each listed
    # property means the flag is set to true (i.e. the current user is the most recent
    # author, there are attachments, or there are media objects)
    properties::Union{Vector,Nothing}
    # Array of user ids who are involved in the conversation, ordered by participation
    # level, then alphabetical. Excludes current user, unless this is a monologue.
    audience::Union{Vector,Nothing}
    # Most relevant shared contexts (courses and groups) between current user and other
    # participants. If there is only one participant, it will also include that user's
    # enrollment(s)/ membership type(s) in each course/group.
    audience_contexts::Union{Vector,Nothing}
    # URL to appropriate icon for this conversation (custom, individual or group avatar,
    # depending on audience).
    avatar_url::Union{String,Nothing}
    # Array of users participating in the conversation. Includes current user.
    participants::Union{Vector{ConversationParticipant},Nothing}
    # indicates whether the conversation is visible under the current scope and filter.
    # This attribute is always true in the index API response, and is primarily useful
    # in create/update responses so that you can know if the record should be displayed
    # in the UI. The default scope is assumed, unless a scope or filter is passed to the
    # create/update API call.
    visible::Union{Bool,Nothing}
    # Name of the course or group in which the conversation is occurring.
    context_name::Union{String,Nothing}
    messages::Union{Vector{Message},Nothing}
end
Conversation(data::Dict) = json2canvas(Conversation, data)

# CourseEventLink
struct CourseEventLink <: CanvasObject
    # ID of the course for the event.
    course::Union{Int,Nothing}
    # ID of the user for the event (who made the change).
    user::Union{Int,Nothing}
    # ID of the page view during the event if it exists.
    page_view::Union{String,Nothing}
    # ID of the course that this course was copied from. This is only included if the event_type
    # is copied_from.
    copied_from::Union{Int,Nothing}
    # ID of the course that this course was copied to. This is only included if the event_type
    # is copied_to.
    copied_to::Union{Int,Nothing}
    # ID of the SIS batch that triggered the event.
    sis_batch::Union{Int,Nothing}
end
CourseEventLink(data::Dict) = json2canvas(CourseEventLink, data)

# CourseEvent
struct CourseEvent <: CanvasObject
    # ID of the event.
    id::Union{String,Nothing}
    # timestamp of the event
    created_at::Union{Dates.DateTime,Nothing}
    # Course event type The event type defines the type and schema of the event_data object.
    event_type::Union{String,Nothing}
    # Course event data depending on the event type. This will return an object containing
    # the relevant event data. An updated event type will return an UpdatedEventData object.
    event_data::Union{String,Nothing}
    # Course event source depending on the event type. This will return a string containing
    # the source of the event.
    event_source::Union{String,Nothing}
    # Jsonapi.org links
    links::Union{CourseEventLink,Nothing}
end
CourseEvent(data::Dict) = json2canvas(CourseEvent, data)

# CreatedEventData
struct CreatedEventData <: CanvasObject
    name::Union{Vector,Nothing}
    start_at::Union{Vector,Nothing}
    conclude_at::Union{Vector,Nothing}
    is_public::Union{Vector,Nothing}
    # The type of action that triggered the creation of the course.
    created_source::Union{String,Nothing}
end
CreatedEventData(data::Dict) = json2canvas(CreatedEventData, data)

# UpdatedEventData
struct UpdatedEventData <: CanvasObject
    name::Union{Vector,Nothing}
    start_at::Union{Vector,Nothing}
    conclude_at::Union{Vector,Nothing}
    is_public::Union{Vector,Nothing}
end
UpdatedEventData(data::Dict) = json2canvas(UpdatedEventData, data)

# CourseNickname
struct CourseNickname <: CanvasObject
    # the ID of the course
    course_id::Union{Int,Nothing}
    # the actual name of the course
    name::Union{String,Nothing}
    # the calling user's nickname for the course
    nickname::Union{String,Nothing}
end
CourseNickname(data::Dict) = json2canvas(CourseNickname, data)



# ColumnDatum
struct ColumnDatum <: CanvasObject
    content::Union{String,Nothing}
    user_id::Union{Int,Nothing}
end
ColumnDatum(data::Dict) = json2canvas(ColumnDatum, data)

# CustomColumn
struct CustomColumn <: CanvasObject
    # The ID of the custom gradebook column
    id::Union{Int,Nothing}
    # When true, this column's visibility will be toggled in the Gradebook when a user
    # selects to show or hide notes
    teacher_notes::Union{Bool,Nothing}
    # header text
    title::Union{String,Nothing}
    # column order
    position::Union{Int,Nothing}
    # won't be displayed if hidden is true
    hidden::Union{Bool,Nothing}
    # won't be editable in the gradebook UI
    read_only::Union{Bool,Nothing}
end
CustomColumn(data::Dict) = json2canvas(CustomColumn, data)

# DeveloperKeyAccountBinding
struct DeveloperKeyAccountBinding <: CanvasObject
    # The Canvas ID of the binding
    id::Union{Float64,Nothing}
    # The global Canvas ID of the account in the binding
    account_id::Union{Float64,Nothing}
    # The global Canvas ID of the developer key in the binding
    developer_key_id::Union{Float64,Nothing}
    # The workflow state of the binding. Will be one of 'on', 'off', or 'allow.'
    workflow_state::Union{Float64,Nothing}
    # True if the requested context owns the binding
    account_owns_binding::Union{Bool,Nothing}
end
DeveloperKeyAccountBinding(data::Dict) = json2canvas(DeveloperKeyAccountBinding, data)

# FileAttachment
struct FileAttachment <: CanvasObject
    content_type::Union{String,Nothing}
    url::Union{String,Nothing}
    filename::Union{String,Nothing}
    display_name::Union{String,Nothing}
end
FileAttachment(data::Dict) = json2canvas(FileAttachment, data)


# Grade
struct Grade <: CanvasObject
    # The URL to the Canvas web UI page for the user's grades, if this is a student enrollment.
    html_url::Union{String,Nothing}
    # The user's current grade in the class. Only included if user has permissions to view
    # this grade.
    current_grade::Union{String,Nothing}
    # The user's final grade for the class. Only included if user has permissions to view
    # this grade.
    final_grade::Union{String,Nothing}
    # The user's current score in the class. Only included if user has permissions to view
    # this score.
    current_score::Union{String,Nothing}
    # The user's final score for the class. Only included if user has permissions to view
    # this score.
    final_score::Union{String,Nothing}
    # The user's current grade in the class including muted/unposted assignments. Only
    # included if user has permissions to view this grade, typically teachers, TAs, and
    # admins.
    unposted_current_grade::Union{String,Nothing}
    # The user's final grade for the class including muted/unposted assignments. Only included
    # if user has permissions to view this grade, typically teachers, TAs, and admins..
    unposted_final_grade::Union{String,Nothing}
    # The user's current score in the class including muted/unposted assignments. Only
    # included if user has permissions to view this score, typically teachers, TAs, and
    # admins..
    unposted_current_score::Union{String,Nothing}
    # The user's final score for the class including muted/unposted assignments. Only included
    # if user has permissions to view this score, typically teachers, TAs, and admins..
    unposted_final_score::Union{String,Nothing}
end
Grade(data::Dict) = json2canvas(Grade, data)

# ExternalFeed
struct ExternalFeed <: CanvasObject
    # The ID of the feed
    id::Union{Int,Nothing}
    # The title of the feed, pulled from the feed itself. If the feed hasn't yet been pulled,
    # a temporary name will be synthesized based on the URL
    display_name::Union{String,Nothing}
    # The HTTP/HTTPS URL to the feed
    url::Union{String,Nothing}
    # If not null, only feed entries whose title contains this string will trigger new
    # posts in Canvas
    header_match::Union{String,Nothing}
    # When this external feed was added to Canvas
    created_at::Union{Dates.DateTime,Nothing}
    # The verbosity setting determines how much of the feed's content is imported into
    # Canvas as part of the posting. 'link_only' means that only the title and a link to
    # the item. 'truncate' means that a summary of the first portion of the item body will
    # be used. 'full' means that the full item body will be used.
    verbosity::Union{String,Nothing}
end
ExternalFeed(data::Dict) = json2canvas(ExternalFeed, data)

# Favorite
struct Favorite <: CanvasObject
    # The ID of the object the Favorite refers to
    context_id::Union{Int,Nothing}
    # The type of the object the Favorite refers to (currently, only 'Course' is supported)
    context_type::Union{String,Nothing}
end
Favorite(data::Dict) = json2canvas(Favorite, data)

# FeatureFlag
struct FeatureFlag <: CanvasObject
    # The type of object to which this flag applies (Account, Course, or User). (This field
    # is not present if this FeatureFlag represents the global Canvas default)
    context_type::Union{String,Nothing}
    # The id of the object to which this flag applies (This field is not present if this
    # FeatureFlag represents the global Canvas default)
    context_id::Union{Int,Nothing}
    # The feature this flag controls
    feature::Union{String,Nothing}
    # The policy for the feature at this context. can be 'off', 'allowed', or 'on'.
    state::Union{String,Nothing}
    # If set, this feature flag cannot be changed in the caller's context because the flag
    # is set 'off' or 'on' in a higher context
    locked::Union{Bool,Nothing}
end
FeatureFlag(data::Dict) = json2canvas(FeatureFlag, data)

# Feature
struct Feature <: CanvasObject
    # The symbolic name of the feature, used in FeatureFlags
    name::Union{String,Nothing}
    # The user-visible name of the feature
    display_name::Union{String,Nothing}
    # The type of object the feature applies to (RootAccount, Account, Course, or User):
    # * RootAccount features may only be controlled by flags on root accounts. * Account
    # features may be controlled by flags on accounts and their parent accounts. * Course
    # features may be controlled by flags on courses and their parent accounts. * User
    # features may be controlled by flags on users and site admin only.
    applies_to::Union{String,Nothing}
    # The date this feature will be globally enabled, or null if this is not planned. (This
    # information is subject to change.)
    enable_at::Union{Dates.DateTime,Nothing}
    # The FeatureFlag that applies to the caller
    feature_flag::Union{FeatureFlag,Nothing}
    # If true, a feature that is 'allowed' globally will be 'off' by default in root accounts.
    # Otherwise, root accounts inherit the global 'allowed' setting, which allows sub-accounts
    # and courses to turn features on with no root account action.
    root_opt_in::Union{Bool,Nothing}
    # Whether the feature is a beta feature. If true, the feature may not be fully polished
    # and may be subject to change in the future.
    beta::Union{Bool,Nothing}
    # Whether the details of the feature are autoexpanded on page load vs. the user clicking
    # to expand.
    autoexpand::Union{Bool,Nothing}
    # Whether the feature is in active development. Features in this state are only visible
    # in test and beta instances and are not yet available for production use.
    development::Union{Bool,Nothing}
    # A URL to the release notes describing the feature
    release_notes_url::Union{String,Nothing}
end
Feature(data::Dict) = json2canvas(Feature, data)



# Report
struct Report <: CanvasObject
    # The unique identifier for the report.
    id::Union{Int,Nothing}
    # The type of report.
    report::Union{String,Nothing}
    # The url to the report download.
    file_url::Union{String,Nothing}
    # The attachment api object of the report. Only available after the report has completed.
    attachment::Union{File,Nothing}
    # The status of the report
    status::Union{String,Nothing}
    # The date and time the report was created.
    created_at::Union{Dates.DateTime,Nothing}
    # The date and time the report started processing.
    started_at::Union{Dates.DateTime,Nothing}
    # The date and time the report finished processing.
    ended_at::Union{Dates.DateTime,Nothing}
    # The report parameters
    parameters::Union{ReportParameters,Nothing}
    # The progress of the report
    progress::Union{Int,Nothing}
    # This is the current line count being written to the report. It updates every 1000
    # records.
    current_line::Union{Int,Nothing}
end
Report(data::Dict) = json2canvas(Report, data)

# ContentExport
struct ContentExport <: CanvasObject
    # the unique identifier for the export
    id::Union{Int,Nothing}
    # the date and time this export was requested
    created_at::Union{Dates.DateTime,Nothing}
    # the type of content migration: 'common_cartridge' or 'qti'
    export_type::Union{String,Nothing}
    # attachment api object for the export package (not present before the export completes
    # or after it becomes unavailable for download.)
    attachment::Union{File,Nothing}
    # The api endpoint for polling the current progress
    progress_url::Union{String,Nothing}
    # The ID of the user who started the export
    user_id::Union{Int,Nothing}
    # Current state of the content migration: created exporting exported failed
    workflow_state::Union{String,Nothing}
end
ContentExport(data::Dict) = json2canvas(ContentExport, data)

# ContentShare
struct ContentShare <: CanvasObject
    # The id of the content share for the current user
    id::Union{Int,Nothing}
    # The name of the shared content
    name::Union{String,Nothing}
    # The type of content that was shared. Can be assignment, discussion_topic, page, quiz,
    # module, or module_item.
    content_type::Union{String,Nothing}
    # The datetime the content was shared with this user.
    created_at::Union{Dates.DateTime,Nothing}
    # The datetime the content was updated.
    updated_at::Union{Dates.DateTime,Nothing}
    # The id of the user who sent or received the content share.
    user_id::Union{Int,Nothing}
    # The user who shared the content. This field is provided only to receivers; it is
    # not populated in the sender's list of sent content shares.
    sender::Union{Dict,Nothing}
    # An Array of users the content is shared with. This field is provided only to senders;
    # an empty array will be returned for the receiving users.
    receivers::Union{Vector,Nothing}
    # The course the content was originally shared from.
    source_course::Union{Dict,Nothing}
    # Whether the recipient has viewed the content share.
    read_state::Union{String,Nothing}
    # The content export record associated with this content share
    content_export::Union{ContentExport,Nothing}
end
ContentShare(data::Dict) = json2canvas(ContentShare, data)

# EpubExport
struct EpubExport <: CanvasObject
    # the unique identifier for the export
    id::Union{Int,Nothing}
    # the date and time this export was requested
    created_at::Union{Dates.DateTime,Nothing}
    # attachment api object for the export ePub (not present until the export completes)
    attachment::Union{File,Nothing}
    # The api endpoint for polling the current progress
    progress_url::Union{String,Nothing}
    # The ID of the user who started the export
    user_id::Union{Int,Nothing}
    # Current state of the ePub export: created exporting exported generating generated
    # failed
    workflow_state::Union{String,Nothing}
end
EpubExport(data::Dict) = json2canvas(EpubExport, data)


# CourseEpubExport
struct CourseEpubExport <: CanvasObject
    # the unique identifier for the course
    id::Union{Int,Nothing}
    # the name for the course
    name::Union{String,Nothing}
    # ePub export API object
    epub_export::Union{EpubExport,Nothing}
end
CourseEpubExport(data::Dict) = json2canvas(CourseEpubExport, data)

# GradeChangeEventLinks
struct GradeChangeEventLinks <: CanvasObject
    # ID of the assignment associated with the event
    assignment::Union{Int,Nothing}
    # ID of the course associated with the event. will match the context_id in the associated
    # assignment if the context type for the assignment is a course
    course::Union{Int,Nothing}
    # ID of the student associated with the event. will match the user_id in the associated
    # submission.
    student::Union{Int,Nothing}
    # ID of the grader associated with the event. will match the grader_id in the associated
    # submission.
    grader::Union{Int,Nothing}
    # ID of the page view during the event if it exists.
    page_view::Union{String,Nothing}
end
GradeChangeEventLinks(data::Dict) = json2canvas(GradeChangeEventLinks, data)

# GradeChangeEvent
struct GradeChangeEvent <: CanvasObject
    # ID of the event.
    id::Union{String,Nothing}
    # timestamp of the event
    created_at::Union{Dates.DateTime,Nothing}
    # GradeChange event type
    event_type::Union{String,Nothing}
    # Boolean indicating whether the submission was excused after the change.
    excused_after::Union{Bool,Nothing}
    # Boolean indicating whether the submission was excused before the change.
    excused_before::Union{Bool,Nothing}
    # The grade after the change.
    grade_after::Union{String,Nothing}
    # The grade before the change.
    grade_before::Union{String,Nothing}
    # Boolean indicating whether the student name was visible when the grade was given.
    # Could be null if the grade change record was created before this feature existed.
    graded_anonymously::Union{Bool,Nothing}
    # Version Number of the grade change submission.
    version_number::Union{String,Nothing}
    # The unique request id of the request during the grade change.
    request_id::Union{String,Nothing}
    links::Union{GradeChangeEventLinks,Nothing}
end
GradeChangeEvent(data::Dict) = json2canvas(GradeChangeEvent, data)

# Grader
struct Grader <: CanvasObject
    # the user_id of the user who graded the contained submissions
    id::Union{Int,Nothing}
    # the name of the user who graded the contained submissions
    name::Union{String,Nothing}
    # the assignment groups for all submissions in this response that were graded by this
    # user. The details are not nested inside here, but the fact that an assignment is
    # present here means that the grader did grade submissions for this assignment on the
    # contextual date. You can use the id of a grader and of an assignment to make another
    # API call to find all submissions for a grader/assignment combination on a given date.
    assignments::Union{Vector,Nothing}
end
Grader(data::Dict) = json2canvas(Grader, data)

# Day
struct Day <: CanvasObject
    # the date represented by this entry
    date::Union{Dates.DateTime,Nothing}
    # an array of the graders who were responsible for the submissions in this response.
    # the submissions are grouped according to the person who graded them and the assignment
    # they were submitted for.
    graders::Union{Int,Nothing}
end
Day(data::Dict) = json2canvas(Day, data)

# SubmissionVersion
struct SubmissionVersion <: CanvasObject
    # the id of the assignment this submissions is for
    assignment_id::Union{Int,Nothing}
    # the name of the assignment this submission is for
    assignment_name::Union{String,Nothing}
    # the body text of the submission
    body::Union{String,Nothing}
    # the most up to date grade for the current version of this submission
    current_grade::Union{String,Nothing}
    # the latest time stamp for the grading of this submission
    current_graded_at::Union{Dates.DateTime,Nothing}
    # the name of the most recent grader for this submission
    current_grader::Union{String,Nothing}
    # boolean indicating whether the grade is equal to the current submission grade
    grade_matches_current_submission::Union{Bool,Nothing}
    # time stamp for the grading of this version of the submission
    graded_at::Union{Dates.DateTime,Nothing}
    # the name of the user who graded this version of the submission
    grader::Union{String,Nothing}
    # the user id of the user who graded this version of the submission
    grader_id::Union{Int,Nothing}
    # the id of the submission of which this is a version
    id::Union{Int,Nothing}
    # the updated grade provided in this version of the submission
    new_grade::Union{String,Nothing}
    # the timestamp for the grading of this version of the submission (alias for graded_at)
    new_graded_at::Union{Dates.DateTime,Nothing}
    # alias for 'grader'
    new_grader::Union{String,Nothing}
    # the grade for the submission version immediately preceding this one
    previous_grade::Union{String,Nothing}
    # the timestamp for the grading of the submission version immediately preceding this
    # one
    previous_graded_at::Union{Dates.DateTime,Nothing}
    # the name of the grader who graded the version of this submission immediately preceding
    # this one
    previous_grader::Union{String,Nothing}
    # the score for this version of the submission
    score::Union{Int,Nothing}
    # the name of the student who created this submission
    user_name::Union{String,Nothing}
    # the type of submission
    submission_type::Union{String,Nothing}
    # the url of the submission, if there is one
    url::Union{String,Nothing}
    # the user ID of the student who created this submission
    user_id::Union{Int,Nothing}
    # the state of the submission at this version
    workflow_state::Union{String,Nothing}
end
SubmissionVersion(data::Dict) = json2canvas(SubmissionVersion, data)

# SubmissionHistory
struct SubmissionHistory <: CanvasObject
    # the id of the submission
    submission_id::Union{Int,Nothing}
    # an array of all the versions of this submission
    versions::Union{Vector,Nothing}
end
SubmissionHistory(data::Dict) = json2canvas(SubmissionHistory, data)

# GradingSchemeEntry
struct GradingSchemeEntry <: CanvasObject
    # The name for an entry value within a GradingStandard that describes the range of
    # the value
    name::Union{String,Nothing}
    # The value for the name of the entry within a GradingStandard. The entry represents
    # the lower bound of the range for the entry. This range includes the value up to the
    # next entry in the GradingStandard, or 100 if there is no upper bound. The lowest
    # value will have a lower bound range of 0.
    value::Union{Int,Nothing}
end
GradingSchemeEntry(data::Dict) = json2canvas(GradingSchemeEntry, data)

# GradingStandard
struct GradingStandard <: CanvasObject
    # the title of the grading standard
    title::Union{String,Nothing}
    # the id of the grading standard
    id::Union{Int,Nothing}
    # the context this standard is associated with, either 'Account' or 'Course'
    context_type::Union{String,Nothing}
    # the id for the context either the Account or Course id
    context_id::Union{Int,Nothing}
    # A list of GradingSchemeEntry that make up the Grading Standard as an array of values
    # with the scheme name and value
    grading_scheme::Union{Vector,Nothing}
end
GradingStandard(data::Dict) = json2canvas(GradingStandard, data)

# GroupMembership
struct GroupMembership <: CanvasObject
    # The id of the membership object
    id::Union{Int,Nothing}
    # The id of the group object to which the membership belongs
    group_id::Union{Int,Nothing}
    # The id of the user object to which the membership belongs
    user_id::Union{Int,Nothing}
    # The current state of the membership. Current possible values are 'accepted', 'invited',
    # and 'requested'
    workflow_state::Union{String,Nothing}
    # Whether or not the user is a moderator of the group (the must also be an active member
    # of the group to moderate)
    moderator::Union{Bool,Nothing}
    # optional: whether or not the record was just created on a create call (POST), i.e.
    # was the user just added to the group, or was the user already a member
    just_created::Union{Bool,Nothing}
    # The id of the SIS import if created through SIS. Only included if the user has permission
    # to manage SIS information.
    sis_import_id::Union{Int,Nothing}
end
GroupMembership(data::Dict) = json2canvas(GroupMembership, data)



# MigrationIssue
struct MigrationIssue <: CanvasObject
    # the unique identifier for the issue
    id::Union{Int,Nothing}
    # API url to the content migration
    content_migration_url::Union{String,Nothing}
    # Description of the issue for the end-user
    description::Union{String,Nothing}
    # Current state of the issue: active, resolved
    workflow_state::Union{String,Nothing}
    # HTML Url to the Canvas page to investigate the issue
    fix_issue_html_url::Union{String,Nothing}
    # Severity of the issue: todo, warning, error
    issue_type::Union{String,Nothing}
    # Link to a Canvas error report if present (If the requesting user has permissions)
    error_report_html_url::Union{String,Nothing}
    # Site administrator error message (If the requesting user has permissions)
    error_message::Union{String,Nothing}
    # timestamp
    created_at::Union{Dates.DateTime,Nothing}
    # timestamp
    updated_at::Union{Dates.DateTime,Nothing}
end
MigrationIssue(data::Dict) = json2canvas(MigrationIssue, data)

# NotificationPreference
struct NotificationPreference <: CanvasObject
    href::Union{String,Nothing}
    # The notification this preference belongs to
    notification::Union{String,Nothing}
    # The category of that notification
    category::Union{String,Nothing}
    # How often to send notifications to this communication channel for the given notification.
    # Possible values are 'immediately', 'daily', 'weekly', and 'never'
    frequency::Union{String,Nothing}
end
NotificationPreference(data::Dict) = json2canvas(NotificationPreference, data)

# OutcomeImportData
struct OutcomeImportData <: CanvasObject
    # The type of outcome import
    import_type::Union{String,Nothing}
end
OutcomeImportData(data::Dict) = json2canvas(OutcomeImportData, data)

# ProficiencyRating
struct ProficiencyRating <: CanvasObject
    # The description of the rating
    description::Union{String,Nothing}
    # A non-negative number of points for the rating
    points::Union{Float64,Nothing}
    # Indicates the rating where mastery is first achieved
    mastery::Union{Bool,Nothing}
    # The hex color code of the rating
    color::Union{String,Nothing}
end
ProficiencyRating(data::Dict) = json2canvas(ProficiencyRating, data)

# Proficiency
struct Proficiency <: CanvasObject
    # An array of proficiency ratings. See the ProficiencyRating specification above.
    ratings::Union{Vector,Nothing}
end
Proficiency(data::Dict) = json2canvas(Proficiency, data)

# OutcomeResult
struct OutcomeResult <: CanvasObject
    # A unique identifier for this result
    id::Union{Int,Nothing}
    # The student's score
    score::Union{Int,Nothing}
    # The datetime the resulting OutcomeResult was submitted at, or absent that, when it
    # was assessed.
    submitted_or_assessed_at::Union{Dates.DateTime,Nothing}
    # Unique identifiers of objects associated with this result
    links::Union{Dict,Nothing}
    # score's percent of maximum points possible for outcome, scaled to reflect any custom
    # mastery levels that differ from the learning outcome
    percent::Union{Float64,Nothing}
end
OutcomeResult(data::Dict) = json2canvas(OutcomeResult, data)

# OutcomeRollupScoreLinks
struct OutcomeRollupScoreLinks <: CanvasObject
    # The id of the related outcome
    outcome::Union{Int,Nothing}
end
OutcomeRollupScoreLinks(data::Dict) = json2canvas(OutcomeRollupScoreLinks, data)

# OutcomeRollupScore
struct OutcomeRollupScore <: CanvasObject
    # The rollup score for the outcome, based on the student alignment scores related to
    # the outcome. This could be null if the student has no related scores.
    score::Union{Int,Nothing}
    # The number of alignment scores included in this rollup.
    count::Union{Int,Nothing}
    links::Union{OutcomeRollupScoreLinks,Nothing}
end
OutcomeRollupScore(data::Dict) = json2canvas(OutcomeRollupScore, data)

# OutcomeRollupLinks
struct OutcomeRollupLinks <: CanvasObject
    # If an aggregate result was requested, the course field will be present. Otherwise,
    # the user and section field will be present (Optional) The id of the course that this
    # rollup applies to
    course::Union{Int,Nothing}
    # (Optional) The id of the user that this rollup applies to
    user::Union{Int,Nothing}
    # (Optional) The id of the section the user is in
    section::Union{Int,Nothing}
end
OutcomeRollupLinks(data::Dict) = json2canvas(OutcomeRollupLinks, data)

# OutcomeRollup
struct OutcomeRollup <: CanvasObject
    # an array of OutcomeRollupScore objects
    scores::Union{OutcomeRollupScore,Nothing}
    # The name of the resource for this rollup. For example, the user name.
    name::Union{String,Nothing}
    links::Union{OutcomeRollupLinks,Nothing}
end
OutcomeRollup(data::Dict) = json2canvas(OutcomeRollup, data)

# OutcomePathPart
struct OutcomePathPart <: CanvasObject
    # The title of the outcome or outcome group
    name::Union{String,Nothing}
end
OutcomePathPart(data::Dict) = json2canvas(OutcomePathPart, data)

# OutcomePath
struct OutcomePath <: CanvasObject
    # A unique identifier for this outcome
    id::Union{Int,Nothing}
    # an array of OutcomePathPart objects
    parts::Union{OutcomePathPart,Nothing}
end
OutcomePath(data::Dict) = json2canvas(OutcomePath, data)

# Outcome
struct Outcome <: CanvasObject
    # the ID of the outcome
    id::Union{Int,Nothing}
    # the URL for fetching/updating the outcome. should be treated as opaque
    url::Union{String,Nothing}
    # the context owning the outcome. may be null for global outcomes
    context_id::Union{Int,Nothing}
    context_type::Union{String,Nothing}
    # title of the outcome
    title::Union{String,Nothing}
    # Optional friendly name for reporting
    display_name::Union{String,Nothing}
    # description of the outcome. omitted in the abbreviated form.
    description::Union{String,Nothing}
    # A custom GUID for the learning standard.
    vendor_guid::Union{String,Nothing}
    # maximum points possible. included only if the outcome embeds a rubric criterion.
    # omitted in the abbreviated form.
    points_possible::Union{Int,Nothing}
    # points necessary to demonstrate mastery outcomes. included only if the outcome embeds
    # a rubric criterion. omitted in the abbreviated form.
    mastery_points::Union{Int,Nothing}
    # the method used to calculate a students score
    calculation_method::Union{String,Nothing}
    # this defines the variable value used by the calculation_method. included only if
    # calculation_method uses it
    calculation_int::Union{Int,Nothing}
    # possible ratings for this outcome. included only if the outcome embeds a rubric criterion.
    # omitted in the abbreviated form.
    ratings::Union{Vector,Nothing}
    # whether the current user can update the outcome
    can_edit::Union{Bool,Nothing}
    # whether the outcome can be unlinked
    can_unlink::Union{Bool,Nothing}
    # whether this outcome has been used to assess a student
    assessed::Union{Bool,Nothing}
    # whether updates to this outcome will propagate to unassessed rubrics that have imported
    # it
    has_updateable_rubrics::Union{Bool,Nothing}
end
Outcome(data::Dict) = json2canvas(Outcome, data)

# PlannerNote
struct PlannerNote <: CanvasObject
    # The ID of the planner note
    id::Union{Int,Nothing}
    # The title for a planner note
    title::Union{String,Nothing}
    # The description of the planner note
    description::Union{String,Nothing}
    # The id of the associated user creating the planner note
    user_id::Union{Int,Nothing}
    # The current published state of the planner note
    workflow_state::Union{String,Nothing}
    # The course that the note is in relation too, if applicable
    course_id::Union{Int,Nothing}
    # The datetime of when the planner note should show up on their planner
    todo_date::Union{Dates.DateTime,Nothing}
    # the type of the linked learning object
    linked_object_type::Union{String,Nothing}
    # the id of the linked learning object
    linked_object_id::Union{Int,Nothing}
    # the Canvas web URL of the linked learning object
    linked_object_html_url::Union{String,Nothing}
    # the API URL of the linked learning object
    linked_object_url::Union{String,Nothing}
end
PlannerNote(data::Dict) = json2canvas(PlannerNote, data)

# PlannerOverride
struct PlannerOverride <: CanvasObject
    # The ID of the planner override
    id::Union{Int,Nothing}
    # The type of the associated object for the planner override
    plannable_type::Union{String,Nothing}
    # The id of the associated object for the planner override
    plannable_id::Union{Int,Nothing}
    # The id of the associated user for the planner override
    user_id::Union{Int,Nothing}
    # The id of the plannable's associated assignment, if it has one
    assignment_id::Union{Int,Nothing}
    # The current published state of the item, synced with the associated object
    workflow_state::Union{String,Nothing}
    # Controls whether or not the associated plannable item is marked complete on the planner
    marked_complete::Union{Bool,Nothing}
    # Controls whether or not the associated plannable item shows up in the opportunities
    # list
    dismissed::Union{Bool,Nothing}
    # The datetime of when the planner override was created
    created_at::Union{Dates.DateTime,Nothing}
    # The datetime of when the planner override was updated
    updated_at::Union{Dates.DateTime,Nothing}
    # The datetime of when the planner override was deleted, if applicable
    deleted_at::Union{Dates.DateTime,Nothing}
end
PlannerOverride(data::Dict) = json2canvas(PlannerOverride, data)

# Profile
struct Profile <: CanvasObject
    # The ID of the user.
    id::Union{Int,Nothing}
    # Sample User
    name::Union{String,Nothing}
    # Sample User
    short_name::Union{String,Nothing}
    # user, sample
    sortable_name::Union{String,Nothing}
    title::Union{String,Nothing}
    bio::Union{String,Nothing}
    # sample_user@example.com
    primary_email::Union{String,Nothing}
    # sample_user@example.com
    login_id::Union{String,Nothing}
    # sis1
    sis_user_id::Union{String,Nothing}
    lti_user_id::Union{String,Nothing}
    # The avatar_url can change over time, so we recommend not caching it for more than
    # a few hours
    avatar_url::Union{String,Nothing}
    calendar::Union{CalendarLink,Nothing}
    # Optional: This field is only returned in certain API calls, and will return the IANA
    # time zone name of the user's preferred timezone.
    time_zone::Union{String,Nothing}
    # The users locale.
    locale::Union{String,Nothing}
end
Profile(data::Dict) = json2canvas(Profile, data)

# Avatar
struct Avatar <: CanvasObject
    # ['gravatar'|'attachment'|'no_pic'] The type of avatar record, for categorization
    # purposes.
    type::Union{String,Nothing}
    # The url of the avatar
    url::Union{String,Nothing}
    # A unique representation of the avatar record which can be used to set the avatar
    # with the user update endpoint. Note: this is an internal representation and is subject
    # to change without notice. It should be consumed with this api endpoint and used in
    # the user update endpoint, and should not be constructed by the client.
    token::Union{String,Nothing}
    # A textual description of the avatar record.
    display_name::Union{String,Nothing}
    # ['attachment' type only] the internal id of the attachment
    id::Union{Int,Nothing}
    # ['attachment' type only] the content-type of the attachment.
    content_type::Union{String,Nothing}
    # ['attachment' type only] the filename of the attachment
    filename::Union{String,Nothing}
    # ['attachment' type only] the size of the attachment
    size::Union{Int,Nothing}
end
Avatar(data::Dict) = json2canvas(Avatar, data)

# Progress
struct Progress <: CanvasObject
    # the ID of the Progress object
    id::Union{Int,Nothing}
    # the context owning the job.
    context_id::Union{Int,Nothing}
    context_type::Union{String,Nothing}
    # the id of the user who started the job
    user_id::Union{Int,Nothing}
    # the type of operation
    tag::Union{String,Nothing}
    # percent completed
    completion::Union{Int,Nothing}
    # the state of the job one of 'queued', 'running', 'completed', 'failed'
    workflow_state::Union{String,Nothing}
    # the time the job was created
    created_at::Union{Dates.DateTime,Nothing}
    # the time the job was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # optional details about the job
    message::Union{String,Nothing}
    # optional results of the job. omitted when job is still pending
    results::Union{Dict,Nothing}
    # url where a progress update can be retrieved
    url::Union{String,Nothing}
end
Progress(data::Dict) = json2canvas(Progress, data)

# GroupCategory
struct GroupCategory <: CanvasObject
    # The ID of the group category.
    id::Union{Int,Nothing}
    # The display name of the group category.
    name::Union{String,Nothing}
    # Certain types of group categories have special role designations. Currently, these
    # include: 'communities', 'student_organized', and 'imported'. Regular course/account
    # group categories have a role of null.
    role::Union{String,Nothing}
    # If the group category allows users to join a group themselves, thought they may only
    # be a member of one group per group category at a time. Values include 'restricted',
    # 'enabled', and null 'enabled' allows students to assign themselves to a group 'restricted'
    # restricts them to only joining a group in their section null disallows students from
    # joining groups
    self_signup::Union{String,Nothing}
    # Gives instructors the ability to automatically have group leaders assigned. Values
    # include 'random', 'first', and null; 'random' picks a student from the group at random
    # as the leader, 'first' sets the first student to be assigned to the group as the
    # leader
    auto_leader::Union{String,Nothing}
    # The course or account that the category group belongs to. The pattern here is that
    # whatever the context_type is, there will be an _id field named after that type. So
    # if instead context_type was 'Course', the course_id field would be replaced by an
    # course_id field.
    context_type::Union{String,Nothing}
    account_id::Union{Int,Nothing}
    # If self-signup is enabled, group_limit can be set to cap the number of users in each
    # group. If null, there is no limit.
    group_limit::Union{Int,Nothing}
    # The SIS identifier for the group category. This field is only included if the user
    # has permission to manage or view SIS information.
    sis_group_category_id::Union{String,Nothing}
    # The unique identifier for the SIS import. This field is only included if the user
    # has permission to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # If the group category has not yet finished a randomly student assignment request,
    # a progress object will be attached, which will contain information related to the
    # progress of the assignment request. Refer to the Progress API for more information
    progress::Union{Progress,Nothing}
end
GroupCategory(data::Dict) = json2canvas(GroupCategory, data)

# ProvisionalGrade
struct ProvisionalGrade <: CanvasObject
    # The identifier for the provisional grade
    provisional_grade_id::Union{Int,Nothing}
    # The numeric score
    score::Union{Int,Nothing}
    # The grade
    grade::Union{String,Nothing}
    # Whether the grade was applied to the most current submission (false if the student
    # resubmitted after grading)
    grade_matches_current_submission::Union{Bool,Nothing}
    # When the grade was given
    graded_at::Union{Dates.DateTime,Nothing}
    # Whether this is the 'final' provisional grade created by the moderator
    final::Union{Bool,Nothing}
    # A link to view this provisional grade in SpeedGrader™
    speedgrader_url::Union{String,Nothing}
end
ProvisionalGrade(data::Dict) = json2canvas(ProvisionalGrade, data)

# RolePermissions
struct RolePermissions <: CanvasObject
    # Whether the role has the permission
    enabled::Union{Bool,Nothing}
    # Whether the permission is locked by this role
    locked::Union{Bool,Nothing}
    # Whether the permission applies to the account this role is in. Only present if enabled
    # is true
    applies_to_self::Union{Bool,Nothing}
    # Whether the permission cascades down to sub accounts of the account this role is
    # in. Only present if enabled is true
    applies_to_descendants::Union{Bool,Nothing}
    # Whether the permission can be modified in this role (i.e. whether the permission
    # is locked by an upstream role).
    readonly::Union{Bool,Nothing}
    # Whether the value of enabled is specified explicitly by this role, or inherited from
    # an upstream role.
    explicit::Union{Bool,Nothing}
    # The value that would have been inherited from upstream if the role had not explicitly
    # set a value. Only present if explicit is true.
    prior_default::Union{Bool,Nothing}
end
RolePermissions(data::Dict) = json2canvas(RolePermissions, data)

# Role
struct Role <: CanvasObject
    # The label of the role.
    label::Union{String,Nothing}
    # The label of the role. (Deprecated alias for 'label')
    role::Union{String,Nothing}
    # The role type that is being used as a base for this role. For account-level roles,
    # this is 'AccountMembership'. For course-level roles, it is an enrollment type.
    base_role_type::Union{String,Nothing}
    # JSON representation of the account the role is in.
    account::Union{Dict,Nothing}
    # The state of the role: 'active', 'inactive', or 'built_in'
    workflow_state::Union{String,Nothing}
    # A dictionary of permissions keyed by name (see permissions input parameter in the
    # 'Create a role' API).
    permissions::Union{Dict,Nothing}
end
Role(data::Dict) = json2canvas(Role, data)

# Rubric
struct Rubric <: CanvasObject
    # the ID of the rubric
    id::Union{Int,Nothing}
    # title of the rubric
    title::Union{String,Nothing}
    # the context owning the rubric
    context_id::Union{Int,Nothing}
    context_type::Union{String,Nothing}
    points_possible::Union{Int,Nothing}
    reusable::Union{Bool,Nothing}
    read_only::Union{Bool,Nothing}
    # whether or not free-form comments are used
    free_form_criterion_comments::Union{Bool,Nothing}
    hide_score_total::Union{Bool,Nothing}
    # An array with all of this Rubric's grading Criteria
    data::Union{Vector,Nothing}
    # If an assessment type is included in the 'include' parameter, includes an array of
    # rubric assessment objects for a given rubric, based on the assessment type requested.
    # If the user does not request an assessment type this key will be absent.
    assessments::Union{Vector,Nothing}
    # If an association type is included in the 'include' parameter, includes an array
    # of rubric association objects for a given rubric, based on the association type requested.
    # If the user does not request an association type this key will be absent.
    associations::Union{Vector,Nothing}
end
Rubric(data::Dict) = json2canvas(Rubric, data)

# RubricCriterion
struct RubricCriterion <: CanvasObject
    # the ID of the criterion
    id::Union{String,Nothing}
    description::Union{String,Nothing}
    long_description::Union{String,Nothing}
    points::Union{Int,Nothing}
    criterion_use_range::Union{Bool,Nothing}
    # the possible ratings for this Criterion
    ratings::Union{Vector,Nothing}
end
RubricCriterion(data::Dict) = json2canvas(RubricCriterion, data)

# RubricAssessment
struct RubricAssessment <: CanvasObject
    # the ID of the rubric
    id::Union{Int,Nothing}
    # the rubric the assessment belongs to
    rubric_id::Union{Int,Nothing}
    rubric_association_id::Union{Int,Nothing}
    score::Union{Int,Nothing}
    # the object of the assessment
    artifact_type::Union{String,Nothing}
    # the id of the object of the assessment
    artifact_id::Union{Int,Nothing}
    # the current number of attempts made on the object of the assessment
    artifact_attempt::Union{Int,Nothing}
    # the type of assessment. values will be either 'grading', 'peer_review', or 'provisional_grade'
    assessment_type::Union{String,Nothing}
    # user id of the person who made the assessment
    assessor_id::Union{Int,Nothing}
    # (Optional) If 'full' is included in the 'style' parameter, returned assessments will
    # have their full details contained in their data hash. If the user does not request
    # a style, this key will be absent.
    data::Union{Vector,Nothing}
    # (Optional) If 'comments_only' is included in the 'style' parameter, returned assessments
    # will include only the comments portion of their data hash. If the user does not request
    # a style, this key will be absent.
    comments::Union{Vector,Nothing}
end
RubricAssessment(data::Dict) = json2canvas(RubricAssessment, data)

# RubricAssociation
struct RubricAssociation <: CanvasObject
    # the ID of the association
    id::Union{Int,Nothing}
    # the ID of the rubric
    rubric_id::Union{Int,Nothing}
    # the ID of the object this association links to
    association_id::Union{Int,Nothing}
    # the type of object this association links to
    association_type::Union{String,Nothing}
    # Whether or not the associated rubric is used for grade calculation
    use_for_grading::Union{Bool,Nothing}
    summary_data::Union{String,Nothing}
    # Whether or not the association is for grading (and thus linked to an assignment)
    # or if it's to indicate the rubric should appear in its context. Values will be grading
    # or bookmark.
    purpose::Union{String,Nothing}
    # Whether or not the score total is displayed within the rubric. This option is only
    # available if the rubric is not used for grading.
    hide_score_total::Union{Bool,Nothing}
    hide_points::Union{Bool,Nothing}
    hide_outcome_results::Union{Bool,Nothing}
end
RubricAssociation(data::Dict) = json2canvas(RubricAssociation, data)

# Scope
struct Scope <: CanvasObject
    # The resource the scope is associated with
    resource::Union{String,Nothing}
    # The localized resource name
    resource_name::Union{String,Nothing}
    # The controller the scope is associated to
    controller::Union{String,Nothing}
    # The controller action the scope is associated to
    action::Union{String,Nothing}
    # The HTTP verb for the scope
    verb::Union{String,Nothing}
    # The identifier for the scope
    scope::Union{String,Nothing}
end
Scope(data::Dict) = json2canvas(Scope, data)

# SisAssignment
struct SisAssignment <: CanvasObject
    # The unique identifier for the assignment.
    id::Union{Int,Nothing}
    # The unique identifier for the course.
    course_id::Union{Int,Nothing}
    # the name of the assignment
    name::Union{String,Nothing}
    # The time at which this assignment was originally created
    created_at::Union{Dates.DateTime,Nothing}
    # the due date for the assignment. returns null if not present. NOTE: If this assignment
    # has assignment overrides, this field will be the due date as it applies to the user
    # requesting information from the API.
    due_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be unlocked.
    unlock_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be locked.
    lock_at::Union{Dates.DateTime,Nothing}
    # The maximum points possible for the assignment
    points_possible::Union{Int,Nothing}
    # the types of submissions allowed for this assignment list containing one or more
    # of the following: 'discussion_topic', 'online_quiz', 'on_paper', 'none', 'external_tool',
    # 'online_text_entry', 'online_url', 'online_upload' 'media_recording'
    submission_types::Union{Vector,Nothing}
    # Third Party integration id for assignment
    integration_id::Union{String,Nothing}
    # (optional, Third Party integration data for assignment)
    integration_data::Union{String,Nothing}
    # If false, the assignment will be omitted from the student's final grade
    include_in_final_grade::Union{Bool,Nothing}
    # Includes attributes of a assignment_group for convenience. For more details see Assignments
    # API.
    assignment_group::Union{Vector,Nothing}
    # Includes attributes of a section for convenience. For more details see Sections API.
    sections::Union{Vector,Nothing}
    # Includes attributes of a user assignment overrides. For more details see Assignments
    # API.
    user_overrides::Union{Vector,Nothing}
end
SisAssignment(data::Dict) = json2canvas(SisAssignment, data)

# AssignmentGroupAttributes
struct AssignmentGroupAttributes <: CanvasObject
    # the id of the Assignment Group
    id::Union{Int,Nothing}
    # the name of the Assignment Group
    name::Union{String,Nothing}
    # the weight of the Assignment Group
    group_weight::Union{Int,Nothing}
    # the sis source id of the Assignment Group
    sis_source_id::Union{String,Nothing}
    # the integration data of the Assignment Group
    integration_data::Union{Dict,Nothing}
end
AssignmentGroupAttributes(data::Dict) = json2canvas(AssignmentGroupAttributes, data)

# CourseAttributes
struct CourseAttributes <: CanvasObject
    # The unique Canvas identifier for the origin course
    id::Union{Int,Nothing}
    # The name of the origin course.
    name::Union{String,Nothing}
    # The sis id of the origin_course.
    sis_id::Union{String,Nothing}
    # The integration ID of the origin_course.
    integration_id::Union{String,Nothing}
end
CourseAttributes(data::Dict) = json2canvas(CourseAttributes, data)

# SectionAssignmentOverrideAttributes
struct SectionAssignmentOverrideAttributes <: CanvasObject
    # The title for the assignment override
    override_title::Union{String,Nothing}
    # the due date for the assignment. returns null if not present. NOTE: If this assignment
    # has assignment overrides, this field will be the due date as it applies to the user
    # requesting information from the API.
    due_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be unlocked.
    unlock_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be locked.
    lock_at::Union{Dates.DateTime,Nothing}
end
SectionAssignmentOverrideAttributes(data::Dict) = json2canvas(SectionAssignmentOverrideAttributes, data)

# SectionAttributes
struct SectionAttributes <: CanvasObject
    # The unique identifier for the section.
    id::Union{Int,Nothing}
    # The name of the section.
    name::Union{String,Nothing}
    # The sis id of the section.
    sis_id::Union{String,Nothing}
    # Optional: The integration ID of the section.
    integration_id::Union{String,Nothing}
    # The course to which the section belongs or the course from which the section was
    # cross-listed
    origin_course::Union{CourseAttributes,Nothing}
    # Optional: Attributes of the xlist course. Only present when the section has been
    # cross-listed. See Courses API for more details
    xlist_course::Union{CourseAttributes,Nothing}
    # Optional: Attributes of the assignment override that apply to the section. See Assignment
    # API for more details
    override::Union{SectionAssignmentOverrideAttributes,Nothing}
end
SectionAttributes(data::Dict) = json2canvas(SectionAttributes, data)

# UserAssignmentOverrideAttributes
struct UserAssignmentOverrideAttributes <: CanvasObject
    # The unique Canvas identifier for the assignment override
    id::Union{Int,Nothing}
    # The title of the assignment override.
    title::Union{String,Nothing}
    # The time at which this assignment is due
    due_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be unlocked.
    unlock_at::Union{Dates.DateTime,Nothing}
    # (Optional) Time at which this was/will be locked.
    lock_at::Union{Dates.DateTime,Nothing}
    # Includes attributes of a student for convenience. For more details see Users API.
    students::Union{Vector,Nothing}
end
UserAssignmentOverrideAttributes(data::Dict) = json2canvas(UserAssignmentOverrideAttributes, data)

# StudentAttributes
struct StudentAttributes <: CanvasObject
    # The unique Canvas identifier for the user
    user_id::Union{Int,Nothing}
    # The SIS ID associated with the user. This field is only included if the user came
    # from a SIS import and has permissions to view SIS information.
    sis_user_id::Union{String,Nothing}
end
StudentAttributes(data::Dict) = json2canvas(StudentAttributes, data)

# SisImportError
struct SisImportError <: CanvasObject
    # The unique identifier for the SIS import.
    sis_import_id::Union{Int,Nothing}
    # The file where the error message occurred.
    file::Union{String,Nothing}
    # The error message that from the record.
    message::Union{String,Nothing}
    # The contents of the line that had the error.
    row_info::Union{String,Nothing}
    # The line number where the error occurred. Some Importers do not yet support this.
    # This is a 1 based index starting with the header row.
    row::Union{Int,Nothing}
end
SisImportError(data::Dict) = json2canvas(SisImportError, data)

# SisImportStatistic
struct SisImportStatistic <: CanvasObject
    # This is the number of items that were created.
    created::Union{Int,Nothing}
    # This is the number of items that marked as completed. This only applies to courses
    # and enrollments.
    concluded::Union{Int,Nothing}
    # This is the number of Enrollments that were marked as 'inactive'. This only applies
    # to enrollments.
    deactivated::Union{Int,Nothing}
    # This is the number of items that were set to an active state from a completed, inactive,
    # or deleted state.
    restored::Union{Int,Nothing}
    # This is the number of items that were deleted.
    deleted::Union{Int,Nothing}
end
SisImportStatistic(data::Dict) = json2canvas(SisImportStatistic, data)

# SisImportStatistics
struct SisImportStatistics <: CanvasObject
    # This is the total number of items that were changed in the sis import. There are
    # a few caveats that can cause this number to not add up to the individual counts.
    # There are some state changes that happen that have no impact to the object. An example
    # would be changing a course from 'created' to 'claimed'. Both of these would be considered
    # an active course, but would increment this counter. In this example the course would
    # not increment the created or restored counters for course statistic.
    total_state_changes::Union{Int,Nothing}
    # This contains that statistics for accounts.
    Account::Union{SisImportStatistic,Nothing}
    # This contains that statistics for terms.
    EnrollmentTerm::Union{SisImportStatistic,Nothing}
    # This contains that statistics for communication channels. This is an indirect effect
    # from creating or deleting a user.
    CommunicationChannel::Union{SisImportStatistic,Nothing}
    # This contains that statistics for abstract courses.
    AbstractCourse::Union{SisImportStatistic,Nothing}
    # This contains that statistics for courses.
    Course::Union{SisImportStatistic,Nothing}
    # This contains that statistics for course sections.
    CourseSection::Union{SisImportStatistic,Nothing}
    # This contains that statistics for enrollments.
    Enrollment::Union{SisImportStatistic,Nothing}
    # This contains that statistics for group categories.
    GroupCategory::Union{SisImportStatistic,Nothing}
    # This contains that statistics for groups.
    Group::Union{SisImportStatistic,Nothing}
    # This contains that statistics for group memberships. This can be a direct impact
    # from the import or indirect from an enrollment being deleted.
    GroupMembership::Union{SisImportStatistic,Nothing}
    # This contains that statistics for pseudonyms. Pseudonyms are logins for users, and
    # are the object that ties an enrollment to a user. This would be impacted from the
    # user importer.
    Pseudonym::Union{SisImportStatistic,Nothing}
    # This contains that statistics for user observers.
    UserObserver::Union{SisImportStatistic,Nothing}
    # This contains that statistics for account users.
    AccountUser::Union{SisImportStatistic,Nothing}
end
SisImportStatistics(data::Dict) = json2canvas(SisImportStatistics, data)

# SisImportCounts
struct SisImportCounts <: CanvasObject
    accounts::Union{Int,Nothing}
    terms::Union{Int,Nothing}
    abstract_courses::Union{Int,Nothing}
    courses::Union{Int,Nothing}
    sections::Union{Int,Nothing}
    xlists::Union{Int,Nothing}
    users::Union{Int,Nothing}
    enrollments::Union{Int,Nothing}
    groups::Union{Int,Nothing}
    group_memberships::Union{Int,Nothing}
    grade_publishing_results::Union{Int,Nothing}
    # the number of courses that were removed because they were not included in the batch
    # for batch_mode imports. Only included if courses were deleted
    batch_courses_deleted::Union{Int,Nothing}
    # the number of sections that were removed because they were not included in the batch
    # for batch_mode imports. Only included if sections were deleted
    batch_sections_deleted::Union{Int,Nothing}
    # the number of enrollments that were removed because they were not included in the
    # batch for batch_mode imports. Only included if enrollments were deleted
    batch_enrollments_deleted::Union{Int,Nothing}
    error_count::Union{Int,Nothing}
    warning_count::Union{Int,Nothing}
end
SisImportCounts(data::Dict) = json2canvas(SisImportCounts, data)

# SisImportData
struct SisImportData <: CanvasObject
    # The type of SIS import
    import_type::Union{String,Nothing}
    # Which files were included in the SIS import
    supplied_batches::Union{Vector,Nothing}
    # The number of rows processed for each type of import
    counts::Union{SisImportCounts,Nothing}
end
SisImportData(data::Dict) = json2canvas(SisImportData, data)



# AssignmentEvent
struct AssignmentEvent <: CanvasObject
    # A synthetic ID for the assignment
    id::Union{String,Nothing}
    # The title of the assignment
    title::Union{String,Nothing}
    # The due_at timestamp of the assignment
    start_at::Union{Dates.DateTime,Nothing}
    # The due_at timestamp of the assignment
    end_at::Union{Dates.DateTime,Nothing}
    # The HTML description of the assignment
    description::Union{String,Nothing}
    # the context code of the (course) calendar this assignment belongs to
    context_code::Union{String,Nothing}
    # Current state of the assignment ('published' or 'deleted')
    workflow_state::Union{String,Nothing}
    # URL for this assignment (note that updating/deleting should be done via the Assignments
    # API)
    url::Union{String,Nothing}
    # URL for a user to view this assignment
    html_url::Union{String,Nothing}
    # The due date of this assignment
    all_day_date::Union{Dates.DateTime,Nothing}
    # Boolean indicating whether this is an all-day event (e.g. assignment due at midnight)
    all_day::Union{Bool,Nothing}
    # When the assignment was created
    created_at::Union{Dates.DateTime,Nothing}
    # When the assignment was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # The full assignment JSON data (See the Assignments API)
    assignment::Union{Assignment,Nothing}
    # The list of AssignmentOverrides that apply to this event (See the Assignments API).
    # This information is useful for determining which students or sections this assignment-due
    # event applies to.
    assignment_overrides::Union{AssignmentOverride,Nothing}
end
AssignmentEvent(data::Dict) = json2canvas(AssignmentEvent, data)

# MediaComment
struct MediaComment <: CanvasObject
    content_type::Union{String,Nothing}
    display_name::Union{String,Nothing}
    media_id::Union{String,Nothing}
    media_type::Union{String,Nothing}
    url::Union{String,Nothing}
end
MediaComment(data::Dict) = json2canvas(MediaComment, data)

# SubmissionComment
struct SubmissionComment <: CanvasObject
    id::Union{Int,Nothing}
    author_id::Union{Int,Nothing}
    author_name::Union{String,Nothing}
    # Abbreviated user object UserDisplay (see users API).
    author::Union{String,Nothing}
    comment::Union{String,Nothing}
    created_at::Union{Dates.DateTime,Nothing}
    edited_at::Union{Dates.DateTime,Nothing}
    media_comment::Union{MediaComment,Nothing}
end
SubmissionComment(data::Dict) = json2canvas(SubmissionComment, data)

# Tab
struct Tab <: CanvasObject
    html_url::Union{String,Nothing}
    id::Union{String,Nothing}
    label::Union{String,Nothing}
    type::Union{String,Nothing}
    # only included if true
    hidden::Union{Bool,Nothing}
    # possible values are: public, members, admins, and none
    visibility::Union{String,Nothing}
    # 1 based
    position::Union{Int,Nothing}
end
Tab(data::Dict) = json2canvas(Tab, data)

# EnrollmentTerm
struct EnrollmentTerm <: CanvasObject
    # The unique identifier for the enrollment term.
    id::Union{Int,Nothing}
    # The SIS id of the term. Only included if the user has permission to view SIS information.
    sis_term_id::Union{String,Nothing}
    # the unique identifier for the SIS import. This field is only included if the user
    # has permission to manage SIS information.
    sis_import_id::Union{Int,Nothing}
    # The name of the term.
    name::Union{String,Nothing}
    # The datetime of the start of the term.
    start_at::Union{Dates.DateTime,Nothing}
    # The datetime of the end of the term.
    end_at::Union{Dates.DateTime,Nothing}
    # The state of the term. Can be 'active' or 'deleted'.
    workflow_state::Union{String,Nothing}
    # Term date overrides for specific enrollment types
    overrides::Union{Dict,Nothing}
end
EnrollmentTerm(data::Dict) = json2canvas(EnrollmentTerm, data)

# EnrollmentTermsList
struct EnrollmentTermsList <: CanvasObject
    # a paginated list of all terms in the account
    enrollment_terms::Union{Vector,Nothing}
end
EnrollmentTermsList(data::Dict) = json2canvas(EnrollmentTermsList, data)

# UsageRights
struct UsageRights <: CanvasObject
    # Copyright line for the file
    legal_copyright::Union{String,Nothing}
    # Justification for using the file in a Canvas course. Valid values are 'own_copyright',
    # 'public_domain', 'used_by_permission', 'fair_use', 'creative_commons'
    use_justification::Union{String,Nothing}
    # License identifier for the file.
    license::Union{String,Nothing}
    # Readable license name
    license_name::Union{String,Nothing}
    # Explanation of the action performed
    message::Union{String,Nothing}
    # List of ids of files that were updated
    file_ids::Union{Vector,Nothing}
end
UsageRights(data::Dict) = json2canvas(UsageRights, data)

# License
struct License <: CanvasObject
    # a short string identifying the license
    id::Union{String,Nothing}
    # the name of the license
    name::Union{String,Nothing}
    # a link to the license text
    url::Union{String,Nothing}
end
License(data::Dict) = json2canvas(License, data)

# UserDisplay
struct UserDisplay <: CanvasObject
    # The ID of the user.
    id::Union{Int,Nothing}
    # A short name the user has selected, for use in conversations or other less formal
    # places through the site.
    short_name::Union{String,Nothing}
    # If avatars are enabled, this field will be included and contain a url to retrieve
    # the user's avatar.
    avatar_image_url::Union{String,Nothing}
    # URL to access user, either nested to a context or directly.
    html_url::Union{String,Nothing}
end
UserDisplay(data::Dict) = json2canvas(UserDisplay, data)

# AnonymousUserDisplay
struct AnonymousUserDisplay <: CanvasObject
    # A unique short ID identifying this user within the scope of a particular assignment.
    anonymous_id::Union{String,Nothing}
    # A URL to retrieve a generic avatar.
    avatar_image_url::Union{String,Nothing}
end
AnonymousUserDisplay(data::Dict) = json2canvas(AnonymousUserDisplay, data)

# OutcomeImport
struct OutcomeImport <: CanvasObject
    # The unique identifier for the outcome import.
    id::Union{Int,Nothing}
    # The date the outcome import was created.
    created_at::Union{Dates.DateTime,Nothing}
    # The date the outcome import finished. Returns null if not finished.
    ended_at::Union{Dates.DateTime,Nothing}
    # The date the outcome import was last updated.
    updated_at::Union{Dates.DateTime,Nothing}
    # The current state of the outcome import. - 'created': The outcome import has been
    # created. - 'importing': The outcome import is currently processing. - 'succeeded':
    # The outcome import has completed successfully. - 'failed': The outcome import failed.
    workflow_state::Union{String,Nothing}
    # See the OutcomeImportData specification above.
    data::Union{OutcomeImportData,Nothing}
    # The progress of the outcome import.
    progress::Union{String,Nothing}
    # The user that initiated the outcome_import. See the Users API for details.
    user::Union{User,Nothing}
    # An array of row number / error message pairs. Returns the first 25 errors.
    processing_errors::Union{Vector,Nothing}
end
OutcomeImport(data::Dict) = json2canvas(OutcomeImport, data)

# SisImport
struct SisImport <: CanvasObject
    # The unique identifier for the SIS import.
    id::Union{Int,Nothing}
    # The date the SIS import was created.
    created_at::Union{Dates.DateTime,Nothing}
    # The date the SIS import finished. Returns null if not finished.
    ended_at::Union{Dates.DateTime,Nothing}
    # The date the SIS import was last updated.
    updated_at::Union{Dates.DateTime,Nothing}
    # The current state of the SIS import. - 'initializing': The SIS import is being created,
    # if this gets stuck in initializing, it will not import and will continue on to next
    # import. - 'created': The SIS import has been created. - 'importing': The SIS import
    # is currently processing. - 'cleanup_batch': The SIS import is currently cleaning
    # up courses, sections, and enrollments not included in the batch for batch_mode imports.
    # - 'imported': The SIS import has completed successfully. - 'imported_with_messages':
    # The SIS import completed with errors or warnings. - 'aborted': The SIS import was
    # aborted. - 'failed_with_messages': The SIS import failed with errors. - 'failed':
    # The SIS import failed. - 'restoring': The SIS import is restoring states of imported
    # items. - 'partially_restored': The SIS import is restored some of the states of imported
    # items. This is generally due to passing a param like undelete only. - 'restored':
    # The SIS import is restored all of the states of imported items.
    workflow_state::Union{String,Nothing}
    # data
    data::Union{SisImportData,Nothing}
    # statistics
    statistics::Union{SisImportStatistics,Nothing}
    # The progress of the SIS import. The progress will reset when using batch_mode and
    # have a different progress for the cleanup stage
    progress::Union{String,Nothing}
    # The errors_attachment api object of the SIS import. Only available if there are errors
    # or warning and import has completed.
    errors_attachment::Union{File,Nothing}
    # The user that initiated the sis_batch. See the Users API for details.
    user::Union{User,Nothing}
    # Only imports that are complete will get this data. An array of CSV_file/warning_message
    # pairs.
    processing_warnings::Union{Vector,Nothing}
    # An array of CSV_file/error_message pairs.
    processing_errors::Union{Vector,Nothing}
    # Whether the import was run in batch mode.
    batch_mode::Union{Bool,Nothing}
    # The term the batch was limited to.
    batch_mode_term_id::Union{String,Nothing}
    # Enables batch mode against all terms in term file. Requires change_threshold to be
    # set.
    multi_term_batch_mode::Union{Bool,Nothing}
    # When set the import will skip any deletes.
    skip_deletes::Union{Bool,Nothing}
    # Whether UI changes were overridden.
    override_sis_stickiness::Union{Bool,Nothing}
    # Whether stickiness was added to the batch changes.
    add_sis_stickiness::Union{Bool,Nothing}
    # Whether stickiness was cleared.
    clear_sis_stickiness::Union{Bool,Nothing}
    # The identifier of the data set that this SIS batch diffs against
    diffing_data_set_identifier::Union{String,Nothing}
    # The ID of the SIS Import that this import was diffed against
    diffed_against_import_id::Union{Int,Nothing}
    # An array of CSV files for processing
    csv_attachments::Union{Vector,Nothing}
end
SisImport(data::Dict) = json2canvas(SisImport, data)

# WebZipExport
struct WebZipExport <: CanvasObject
    # the unique identifier for the export
    id::Union{Int,Nothing}
    # the date and time this export was requested
    created_at::Union{Dates.DateTime,Nothing}
    # the date and time this export was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # attachment api object for the export web zip (not present until the export completes)
    zip_attachment::Union{File,Nothing}
    # the unique identifier for the progress object
    progress_id::Union{Int,Nothing}
    # The api endpoint for polling the current progress
    progress_url::Union{String,Nothing}
    # The ID of the user who started the export
    user_id::Union{Int,Nothing}
    # The ID of the course the export is for
    course_id::Union{Int,Nothing}
    # The ID of the content export used in the offline export
    content_export_id::Union{Int,Nothing}
    # Current state of the web zip export: created exporting exported generating generated
    # failed
    workflow_state::Union{String,Nothing}
end
WebZipExport(data::Dict) = json2canvas(WebZipExport, data)

# Page
struct Page <: CanvasObject
    # the unique locator for the page
    url::Union{String,Nothing}
    # the title of the page
    title::Union{String,Nothing}
    # the creation date for the page
    created_at::Union{Dates.DateTime,Nothing}
    # the date the page was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # (DEPRECATED) whether this page is hidden from students (note: this is always reflected
    # as the inverse of the published value)
    hide_from_students::Union{Bool,Nothing}
    # roles allowed to edit the page; comma-separated list comprising a combination of
    # 'teachers', 'students', 'members', and/or 'public' if not supplied, course defaults
    # are used
    editing_roles::Union{String,Nothing}
    # the User who last edited the page (this may not be present if the page was imported
    # from another system)
    last_edited_by::Union{User,Nothing}
    # the page content, in HTML (present when requesting a single page; omitted when listing
    # pages)
    body::Union{String,Nothing}
    # whether the page is published (true) or draft state (false).
    published::Union{Bool,Nothing}
    # whether this page is the front page for the wiki
    front_page::Union{Bool,Nothing}
    # Whether or not this is locked for the user.
    locked_for_user::Union{Bool,Nothing}
    # (Optional) Information for the user about the lock. Present when locked_for_user
    # is true.
    lock_info::Union{LockInfo,Nothing}
    # (Optional) An explanation of why this is locked for the user. Present when locked_for_user
    # is true.
    lock_explanation::Union{String,Nothing}
end
Page(data::Dict) = json2canvas(Page, data)

# PageRevision
struct PageRevision <: CanvasObject
    # an identifier for this revision of the page
    revision_id::Union{Int,Nothing}
    # the time when this revision was saved
    updated_at::Union{Dates.DateTime,Nothing}
    # whether this is the latest revision or not
    latest::Union{Bool,Nothing}
    # the User who saved this revision, if applicable (this may not be present if the page
    # was imported from another system)
    edited_by::Union{User,Nothing}
    # the following fields are not included in the index action and may be omitted from
    # the show action via summary=1 the historic url of the page
    url::Union{String,Nothing}
    # the historic page title
    title::Union{String,Nothing}
    # the historic page contents
    body::Union{String,Nothing}
end
PageRevision(data::Dict) = json2canvas(PageRevision, data)

# Bookmark
struct Bookmark <: CanvasObject
    id::Union{Int,Nothing}
    name::Union{String,Nothing}
    url::Union{String,Nothing}
    position::Union{Int,Nothing}
    data::Union{Dict,Nothing}
end
Bookmark(data::Dict) = json2canvas(Bookmark, data)

# CourseQuizExtension
struct CourseQuizExtension <: CanvasObject
    # The ID of the Student that needs the quiz extension.
    user_id::Union{Int,Nothing}
    # Number of times the student is allowed to re-take the quiz over the multiple-attempt
    # limit.
    extra_attempts::Union{Int,Nothing}
    # Amount of extra time allowed for the quiz submission, in minutes.
    extra_time::Union{Int,Nothing}
    # The student can take the quiz even if it's locked for everyone else
    manually_unlocked::Union{Bool,Nothing}
    # The time at which the quiz submission will be overdue, and be flagged as a late submission.
    end_at::Union{String,Nothing}
end
CourseQuizExtension(data::Dict) = json2canvas(CourseQuizExtension, data)

# QuizAssignmentOverrideSetContainer
struct QuizAssignmentOverrideSetContainer <: CanvasObject
    # The QuizAssignmentOverrideSet
    quiz_assignment_overrides::Union{Vector,Nothing}
end
QuizAssignmentOverrideSetContainer(data::Dict) = json2canvas(QuizAssignmentOverrideSetContainer, data)

# QuizAssignmentOverride
struct QuizAssignmentOverride <: CanvasObject
    # ID of the assignment override, unless this is the base construct, in which case the
    # 'id' field is omitted.
    id::Union{Int,Nothing}
    # The date after which any quiz submission is considered late.
    due_at::Union{Dates.DateTime,Nothing}
    # Date when the quiz becomes available for taking.
    unlock_at::Union{Dates.DateTime,Nothing}
    # When the quiz will stop being available for taking. A value of null means it can
    # always be taken.
    lock_at::Union{Dates.DateTime,Nothing}
    # Title of the section this assignment override is for, if any.
    title::Union{String,Nothing}
    # If this property is present, it means that dates in this structure are not based
    # on an assignment override, but are instead for all students.
    base::Union{Bool,Nothing}
end
QuizAssignmentOverride(data::Dict) = json2canvas(QuizAssignmentOverride, data)

# QuizAssignmentOverrideSet
struct QuizAssignmentOverrideSet <: CanvasObject
    # ID of the quiz those dates are for.
    quiz_id::Union{String,Nothing}
    # An array of quiz assignment overrides. For students, this array will always contain
    # a single item which is the set of dates that apply to that student. For teachers
    # and staff, it may contain more.
    due_dates::Union{QuizAssignmentOverride,Nothing}
    # An array of all assignment overrides active for the quiz. This is visible only to
    # teachers and staff.
    all_dates::Union{QuizAssignmentOverride,Nothing}
end
QuizAssignmentOverrideSet(data::Dict) = json2canvas(QuizAssignmentOverrideSet, data)

# QuizExtension
struct QuizExtension <: CanvasObject
    # The ID of the Quiz the quiz extension belongs to.
    quiz_id::Union{Int,Nothing}
    # The ID of the Student that needs the quiz extension.
    user_id::Union{Int,Nothing}
    # Number of times the student is allowed to re-take the quiz over the multiple-attempt
    # limit.
    extra_attempts::Union{Int,Nothing}
    # Amount of extra time allowed for the quiz submission, in minutes.
    extra_time::Union{Int,Nothing}
    # The student can take the quiz even if it's locked for everyone else
    manually_unlocked::Union{Bool,Nothing}
    # The time at which the quiz submission will be overdue, and be flagged as a late submission.
    end_at::Union{String,Nothing}
end
QuizExtension(data::Dict) = json2canvas(QuizExtension, data)

# QuizGroup
struct QuizGroup <: CanvasObject
    # The ID of the question group.
    id::Union{Int,Nothing}
    # The ID of the Quiz the question group belongs to.
    quiz_id::Union{Int,Nothing}
    # The name of the question group.
    name::Union{String,Nothing}
    # The number of questions to pick from the group to display to the student.
    pick_count::Union{Int,Nothing}
    # The amount of points allotted to each question in the group.
    question_points::Union{Int,Nothing}
    # The ID of the Assessment question bank to pull questions from.
    assessment_question_bank_id::Union{Int,Nothing}
    # The order in which the question group will be retrieved and displayed.
    position::Union{Int,Nothing}
end
QuizGroup(data::Dict) = json2canvas(QuizGroup, data)

# QuizIPFilter
struct QuizIPFilter <: CanvasObject
    # A unique name for the filter.
    name::Union{String,Nothing}
    # Name of the Account (or Quiz) the IP filter is defined in.
    account::Union{String,Nothing}
    # An IP address (or range mask) this filter embodies.
    filter::Union{String,Nothing}
end
QuizIPFilter(data::Dict) = json2canvas(QuizIPFilter, data)

# QuizReport
struct QuizReport <: CanvasObject
    # the ID of the quiz report
    id::Union{Int,Nothing}
    # the ID of the quiz
    quiz_id::Union{Int,Nothing}
    # which type of report this is possible values: 'student_analysis', 'item_analysis'
    report_type::Union{String,Nothing}
    # a human-readable (and localized) version of the report_type
    readable_type::Union{String,Nothing}
    # boolean indicating whether the report represents all submissions or only the most
    # recent ones for each student
    includes_all_versions::Union{Bool,Nothing}
    # boolean indicating whether the report is for an anonymous survey. if true, no student
    # names will be included in the csv
    anonymous::Union{Bool,Nothing}
    # boolean indicating whether the report can be generated, which is true unless the
    # quiz is a survey one
    generatable::Union{Bool,Nothing}
    # when the report was created
    created_at::Union{Dates.DateTime,Nothing}
    # when the report was last updated
    updated_at::Union{Dates.DateTime,Nothing}
    # the API endpoint for this report
    url::Union{String,Nothing}
    # if the report has finished generating, a File object that represents it. refer to
    # the Files API for more information about the format
    file::Union{File,Nothing}
    # if the report has not yet finished generating, a URL where information about its
    # progress can be retrieved. refer to the Progress API for more information (Note:
    # not available in JSON-API format)
    progress_url::Union{String,Nothing}
    # if the report is being generated, a Progress object that represents the operation.
    # Refer to the Progress API for more information about the format. (Note: available
    # only in JSON-API format)
    progress::Union{Progress,Nothing}
end
QuizReport(data::Dict) = json2canvas(QuizReport, data)

# QuizStatisticsLinks
struct QuizStatisticsLinks <: CanvasObject
    # HTTP/HTTPS API URL to the quiz this statistics describe.
    quiz::Union{String,Nothing}
end
QuizStatisticsLinks(data::Dict) = json2canvas(QuizStatisticsLinks, data)

# QuizStatisticsAnswerStatistics
struct QuizStatisticsAnswerStatistics <: CanvasObject
    # ID of the answer.
    id::Union{Int,Nothing}
    # The text attached to the answer.
    text::Union{String,Nothing}
    # An integer to determine correctness of the answer. Incorrect answers should be 0,
    # correct answers should be non-negative.
    weight::Union{Int,Nothing}
    # Number of students who have chosen this answer.
    responses::Union{Int,Nothing}
end
QuizStatisticsAnswerStatistics(data::Dict) = json2canvas(QuizStatisticsAnswerStatistics, data)

# QuizStatisticsQuestionStatistics
struct QuizStatisticsQuestionStatistics <: CanvasObject
    # Number of students who have provided an answer to this question. Blank or empty responses
    # are not counted.
    responses::Union{Int,Nothing}
    # Statistics related to each individual pre-defined answer.
    answers::Union{QuizStatisticsAnswerStatistics,Nothing}
end
QuizStatisticsQuestionStatistics(data::Dict) = json2canvas(QuizStatisticsQuestionStatistics, data)

# QuizStatisticsAnswerPointBiserial
struct QuizStatisticsAnswerPointBiserial <: CanvasObject
    # ID of the answer the point biserial is for.
    answer_id::Union{Int,Nothing}
    # The point biserial value for this answer. Value ranges between -1 and 1.
    point_biserial::Union{Float64,Nothing}
    # Convenience attribute that denotes whether this is the correct answer as opposed
    # to being a distractor. This is mutually exclusive with the `distractor` value
    correct::Union{Bool,Nothing}
    # Convenience attribute that denotes whether this is a distractor answer and not the
    # correct one. This is mutually exclusive with the `correct` value
    distractor::Union{Bool,Nothing}
end
QuizStatisticsAnswerPointBiserial(data::Dict) = json2canvas(QuizStatisticsAnswerPointBiserial, data)

# QuizStatisticsSubmissionStatistics
struct QuizStatisticsSubmissionStatistics <: CanvasObject
    # The number of students who have taken the quiz.
    unique_count::Union{Int,Nothing}
    # The mean of the student submission scores.
    score_average::Union{Float64,Nothing}
    # The highest submission score.
    score_high::Union{Float64,Nothing}
    # The lowest submission score.
    score_low::Union{Float64,Nothing}
    # Standard deviation of the submission scores.
    score_stdev::Union{Float64,Nothing}
    # A percentile distribution of the student scores, each key is the percentile (ranges
    # between 0 and 100%) while the value is the number of students who received that score.
    scores::Union{Dict,Nothing}
    # The mean of the number of questions answered correctly by each student.
    correct_count_average::Union{Float64,Nothing}
    # The mean of the number of questions answered incorrectly by each student.
    incorrect_count_average::Union{Float64,Nothing}
    # The average time spent by students while taking the quiz.
    duration_average::Union{Float64,Nothing}
end
QuizStatisticsSubmissionStatistics(data::Dict) = json2canvas(QuizStatisticsSubmissionStatistics, data)

# QuizStatistics
struct QuizStatistics <: CanvasObject
    # The ID of the quiz statistics report.
    id::Union{Int,Nothing}
    # The ID of the Quiz the statistics report is for. NOTE: AVAILABLE ONLY IN NON-JSON-API
    # REQUESTS.
    quiz_id::Union{Int,Nothing}
    # Whether there are any students that have made mutliple submissions for this quiz.
    multiple_attempts_exist::Union{Bool,Nothing}
    # In the presence of multiple attempts, this field describes whether the statistics
    # describe all the submission attempts and not only the latest ones.
    includes_all_versions::Union{Bool,Nothing}
    # The time at which the statistics were generated, which is usually after the occurrence
    # of a quiz event, like a student submitting it.
    generated_at::Union{Dates.DateTime,Nothing}
    # The API HTTP/HTTPS URL to this quiz statistics.
    url::Union{String,Nothing}
    # The HTTP/HTTPS URL to the page where the statistics can be seen visually.
    html_url::Union{String,Nothing}
    # Question-specific statistics for each question and its answers.
    question_statistics::Union{QuizStatisticsQuestionStatistics,Nothing}
    # Question-specific statistics for each question and its answers.
    submission_statistics::Union{QuizStatisticsSubmissionStatistics,Nothing}
    # JSON-API construct that contains links to media related to this quiz statistics object.
    # NOTE: AVAILABLE ONLY IN JSON-API REQUESTS.
    links::Union{QuizStatisticsLinks,Nothing}
end
QuizStatistics(data::Dict) = json2canvas(QuizStatistics, data)

# QuizSubmissionEvent
struct QuizSubmissionEvent <: CanvasObject
    # a timestamp record of creation time
    created_at::Union{Dates.DateTime,Nothing}
    # the type of event being sent
    event_type::Union{String,Nothing}
    # custom contextual data for the specific event type
    event_data::Union{Dict,Nothing}
end
QuizSubmissionEvent(data::Dict) = json2canvas(QuizSubmissionEvent, data)

# QuizSubmissionQuestion
struct QuizSubmissionQuestion <: CanvasObject
    # The ID of the QuizQuestion this answer is for.
    id::Union{Int,Nothing}
    # Whether this question is flagged.
    flagged::Union{Bool,Nothing}
    # The provided answer (if any) for this question. The format of this parameter depends
    # on the type of the question, see the Appendix for more information.
    answer::Union{String,Nothing}
    # The possible answers for this question when those possible answers are necessary.
    # The presence of this parameter is dependent on permissions.
    answers::Union{Vector,Nothing}
end
QuizSubmissionQuestion(data::Dict) = json2canvas(QuizSubmissionQuestion, data)

# QuizSubmission
struct QuizSubmission <: CanvasObject
    # The ID of the quiz submission.
    id::Union{Int,Nothing}
    # The ID of the Quiz the quiz submission belongs to.
    quiz_id::Union{Int,Nothing}
    # The ID of the Student that made the quiz submission.
    user_id::Union{Int,Nothing}
    # The ID of the Submission the quiz submission represents.
    submission_id::Union{Int,Nothing}
    # The time at which the student started the quiz submission.
    started_at::Union{String,Nothing}
    # The time at which the student submitted the quiz submission.
    finished_at::Union{String,Nothing}
    # The time at which the quiz submission will be overdue, and be flagged as a late submission.
    end_at::Union{String,Nothing}
    # For quizzes that allow multiple attempts, this field specifies the quiz submission
    # attempt number.
    attempt::Union{Int,Nothing}
    # Number of times the student was allowed to re-take the quiz over the multiple-attempt
    # limit.
    extra_attempts::Union{Int,Nothing}
    # Amount of extra time allowed for the quiz submission, in minutes.
    extra_time::Union{Int,Nothing}
    # The student can take the quiz even if it's locked for everyone else
    manually_unlocked::Union{Bool,Nothing}
    # Amount of time spent, in seconds.
    time_spent::Union{Int,Nothing}
    # The score of the quiz submission, if graded.
    score::Union{Int,Nothing}
    # The original score of the quiz submission prior to any re-grading.
    score_before_regrade::Union{Int,Nothing}
    # For quizzes that allow multiple attempts, this is the score that will be used, which
    # might be the score of the latest, or the highest, quiz submission.
    kept_score::Union{Int,Nothing}
    # Number of points the quiz submission's score was fudged by.
    fudge_points::Union{Int,Nothing}
    # Whether the student has viewed their results to the quiz.
    has_seen_results::Union{Bool,Nothing}
    # The current state of the quiz submission. Possible values: ['untaken'|'pending_review'|'complete'|'settings_only'|'preview'].
    workflow_state::Union{String,Nothing}
    # Indicates whether the quiz submission is overdue and needs submission
    overdue_and_needs_submission::Union{Bool,Nothing}
end
QuizSubmission(data::Dict) = json2canvas(QuizSubmission, data)

# QuizPermissions
struct QuizPermissions <: CanvasObject
    # whether the user can view the quiz
    read::Union{Bool,Nothing}
    # whether the user may submit a submission for the quiz
    submit::Union{Bool,Nothing}
    # whether the user may create a new quiz
    create::Union{Bool,Nothing}
    # whether the user may edit, update, or delete the quiz
    manage::Union{Bool,Nothing}
    # whether the user may view quiz statistics for this quiz
    read_statistics::Union{Bool,Nothing}
    # whether the user may review grades for all quiz submissions for this quiz
    review_grades::Union{Bool,Nothing}
    # whether the user may update the quiz
    update::Union{Bool,Nothing}
end
QuizPermissions(data::Dict) = json2canvas(QuizPermissions, data)

# Quiz
struct Quiz <: CanvasObject
    # the ID of the quiz
    id::Union{Int,Nothing}
    # the title of the quiz
    title::Union{String,Nothing}
    # the HTTP/HTTPS URL to the quiz
    html_url::Union{String,Nothing}
    # a url suitable for loading the quiz in a mobile webview. it will persiste the headless
    # session and, for quizzes in public courses, will force the user to login
    mobile_url::Union{String,Nothing}
    # A url that can be visited in the browser with a POST request to preview a quiz as
    # the teacher. Only present when the user may grade
    preview_url::Union{String,Nothing}
    # the description of the quiz
    description::Union{String,Nothing}
    # type of quiz possible values: 'practice_quiz', 'assignment', 'graded_survey', 'survey'
    quiz_type::Union{String,Nothing}
    # the ID of the quiz's assignment group:
    assignment_group_id::Union{Int,Nothing}
    # quiz time limit in minutes
    time_limit::Union{Int,Nothing}
    # shuffle answers for students?
    shuffle_answers::Union{Bool,Nothing}
    # let students see their quiz responses? possible values: null, 'always', 'until_after_last_attempt'
    hide_results::Union{String,Nothing}
    # show which answers were correct when results are shown? only valid if hide_results=null
    show_correct_answers::Union{Bool,Nothing}
    # restrict the show_correct_answers option above to apply only to the last submitted
    # attempt of a quiz that allows multiple attempts. only valid if show_correct_answers=true
    # and allowed_attempts > 1
    show_correct_answers_last_attempt::Union{Bool,Nothing}
    # when should the correct answers be visible by students? only valid if show_correct_answers=true
    show_correct_answers_at::Union{Dates.DateTime,Nothing}
    # prevent the students from seeing correct answers after the specified date has passed.
    # only valid if show_correct_answers=true
    hide_correct_answers_at::Union{Dates.DateTime,Nothing}
    # prevent the students from seeing their results more than once (right after they submit
    # the quiz)
    one_time_results::Union{Bool,Nothing}
    # which quiz score to keep (only if allowed_attempts != 1) possible values: 'keep_highest',
    # 'keep_latest'
    scoring_policy::Union{String,Nothing}
    # how many times a student can take the quiz -1 = unlimited attempts
    allowed_attempts::Union{Int,Nothing}
    # show one question at a time?
    one_question_at_a_time::Union{Bool,Nothing}
    # the number of questions in the quiz
    question_count::Union{Int,Nothing}
    # The total point value given to the quiz
    points_possible::Union{Int,Nothing}
    # lock questions after answering? only valid if one_question_at_a_time=true
    cant_go_back::Union{Bool,Nothing}
    # access code to restrict quiz access
    access_code::Union{String,Nothing}
    # IP address or range that quiz access is limited to
    ip_filter::Union{String,Nothing}
    # when the quiz is due
    due_at::Union{Dates.DateTime,Nothing}
    # when to lock the quiz
    lock_at::Union{Dates.DateTime,Nothing}
    # when to unlock the quiz
    unlock_at::Union{Dates.DateTime,Nothing}
    # whether the quiz has a published or unpublished draft state.
    published::Union{Bool,Nothing}
    # Whether the assignment's 'published' state can be changed to false. Will be false
    # if there are student submissions for the quiz.
    unpublishable::Union{Bool,Nothing}
    # Whether or not this is locked for the user.
    locked_for_user::Union{Bool,Nothing}
    # (Optional) Information for the user about the lock. Present when locked_for_user
    # is true.
    lock_info::Union{LockInfo,Nothing}
    # (Optional) An explanation of why this is locked for the user. Present when locked_for_user
    # is true.
    lock_explanation::Union{String,Nothing}
    # Link to Speed Grader for this quiz. Will not be present if quiz is unpublished
    speedgrader_url::Union{String,Nothing}
    # Link to endpoint to send extensions for this quiz.
    quiz_extensions_url::Union{String,Nothing}
    # Permissions the user has for the quiz
    permissions::Union{QuizPermissions,Nothing}
    # list of due dates for the quiz
    all_dates::Union{Vector,Nothing}
    # Current version number of the quiz
    version_number::Union{Int,Nothing}
    # List of question types in the quiz
    question_types::Union{Vector,Nothing}
    # Whether survey submissions will be kept anonymous (only applicable to 'graded_survey',
    # 'survey' quiz types)
    anonymous_submissions::Union{Bool,Nothing}
end
Quiz(data::Dict) = json2canvas(Quiz, data)

