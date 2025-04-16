```@meta
CurrentModule = Cim
```

# Contours and Quadrature Rules

## Contours

We plan to support three kinds of contours: ellipse, circle, and rectangle (not support yet).

## Quadrature Rules

We use the composite trapezoidal rule on ellipse and circles. We can get the quadrature 
points by using 
```@docs
get_quadpts
```
For example, 
```julia
# Create a ellipse
elp = Cim.ellipse([150, 0], 148, 148)
# Get the quadrature points associated to the trapezoidal rule
pts = get_quadpts(ctr, 50)
```
