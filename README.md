# Canvas.jl

Canvas.jl is a Julia package for interacting with the [Canvas LMS REST API][canvas-api].

## Overview


## Authentication

In order to access the Canvas API you need to generate an access token. This is
done from your user settings.

```julia
auth = Canvas.OAuth2(ENV["CANVAS_TOKEN"])
api = Canvas.CanvasAPI("https://yourinstitution.instructure.com/"; auth=auth)
```

[canvas-api]: https://canvas.instructure.com/doc/api/
