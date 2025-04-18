"""
    cim(ctr::AbstractContour, nep::Function, D, l::Int64; n=50, tol=1e-12)

Contour integral method to calculate the eigenvalues inside the contour `ctr`

# Arugments

- `ctr`: the contour
- `nep`: the nonlinear eigenvalue problem
- `D`: the scale of the `nep`
- `l`: the number of columns of random matrix
- `n`: the number of the quadrature points (here we use the trapezoid rule)
- `tol`: tolerance to determine the number of nonzero singular values

# Reference

- Wolf-Jurgen Beyn, An integral method for solving NEPs, Linear Algebra Appl., 2012.
"""
function cim(ctr::AbstractContour, nep::Function, d, l::Int64; n=50, tol=1e-12)
    # Input validation
    d > 0 || throw(ArgumentError("d must be positive"))
    l > 0 || throw(ArgumentError("l must be positive"))

    # Get the quadrature points
    pts = get_quadpts(ctr, n)

    # Preallocate arrays
    A0 = zeros(ComplexF64, d, l)
    A1 = zeros(ComplexF64, d, l)
    Vhat = randn(ComplexF64, d, l)

    # Compute A0 and A1 with trapezoid rule
    for j in 1:pts.N
        z = complex(pts.nodes[j, 1], pts.nodes[j, 2])
        z_prime = complex(pts.nodes_prime[j, 1], pts.nodes_prime[j, 2])
        invNEP_Vhat = nep(z) \ Vhat
        A0 .+= invNEP_Vhat * z_prime
        A1 .+= invNEP_Vhat * z * z_prime
    end
    A0 ./= (pts.N*im)
    A1 ./= (pts.N*im)

    # Compute the SVD of A0
    (V, Sigma, W) = svd(A0)

    # Handle rank deficiency
    if isempty(Sigma)
        @warn "No eigenvalues found!"
        return ComplexF64[]
    end

    # Determine the number of nonzero singular values 
    k = count(Sigma ./ Sigma[1] .> tol)

    # Compute the matrix B 
    Vk = V[:,1:k]
    Sigk = Sigma[1:k]
    Wk = W[:,1:k]

    # Diagonal is more efficient
    B = (Vk' * A1 * Wk) * Diagonal(1 ./ Sigk)

    # Compute the eigenvalues of B 
    lambda = eigvals(B)

    # Avoid spurious eigenvalues
    filter!(λ -> is_inside(λ, ctr), lambda)

    return lambda
end

"""
    contr_int_ho()

Contour integral method with high-order moments 

# Arguments

In this function, we follow the notations in Stefan Guttel, Francoise Tisseur, Acta Numerica, 2017

- `ctr`:
- `nep`:
- `D`:
- `r, l`: size of the probing matrices
- `pbar`: the number of the moments (for p = 0, ..., pbar)

# Reference

- Stefan Guttel, Francoise Tisseur, The NEP, Acta Numerica, 2017.
"""
function contr_int_ho(pts::quadpts, NEP::Function, D::Int64, l::Int64, r::Int64, pbar::Int64)
    # Preallocate arrays
    L = randn(ComplexF64, D, l)
    R = randn(ComplexF64, D, r)
    A = zeros(ComplexF64, 2*pbar*l, r)# contains all the moments p = 0, ..., 2*pbar - 1

    # Compute moments (We need use NEP\R not the inv())
    for j in 1:pts.N
        z = complex(pts.nodes[j, 1], pts.nodes[j, 2])
        z_prime = complex(pts.nodes_prime[j, 1], pts.nodes_prime[j, 2])
        L_invNEP_R = L' * (NEP(z) \ R)
        for p in 1:2*pbar
            A[(p-1)*l+1:p*l,:] .+= L_invNEP_R * (z^p) * z_prime
        end
    end

    A ./= (pts.N * im)

    # Compute B0 and B1
    B0 = zeros(ComplexF64, l*pbar, r*pbar)
    B1 = zeros(ComplexF64, l*pbar, r*pbar)

    for j = 1:pbar
        B0[:,(j-1)*r+1:j*r] = @view A[(j - 1)*l+1:(pbar+j-1)*l,:]
        B1[:,(j-1)*r+1:j*r] = @view A[j*l+1:(pbar+j)*l,:]
    end

    # Compute the SVD of B0
    (V, Sigma, W) = svd(B0)

    # Determine the number of nonzero singular values
    # mbar: the number of the eigs inside the contour
    tol = 1.0e-12
    mbar = count(Sigma ./ Sigma[1] .> tol)

    # Compute the matrix M
    Vmbar = V[:,1:mbar]
    Sigmbar = Sigma[1:mbar]
    Wmbar = W[:,1:mbar]
    M = (Vmbar' * B1 * Wmbar) * Diagonal(1 ./ Sigmbar)

    # Compute the eigenvalues of M
    lambda = eigvals(M)

    return lambda
end