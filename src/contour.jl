
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

"""
"""
struct rectangle <: AbstractContour
    center::Vector{Float64}
    semi_x::Float64
    semi_y::Float64
end

"""
"""
struct circle <: AbstractContour
    center::Vector{Float64}
    radius::Float64
end

"""
"""
struct quadpts
    N::Int64                     # the number of the quadrature nodes
    nodes::Matrix{Float64}       # quadrature nodes size of N x 2 
    nodes_prime::Matrix{Float64} # derivative of the parametrization size of N x 2
end

"""
    get_quadpts(contour::ellipse or circle, num_quadpts::Int64)
    -------------------------------------------------------
    Input:
        contour    : the contour that we discretize 
        num_quadpts: the number of the quadrature nodes
    Output:
        quadpts    : the struct quadpts which contains the 
                     information of the quadrature nodes

    TODO: note that rectangle is different with ellipse and circle
"""
function get_quadpts(contour::ellipse, num_quadpts::Int64)
    nodes = zeros(num_quadpts, 2)
    nodes_prime = zeros(num_quadpts, 2)
    delta = 2*pi / num_quadpts

    for i = 0:num_quadpts-1
        nodes[i + 1, 1] = contour.center[1] + contour.semi_x * cos(delta * i)
        nodes[i + 1, 2] = contour.center[2] + contour.semi_y * sin(delta * i)
        nodes_prime[i + 1, 1] = -contour.semi_x * sin(delta * i)
        nodes_prime[i + 1, 2] = contour.semi_y * cos(delta * i)
    end

    return quadpts(num_quadpts, nodes, nodes_prime)
end

function get_quadpts(contour::circle, num_quadpts::Int64)
    nodes = zeros(num_quadpts, 2)
    nodes_prime = zeros(num_quadpts, 2)
    delta = 2*pi / num_quadpts

    for i = 0:num_quadpts-1
        nodes[i + 1, 1] = contour.center[1] + contour.radius * cos(delta * i) 
        nodes[i + 1, 2] = contour.center[1] + contour.radius * sin(delta * i)
        nodes_prime[i + 1, 1] = -contour.radius * sin(delta * i)
        nodes_prime[i + 1, 2] = contour.radius * cos(delta * i)
    end

    return quadpts(num_quadpts, nodes, nodes_prime)
end

"""
    show_contour!(ctr::ellipse)
    show_contour!(ctr::circle)

Plot the contour `ctr` on Axis `ax`
"""

function show_contour!(ax, ctr::ellipse)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.semi_x*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.semi_y*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

function show_contour!(ax, ctr::circle)
    θ = range(0, 2π; length=100)
    x₁ = ctr.center[1] .+ ctr.radius*cos.(θ)
    x₂ = ctr.center[2] .+ ctr.radius*sin.(θ)
    lines!(ax, x₁, x₂, color = :blue)
end

"""
    show_quadpts!(ax, pts::quadpts)

Plot the quadrature points `pts`
"""
function show_quadpts!(ax, pts::quadpts)
    scatter!(ax, pts.nodes[:,1], pts.nodes[:,2])
end

"""
    show_eigenvalues(ax, eigvals::AbstractArray)

Plot the eigenvalues on complex plane
"""
function show_eigenvalues!(ax, eigvals::AbstractArray)
    scatter!(ax, real(eigvals), imag(eigvals), marker = :cross, color = :red)
end