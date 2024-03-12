series = [0.5783834024666892, 0.41692819343103993, 0.28467412058772745, 0.040996614637221374, 0.06804363629643206, 0.9244312331822693, 0.08725427297969246, 0.7808434807429435, 0.17007538615159856, 0.832499149162595]

vals = [
  0.526449  0.253821  0.536858  0.15444   0.39956    0.278192  0.145485  0.685143   0.495732  0.596486
  0.913692  0.205756  0.403905  0.529887  0.104882   0.180711  0.651375  0.208858   0.307472  0.277686
  0.537414  0.870541  0.163864  0.374202  0.0393039  0.68875   0.828697  0.0172519  0.668273  0.765799
]

@testset "cepstral.jl" begin
  @testset "ARMACepstral" begin
    @test (cc(ARMACepstral(1., (1, 1)), series, 5) == [-0.6231197903689889, -0.01564051553647603, -0.005955402230438618, -0.0027120968883413143, -0.0015279908018555185])

    @test isapprox(cc(ARMACepstral(1., (1, 1)), vals, 5), [ -1.03522     -2.168        -2.28113
                                                            -0.0172828    0.00615351    0.00264155
                                                            -0.00445416   0.00153819    0.000682284
                                                            -0.00197663   0.000683611   0.000305177
                                                            -0.00111116   0.000384525   0.00017205], atol=1e-5)
  end

  @testset "ARCepstral" begin
    @test (cc(ARCepstral(1), series, 5) == [0.5686327103717447, 0.16167157965235823, 0.06128783235186792, 0.026137699667288815, 0.011890200803754471])
    @test (cc(ARCepstral(2), series, 5) == [0.5061405677355508, -0.08265600639423334, -0.06344592753639652, -0.015374742371503975, 0.0017971279975581714])
    @test isapprox(cc(ARCepstral(1), vals, 5), [ 0.239323     0.276995     0.26709
                                                 0.0286378    0.0383632    0.0356686
                                                 0.00456913   0.00708428   0.00635116
                                                 0.000820125  0.00147174   0.00127225
                                                 0.00015702   0.000326131  0.000271845], atol=1e-5)
  end

  @testset "RealCepstral" begin
    @test (cc(RealCepstral(), series, 5) == [0.03700275546236409, 0.0867638177224842, 0.38225344455973626, -0.03467668552262836, 0.10502390427503827])
    @test (cc(RealCepstral(), series, 5, normalize=true) == [-2.482417812401184, -3.5121897532599697, -3.2167001264227184, -3.633630256505082, -3.493929666707416])
    @test isapprox(cc(RealCepstral(), vals, 5), [ -0.65022   -0.198637   0.113368
                                                   0.342659   0.0145222  0.152945
                                                   0.341224   0.174512   0.0952615
                                                   0.259176   0.317715   0.246168
                                                  -0.163841   0.252064   0.0640904], atol=1e-5)
  end

  @testset "Errors" begin
    @test_throws MethodError ARCepstral(2.)
    @test_throws MethodError ARMACepstral(2, (1, 1))
    @test_throws MethodError ARMACepstral(2., (1., 1))
    @test_throws MethodError ARMACepstral(2., (1, 1.))
    @test_throws MethodError ARMACepstral(2., (1., 1.))
    @test_throws ArgumentError cc(RealCepstral(), series, 0)
  end
end
