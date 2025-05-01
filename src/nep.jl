"""
    Qep{T}

Construct quadratic eigenvlaue problems 

``(\\mathbf{A}_{0} + \\alpha \\mathbf{A}_{1} + \\alpha^2 \\mathbf{A}_{2}) \\mathbf{u} = 0.``

# Fields

- `A₀`: the matrix in the zero order term
- `A₁`: the matrix in the first order term
- `A₂`: the matrix in the second order term 
"""
struct Qep{T}
    A₀::SparseMatrixCSC{T, Int}
    A₁::SparseMatrixCSC{T, Int}
    A₂::SparseMatrixCSC{T, Int}
end

"""
    Qep{T}(; 
    A₀::SparseMatrixCSC{T, Int}, 
    A₁::SparseMatrixCSC{T, Int}, 
    A₂::SparseMatrixCSC{T, Int}) where T

Use keywords arguments to construct qaudratic eigenvalue problems.
"""
function Qep{T}(; 
    A₀::SparseMatrixCSC{T, Int}, 
    A₁::SparseMatrixCSC{T, Int}, 
    A₂::SparseMatrixCSC{T, Int}) where T
    return Qep{T}(A₀, A₁, A₂)
end

"""
    (q::Qep{T})(α::S) where {T, S}

Compute the matrix of the quadratic eigenvalue problem at specific value `α`.
"""
function (q::Qep{T})(α::S) where {T, S}
    return q.A₀ + α * q.A₁ + (α^2) * q.A₂
end