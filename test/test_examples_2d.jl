module TestExamples2D

using Test
using Trixi

include("test_trixi.jl")

# Start with a clean environment: remove Trixi output directory if it exists
outdir = "out"
isdir(outdir) && rm(outdir, recursive=true)

# pathof(Trixi) returns /path/to/Trixi/src/Trixi.jl, dirname gives the parent directory
const EXAMPLES_DIR = joinpath(pathof(Trixi) |> dirname |> dirname, "examples", "2d")

@testset "2D" begin

# Run basic tests
@testset "Examples 2D" begin
  @testset "parameters.jl" begin
    test_trixi_include(joinpath(EXAMPLES_DIR, "parameters.jl"),
            l2   = [9.144681765639205e-6],
            linf = [6.437440532547356e-5])
  end

  @testset "parameters_mortar.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_mortar.jl"),
            l2   = [0.022356422238096973],
            linf = [0.5043638249003257])
  end

  @testset "parameters_amr.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_amr.jl"),
            l2   = [0.12533080510721473],
            linf = [0.9999802982947753])
  end

  @testset "parameters_source_terms.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_source_terms.jl"),
            l2   = [8.517783186497567e-7, 1.2350199409361865e-6, 1.2350199409828616e-6, 4.277884398786315e-6],
            linf = [8.357934254688004e-6, 1.0326389653148027e-5, 1.0326389654924384e-5, 4.4961900057316484e-5])
  end

  @testset "parameters_nonperiodic.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_nonperiodic.jl"),
            l2   = [2.3652137675654753e-6, 2.1386731303685556e-6, 2.138673130413185e-6, 6.009920290578574e-6],
            linf = [1.4080448659026246e-5, 1.7581818010814487e-5, 1.758181801525538e-5, 5.9568540361709665e-5])
  end

  @testset "parameters_ec.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_ec.jl"),
            l2   = [0.061733846713578594, 0.05020086119442834, 0.05020836856347214, 0.2259064869636338],
            linf = [0.29894122391731826, 0.30853631977725215, 0.3084722538869674, 1.0652455597305965])
  end

  @testset "parameters_blast_wave_shockcapturing.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_blast_wave_shockcapturing.jl"),
            l2   = [0.13575932799459445, 0.11346025131402862, 0.11346028941202581, 0.33371846538168354],
            linf = [1.4662633480487193, 1.3203905049492335, 1.320390504949303, 1.8131376065886553],
            tspan = (0.0, 0.13))
  end

  @testset "parameters_blast_wave_shockcapturing_amr.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_blast_wave_shockcapturing_amr.jl"),
            l2   = [0.6778339184192986, 0.28136085729167076, 0.2813607687129121, 0.7202946425475186],
            linf = [2.8891939545999277, 1.8038083274644838, 1.8036523839220984, 3.0363712085327177],
            tspan = (0.0, 1.0))
  end

  @testset "parameters_ec_mhd.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "parameters_ec_mhd.jl"),
            l2   = [0.03628315925311581, 0.04301306535453907, 0.042998910996002976, 0.025746791646914315, 0.1620587870592711, 0.01745580631201365, 0.01745656644392971, 0.02688212902288343, 0.00014263322984147517],
            linf = [0.23504901239438747, 0.31563591777956146, 0.3094412744514615, 0.21177505529310434, 0.9738775041875032, 0.09120517132559702, 0.0919645047337756, 0.15691668358334432, 0.003551742314601502])
  end

  @testset "jeans_instability.jl" begin
  test_trixi_include(joinpath(EXAMPLES_DIR, "jeans_instability.jl"),
            l2   = [21174.220714494546, 978.743334383856, 5.0322938770733495e-6, 52935.53057317166],
            linf = [29951.893960533664, 1388.4393812604685, 1.2366523531186759e-5, 74879.81397015974],
            tspan = (0.0, 0.6))
  end
end


@testset "Displaying components 2D" begin
  @test_nowarn include(joinpath(EXAMPLES_DIR, "parameters.jl"))

  # test both short and long printing formats
  @test_nowarn println(mesh)
  @test_nowarn display(mesh)

  @test_nowarn println(equations)
  @test_nowarn display(equations)

  @test_nowarn println(solver)
  @test_nowarn display(solver)

  @test_nowarn println(semi)
  @test_nowarn display(semi)

  @test_nowarn println(stepsize_callback)
  @test_nowarn display(stepsize_callback)

  @test_nowarn println(analysis_callback)
  @test_nowarn display(analysis_callback)

  @test_nowarn println(save_solution)
  @test_nowarn display(save_solution)

  @test_nowarn println(alive_callback)
  @test_nowarn display(alive_callback)
end


# Clean up afterwards: delete Trixi output directory
@test_nowarn rm(outdir, recursive=true)

end # 2D

end #module
