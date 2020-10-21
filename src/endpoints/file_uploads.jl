# 3-step file upload as documenter here: https://canvas.instructure.com/doc/api/file.file_uploads
function Internals.upload_file(endpoint::String, file; api::CanvasAPI=getapi(), params::Dict=Dict{String,Any}(), kwargs...)
    params = Dict{String,Any}(
        "name" => basename(file),
        "size" => stat(file).size,
        params...
    )

    # Step 1: Telling Canvas about the file upload and getting a token
    json = request("POST", endpoint; api=api, params=params, kwargs...)

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
