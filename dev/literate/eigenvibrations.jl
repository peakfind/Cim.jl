# # Eigenvibrations of a string

# ## Introduction

# Consider the following eigenvalue problem which appears in many papers, for 
# example [beyn2012](@cite), [solovev2006](@cite), and [kressner2009](@cite).
# In this introduction, we mainly follow the formulation in [kressner2009](@cite).
# Find ``\lambda > \kappa`` and a nonzero function ``u:[0, 1] \to \mathbb{R}`` 
# such that 
# ```math
# \begin{align*}
#     &-u''(x) = \lambda u(x), \\
#     &u(0) = 0,\ -u'(1) = \varphi(\lambda)u(1),
# \end{align*}
# ```
# where ``\varphi(\lambda) = \lambda \kappa M / (\lambda - \kappa)`` and 
# ``\kappa = K / M`` for given positive numbers ``K``, ``M``. This equation 
# describes the eigenvibrations of a string with a load of mass ``M`` attached 
# by an elastic spring of stiffness ``K``.

# A finite element discretization of the eigenvalue problem with P1 element on 
# subintervals of length ``h = 1/n`` leads to the nonlinear eigenvalue problem
# ```math
# (\mathbf{A}_{1} + \varphi(\lambda)\mathbf{e}_{n} \mathbf{e}_{n}^{\mathrm{T}} - \lambda \mathbf{A}_{3}) \mathbf{u} = 0,
# ```
# where 
# ```math
# \mathbf{A}_{1} = \frac{1}{h}
# \begin{bmatrix}
# 2  & -1     &        &    \\
# -1 & \ddots & \ddots &    \\
#    & \ddots & 2      & -1 \\
#    &        & -1     & 1 
# \end{bmatrix},
# \
# \mathbf{A}_{3} = \frac{h}{6}
# \begin{bmatrix}
# 4 & 1      &        &   \\
# 1 & \ddots & \ddots &   \\
#   & \ddots & 4      & 1 \\
#   &        & 1      & 2 
# \end{bmatrix}
# ```
# and ``\mathbf{e}_{n}`` is the unit vector with ``1`` on its ``n``-th entry and ``0`` on others.

# For simplicity, we set ``K = M = \kappa = 1``. Then ``\varphi(\lambda)`` reduces 
# to ``\frac{\lambda}{\lambda - 1}``. We present computed eigenvalues with ``n = 100`` 
# and ``n = 400`` in [kressner2009](@cite).

# |  ``n``  | ``\lambda_{1}`` | ``\lambda_{2}`` | ``\lambda_{3}`` | ``\lambda_{4}`` | ``\lambda_{5}`` |
# | :-----: | :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
# |   100   | 4.4821765459    | 24.223573113    | 63.723821142    | 123.03122107    | 202.20089914    |
# |   400   | 4.4820338110    | 24.219005847    | 63.692138408    | 122.91317036    | 201.88234012    |


# ## Contour integral method

# In this section, we will use the contour integral method to solve the above 
# nonlinear eigenvalue problem. First, we load Cim and SparseArrays.
using Cim, SparseArrays

# We use functions `nep1` and `nep2` to construct the discrete nonlinear eigenvalue 
# problems for ``n = 100`` and ``n = 400``.

## n = 100
function nep1(z::ComplexF64)
    d = 100
    off_diag = -(d + z/(6 * d)) * ones(d - 1)
    diag = (2 * d - 2 * z/(3 * d)) * ones(d)
    diag[end] = 0.5 * diag[end] + z/(z - 1.0)
    
    A = spdiagm(1 => off_diag, 0 => diag, -1 => off_diag)

    return A
end;

## n = 400
function nep2(z::ComplexF64)
    d = 400
    off_diag = -(d + z/(6 * d)) * ones(d - 1)
    diag = (2 * d - 2 * z/(3 * d)) * ones(d)
    diag[end] = 0.5 * diag[end] + z/(z - 1.0)
    
    A = spdiagm(1 => off_diag, 0 => diag, -1 => off_diag)

    return A
end;

# We set the number of the quadrature nodes and the number of columns of random 
# chosen matrx.

## the number of the quadrature nodes
N = 30;
## the number of columns of random chosen matrx
l = 10;

# We define the contour which is an ellipse with center ``(150, 0)`` and 
# same semi-major and semi-minor axes ``148``:
elp = Cim.ellipse([150, 0], 148, 148)

# Finally, we use [`cim`](@ref) to compute the eigenvalues inside the `elp`.
# For ``n = 100``, we get the eigenvalues ``\lambda_{1}``:
λ₁ = cim(elp, nep1, 100, l; n=N)

# For ``n = 400``, we get the eigenvalues ``\lambda_{2}``:
λ₂ = cim(elp, nep2, 400, l; n=N)