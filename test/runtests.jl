using Cim, SparseArrays
using Test

@testset "Cim.jl" begin
    @testset "Test for cim(nep::Function)" begin
        function nep100(z::ComplexF64)
            d = 100
            off_diag = -(d + z/(6 * d)) * ones(d - 1)
            diag = (2 * d - 2 * z/(3 * d)) * ones(d)
            diag[end] = 0.5 * diag[end] + z/(z - 1.0)
    
            A = spdiagm(1 => off_diag, 0 => diag, -1 => off_diag)

            return A
        end 
        
        elp = Cim.ellipse([150.0, 0.0], 148.0, 148.0)
        λ = cim(elp, nep100, 100, 10; n=30)
        rst = [4.4821765459, 24.223573113, 63.723821142, 123.03122107, 202.20089914]
        @test real(λ) ≈ rst atol=1e-6
    end
end