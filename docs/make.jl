using Documenter
using Canvas

makedocs(
    format = Documenter.HTML(
        prettyurls = false,
    ),
    modules = [Canvas],
    sitename = "Canvas.jl",
    pages = Any[
        "index.md",
        "API Reference" => [
            "assignments.md",
            "courses.md",
            "files.md",
        ]
    ]
)

deploydocs(
    repo = "github.com/fredrikekre/Canvas.jl.git",
)
