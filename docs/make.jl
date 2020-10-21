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
        "API Reference" => joinpath.("endpoints", [
            "assignments.md",
            "courses.md",
            "files.md",
        ])
    ]
)

deploydocs(
    repo = "github.com/fredrikekre/Canvas.jl.git",
)
