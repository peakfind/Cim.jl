module Cim

using LinearAlgebra
using SparseArrays
using CairoMakie

include("nep.jl")
export Qep

include("contour.jl")
export get_quadpts
export show_contour!, show_quadpts!, show_eigenvalues!

include("contour_int.jl")
export cim, contr_int_ho

include("utils.jl")

end
