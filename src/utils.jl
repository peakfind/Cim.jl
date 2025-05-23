"""
    is_inside(λ, ctr::ellipse)
    is_inside(λ, ctr::circle)

Check if the eigenvalue λ is in the contour `ctr` to avoid 
spurious eigenvalues.
"""
function is_inside(λ, ctr::ellipse)
    # Promote λ if λ is not a complex number
    λ = complex(λ)

    d² = (ctr.semi_y*(real(λ) - ctr.center[1]))^2 + (ctr.semi_x*(imag(λ) - ctr.center[2]))^2
    r² = (ctr.semi_x*ctr.semi_y)^2

    if d² <= r²
        return true
    else
        return false
    end
end

function is_inside(λ, ctr::circle)
    # Promote λ if λ is not a complex number
    λ = complex(λ)

    d² = (real(λ) - ctr.center[1])^2 + (imag(λ) - ctr.center[2])^2
    r² = ctr.radius^2

    if d² <= r²
        return true
    else
        return false
    end
end

"""
    print_vec(vec; precision::Int=6)

Print the vector `vec` to the REPL.
"""
function print_vec(vec::AbstractVector; precision::Int=6)
    println("\nSingular values of A0:")
    
    # Construct the format we need
    fmt = Printf.Format("%.$(precision)e\n")

    # Print the elements in vec
    for v in vec 
        Printf.format(stdout, fmt, v)
    end
    
    return nothing
end