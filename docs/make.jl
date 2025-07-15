using Cim
using Documenter, DocumenterCitations
using Literate

DocMeta.setdocmeta!(Cim, :DocTestSetup, :(using Cim); recursive=true)

bib = CitationBibliography(joinpath(@__DIR__, "src", "refs.bib");style=:numeric)

# Generate examples by Literate.jl
function generate_examples(source_dir, output_dir; exclude=[])
    for file in readdir(source_dir)
        if endswith(file, ".jl") && !(file in exclude)
            input = joinpath(source_dir, file)
            output = output_dir
            Literate.markdown(input, output; documenter=true)
        end
    end
end

source = joinpath(@__DIR__, "src", "literate")
output = joinpath(@__DIR__, "src")
generate_examples(source, output)

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
        "Tutorials" => ["eigenvibrations.md", "utrecht1331.md"],
        "API" => "api.md",
        "References" => "references.md",
    ],
    plugins = [bib],
)

deploydocs(;
    repo="github.com/peakfind/Cim.jl",
    devbranch="main",
)
