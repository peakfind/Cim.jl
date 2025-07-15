module Cim

using LinearAlgebra
using SparseArrays
using CairoMakie
using Printf

include("nep.jl")
export Qep

include("contour.jl")
export get_quadpts
export show_contour!, show_quadpts!, show_eigenvalues!

include("contour_int.jl")
export cim, hcim

include("utils.jl")

end
