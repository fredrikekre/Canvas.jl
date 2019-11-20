
"""
    Canvas.upload_file(course::Course, file; kwargs...) -> Vector{Course}, page_data

Request endpoint: `POST /api/v1/courses/:course_id/files `.

See [Upload a file](https://canvas.instructure.com/doc/api/courses.html#method.courses.create_file)
for more information and available request parameters.
"""
function upload_file(c, file; api::CanvasAPI=getapi(), params::Dict=Dict{String,Any}(), kwargs...)
    params = Dict{String,Any}(
        "name"=>basename(file),
        "size"=>stat(file).size,
        params...
    )

    # Step 1: Telling Canvas about the file upload and getting a token
    json = request("POST", "/api/v1/courses/$(id(c))/files"; api=api, params=params, kwargs...)

    # Step 2: Upload the file data to the URL given in the previous response
    uri = HTTP.URI(json["upload_url"])
    req = open(file, "r") do io
        body = collect(json["upload_params"])
        push!(body, "file"=>io) # file must be last argument
        form = HTTP.Form(body)
        headers = canvas_headers(; auth=nothing) # should not be authenticated
        return HTTP.request("POST", uri, headers, form)
    end

    # Step 3: Confirm the upload's success
    if HTTP.isredirect(req)
        # 3XX Redirect
        loc = HTTP.header(req, "Location")
        json = request("GET", loc; api=api) # Should be authenticated
    else # req.status == 201
        # 201 Created
        json = JSON.parse(HTTP.payload(req, String))
    end
    return File(json)
end
