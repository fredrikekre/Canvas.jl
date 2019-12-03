using Documenter
using Canvas

makedocs(
    format = Documenter.HTML(
        prettyurls = haskey(ENV, "GITHUB_ACTIONS"),

    ),
    modules = [Canvas],
    sitename = "Canvas.jl",
    pages = Any[
        "index.md",
    ]
)

deploydocs(
    repo = "github.com/fredrikekre/Canvas.jl.git",
)
