using Cim
using Documenter, DocumenterCitations
using Literate

DocMeta.setdocmeta!(Cim, :DocTestSetup, :(using Cim); recursive=true)

source_path = joinpath(@__DIR__, "src", "literate", "eigenvibrations.jl")
output_path = joinpath(@__DIR__, "src")
Literate.markdown(source_path, output_path)

bib = CitationBibliography(joinpath(@__DIR__, "src", "refs.bib"))

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
        "Contours and Quadrature Rules" => "contour.md",
        "Tutorials" => "eigenvibrations.md",
        "API" => "api.md",
    ],
    plugins = [bib],
)

deploydocs(;
    repo="github.com/peakfind/Cim.jl",
    devbranch="main",
)
