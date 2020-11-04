using Documenter
using Canvas

makedocs(
    format = Documenter.HTML(
        canonical = "https://fredrikekre.github.io/Canvas.jl/v1",
        prettyurls = true,
    ),
    modules = [Canvas],
    sitename = "Canvas.jl",
    pages = Any[
        "index.md",
        "API Reference" => joinpath.("endpoints", [
            "courses.md",
            "assignments.md",
            "submissions.md",
            "submission_comments.md",
            "files.md",
            "users.md",
            "tabs.md",
        ])
    ]
)

deploydocs(
    repo = "github.com/fredrikekre/Canvas.jl.git",
    push_preview=true,
)
