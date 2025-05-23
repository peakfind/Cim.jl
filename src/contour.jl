"""
contours that we plan to support:
     1. ellipse
     2. circle
     3. rectangle (not supported yet)
"""
abstract type AbstractContour end

struct ellipse <: AbstractContour
    center::Vector{Float64} 
    semi_x::Float64
    semi_y::Float64
end

struct rectangle <: AbstractContour
    center::Vector{Float64}
    semi_x::Float64
    semi_y::Float64
end

struct circle <: AbstractContour
    center::Vector{Float64}
    radius::Float64
end

"""
    quadpts

Quadrature points of the trapezoidal rule on the contours.

# Properties

- `N`: the number of the quadrature nodes
- `nodes`: quadrature nodes size of N x 2 
- `nodes_prime`: derivative of the parametrization size of N x 2
"""
struct quadpts
    N::Int64                     
    nodes::Matrix{Float64}       
    nodes_prime::Matrix{Float64}
end

"""
    get_quadpts(ctr::ellipse, num_quadpts::Int64) 
    get_quadpts(ctr::circle, num_quadpts::Int64)
    
Get the quadrature points on the contour (ellipse or circle) `ctr`. Here we use the composite trapezoidal rule.

# Arguments

- `ctr`: the contour that we discretize
- `num_quadpts`: the number of the quadrature nodes
"""
function get_quadpts(ctr::ellipse, num_quadpts::Int64)
    nodes = zeros(num_quadpts, 2)
    nodes_prime = zeros(num_quadpts, 2)
    δ = 2π / (num_quadpts - 1)

    for i = 0:num_quadpts - 1
        nodes[i + 1, 1] = ctr.center[1] + ctr.semi_x * cos(δ * i)
        nodes[i + 1, 2] = ctr.center[2] + ctr.semi_y * sin(δ * i)
        nodes_prime[i + 1, 1] = -ctr.semi_x * sin(δ * i)
        nodes_prime[i + 1, 2] = ctr.semi_y * cos(δ * i)
    end

    return quadpts(num_quadpts, nodes, nodes_prime)
end
    
function get_quadpts(ctr::circle, num_quadpts::Int64)
    nodes = zeros(num_quadpts, 2)
    nodes_prime = zeros(num_quadpts, 2)
    δ = 2π / (num_quadpts - 1)

    for i = 0:num_quadpts - 1
        nodes[i + 1, 1] = ctr.center[1] + ctr.radius * cos(δ * i) 
        nodes[i + 1, 2] = ctr.center[2] + ctr.radius * sin(δ * i)
        nodes_prime[i + 1, 1] = -ctr.radius * sin(δ * i)
        nodes_prime[i + 1, 2] = ctr.radius * cos(δ * i)
    end

    return quadpts(num_quadpts, nodes, nodes_prime)
end

"""
    show_contour!(ax, ctr::ellipse)

Plot the contour `ctr::ellipse` on Axis `ax` by using `CairoMakie`.
"""
function show_contour!(ax, ctr::ellipse)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.semi_x*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.semi_y*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

"""
    show_contour!(ax, ctr::circle)

Plot the contour `ctr::circle` on Axis `ax` by using `CairoMakie`.
"""
function show_contour!(ax, ctr::circle)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.radius*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.radius*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

"""
    show_quadpts!(ax, pts::quadpts)

Plot the quadrature points `pts` on Axis `ax` by using `CairoMakie`.
"""
function show_quadpts!(ax, pts::quadpts)
    scatter!(ax, pts.nodes[:,1], pts.nodes[:,2])
end

"""
    show_eigenvalues(ax, eigvals::AbstractArray)

Plot the eigenvalues on complex plane on Axis `ax` by using `CairoMakie`.
"""
function show_eigenvalues!(ax, eigvals::AbstractArray)
    scatter!(ax, real(eigvals), imag(eigvals), marker = :cross, color = :red)
end