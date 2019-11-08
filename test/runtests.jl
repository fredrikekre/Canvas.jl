import Canvas, HTTP, JSON, Test

import Revise, Canvas
auth=Canvas.OAuth2(ENV["CANVAS_TOKEN"])
api = Canvas.CanvasAPI(ENV["CANVAS_API"]; auth=auth)
Canvas.setapi!(api)


cs, pd = Canvas.courses()
c = cs[1]
@assert c.id == 7609


c′ = Canvas.course(c)
c′′ = Canvas.course(7609)
c = Canvas.course(7609; query=Dict("include[]"=>["permissions"]))



fs, pd = Canvas.files(7609)
