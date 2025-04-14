using Cim
using Documenter

DocMeta.setdocmeta!(Cim, :DocTestSetup, :(using Cim); recursive=true)

makedocs(;
    modules=[Cim],
    authors="Jiayi Zhang",
    sitename="Cim.jl",
    format=Documenter.HTML(;
        canonical="https://peakfind.github.io/Cim.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/peakfind/Cim.jl",
    devbranch="main",
)
