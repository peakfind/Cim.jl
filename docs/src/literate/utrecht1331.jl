# # Utrecht1331 
#
# utrecht1331 is a new quadratic eigenvalue problem in NLEVP version 4.0 [nlevp](@cite).
# You can find the NLEVP MATLAB toolbox and the documentations in its [Github repository](https://github.com/ftisseur/nlevp).
#
# ## Matlab code for utrecht1331
#
# Install the toolbox and [`quadratic-eigensolver`](https://github.com/ftisseur/quadratic-eigensolver) 
# which contains the MATLAB function `quadeig`. Then we can solve the utrecht1331 by the code below.
# ```Matlab
# % Utrecht1331 in NLEVP
# 
# %% Clear the workspace and the command window
# clear;
# clc;
# 
# %% Load the matrices
# load utrecht1331
# 
# %% Get the coefficients of the eigenvalue problem
# lambda = quadeig(M, D, K);
# 
# %% Plot the distribution of eigenvalues
# 
# % Use LaTeX by default for all labels
# set(groot,'defaultTextInterpreter','latex')
# scatter(real(lambda), imag(lambda), 150, "red", ".");
# 
# % Set title, axis limit, labels
# title('Distribution of the eigenvalues of \texttt{utrecht1331}', 'FontSize', 20)
# axis([-18, 0, -600, 500])
# xlabel('$\Re(\lambda)$', 'FontSize',18);
# ylabel('$\Im(\lambda)$', 'FontSize',18);
# grid on;
# ```
# 
# ![distribution](utrecht1331_1.png)
# 
# This figure showw the distribution of the eigenvalues of utrecht1331.

# ## Contour integral method

# Since utrecht1331 is a quadratic eigenvalue problem (then, of course, it is holomorphic 
# with repect to the eigenvalue), we can use the contour integral method to solve this 
# problem.

# First, we need to load our package.
# ```julia
# using Cim
# ```julia

# We also need [MAT.jl](https://github.com/JuliaIO/MAT.jl) to read the coefficients of 
# the utrecht1331. 
# ```julia
# using MAT
# ```

# Read the three matrices by using MAT.jl. You can download utrecht1331.mat from 
# [Github repository](https://github.com/ftisseur/nlevp).
# ```julia
# coeffs = matread("utrecht1331.mat")
# ```

# Extract these three matrices and convert the real matrices to complex.
# ```julia
# M, D, K = coeffs["M"], coeffs["D"], coeffs["K"] 
# M = complex.(M)
# K = complex.(K)
# # Get the size of the matrices
# d = size(D, 1)
# ```

# Construct the quadratic eigenvalues problem by [`Qep`](@ref).
# ```julia
# Q = Qep{ComplexF64}(A₀ = K, A₁ = D, A₂ = M)
# ```

# Construct the contour.
# ```julia
# elp = Cim.ellipse([-1.0, -281.0], 1.0, 4.0)
# ```

# We want to get the two eigenvalues inside the blue circle in the below figure

# ![eigenvals](utrecht1331_2.png)

# Solve the eigenvalue problem
# ```julia
# λ = cim(elp, Q, d, 5)
# ```