module CimMakieExt

import Cim
using CairoMakie: lines!, scatter!
    
"""
    show_contour!(ax, ctr::Cim.ellipse)

Plot the contour `ctr::ellipse` on Axis `ax` by using `CairoMakie`.
"""
function Cim.show_contour!(ax, ctr::Cim.ellipse)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.semi_x*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.semi_y*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

"""
    show_contour!(ax, ctr::Cim.circle)

Plot the contour `ctr::circle` on Axis `ax` by using `CairoMakie`.
"""
function Cim.show_contour!(ax, ctr::Cim.circle)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.radius*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.radius*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

"""
    show_quadpts!(ax, pts::Cim.quadpts)

Plot the quadrature points `pts` on Axis `ax` by using `CairoMakie`.
"""
function Cim.show_quadpts!(ax, pts::Cim.quadpts)
    scatter!(ax, pts.nodes[:,1], pts.nodes[:,2])
end

"""
    show_eigenvalues(ax, eigvals::AbstractArray)

Plot the eigenvalues on complex plane on Axis `ax` by using `CairoMakie`.
"""
function Cim.show_eigenvalues!(ax, eigvals::AbstractArray)
    scatter!(ax, real(eigvals), imag(eigvals), marker = :cross, color = :red)
end

end