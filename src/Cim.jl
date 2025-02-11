module Cim

using LinearAlgebra
using CairoMakie

export get_quadpts
export contr_int, contr_int_ho

include("contour.jl")
include("contour_int.jl")

end
