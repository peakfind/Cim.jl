using Cim, CairoMakie

function nep(z::ComplexF64)
    D = 400
    A = zeros(ComplexF64, D, D)
    diag = 2.0*D - 4.0*z/(6.0*D) # diagonal entry
	odiag = -1.0*D - z/(6.0*D) # off-diagonal entry

	# top row
	A[1, 1] = diag
	A[1, 2] = odiag

	# interior rows
	for d = 2:D-1
		A[d,d] = diag
		A[d,d-1] = A[d,d+1] = odiag
    end

    # bottom row
	A[D, D-1] = odiag 
	A[D, D] = 0.5*diag + z/(z-1.0)

	return A
end

# Parameters
N = 50 # the number of the quadrature nodes
l = 10

# Define the contour
elp = Cim.ellipse([150, 0], 148, 148)

# Get the quadrature nodes
pts = get_quadpts(elp, N)

# Show the contour and quadrature points on the contour
fig = Figure()
ax = Axis(fig[1, 1], aspect = 1, title = "Contour")
show_contour!(ax, elp)
show_quadpts!(ax, pts)

# Compute the eigenvalues and plot them on complex plane
λ = contr_int(pts, nep, 400, l)
show_eigenvalues!(ax, λ)
fig