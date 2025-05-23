```@meta
CurrentModule = Cim
```

# API

## Contour

```@docs
AbstractContour
```

## Quadrature

```@docs
quadpts
get_quadpts(ctr::ellipse, num_quadpts::Int64)
get_quadpts(ctr::circle, num_quadpts::Int64)
```

## Nonlinear eigenvalue problems

```@docs
Qep
```

## Contour integral method

```@docs
cim
contr_int_ho
```

## Visualization

```@docs
show_contour!
show_eigenvalues!
show_quadpts!
```

## Utils

```@docs
is_inside
print_vec
```