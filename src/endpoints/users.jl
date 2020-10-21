# This file roughly corresponds to functions documented in the
# Users API: https://canvas.instructure.com/doc/api/users

# Note: This method does not map directly to an Canvas API endpoint
"""
    Canvas.whoami(; kwargs...) -> User

Return the details about the authenticated users. Return a [`User`](@ref).

**Canvas API documentation**:
[Show user details (`GET /api/v1/users/self`)]
(https://canvas.instructure.com/doc/api/users#method.users.api_show)
"""
function whoami(; kwargs...)
    json = request("GET", "/api/v1/users/self"; kwargs...)
    return User(json)
end

"""
    Canvas.user(u::User; kwargs...) -> User

Return the details about the a user specified by id.
Return a [`User`](@ref).

**Canvas API documentation**:
[Show user details (`GET /api/v1/users/:id`)]
(https://canvas.instructure.com/doc/api/users#method.users.api_show)
"""
function user(u::User; kwargs...)
    json = request("GET", "/api/v1$(Internals.pid(u))"; kwargs...)
    return User(json)
end
