```@meta
CurrentModule = Cim
```

# Cim

Documentation for [Cim](https://github.com/peakfind/Cim.jl).

## Usage

Cim.jl has not been registered. So it need to be installed by url. Press `]` in 
the REPL to enter `pkg>` mode. Then enter
```julia
pkg> add https://github.com/peakfind/Cim.jl.git
```

## Resources

In this section, we conclude some resources for learning the Contour integral method.

+ Beyn [beyn2012](@cite) and G&uuml;ttel Tisseur [guttel-tisseur2017](@cite) 
  discuss the nonlinear eigenvalue problem ``F(\lambda)v = 0``, where ``F(\lambda)`` 
  is a holomorphic matrix-valued function.
+ A basic `MATLAB` implementation can be found in Figure 5.3 in [guttel-tisseur2017](@cite)
+ Mennicken and M&ouml;ller investigate a more general case: ``F(\lambda)`` is a 
  Fredholm operator and holomorphic with respect to ``\lambda``.

## Related Packages

+ [NEP-PACK/NonlinearEigenproblems.jl](https://github.com/nep-pack/NonlinearEigenproblems.jl):
  It is a very general package for solving and manipulating nonlinear eigenvalue problems.
+ [WavesAndEigenvalues.jl](https://github.com/JulHoltzDevelopers/WavesAndEigenvalues.jl): 
  It provide an interface to define, solve, and perturb nonlinear eigenvalues 