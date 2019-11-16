include("../src/FIFO.jl")
include("../src/LRU.jl")
include("../src/OPT.jl")

using .FIFO, .LRU, .OPT
using Test

@testset "FIFO" begin
    @test FIFO.main(8, 4, [5, 2, 4, 7, 4, 5, 7, 4]) == 0
    @test FIFO.main(9, 2, [2, 2, 3, 4, 1, 2, 1, 1, 3]) == 4
    @test FIFO.main(10, 3, [1, 2, 1, 5, 4, 1, 3, 2, 10, 1]) == 6
    @test FIFO.main(11, 3, [1, 2, 4, 1, 5, 2, 4, 1, 1, 3, 5]) == 3
end

@testset "LRU" begin
    @test LRU.main(8, 4, [5, 2, 4, 7, 4, 5, 7, 4]) == 0
    @test LRU.main(9, 2, [2, 2, 3, 4, 1, 2, 1, 1, 3]) == 4
    @test LRU.main(10, 3, [1, 2, 1, 5, 4, 1, 3, 2, 10, 1]) == 5
    @test LRU.main(11, 3, [1, 2, 4, 1, 5, 2, 4, 1, 1, 3, 5]) == 6
end

@testset "OPT" begin
    @test OPT.main(8, 4, [5, 2, 4, 7, 4, 5, 7, 4]) == 0
    @test OPT.main(9, 2, [2, 2, 3, 4, 1, 2, 1, 1, 3]) == 3
    @test OPT.main(10, 3, [1, 2, 1, 5, 4, 1, 3, 2, 10, 1]) == 3
    @test FIFO.main(11, 3, [1, 2, 4, 1, 5, 2, 4, 1, 1, 3, 5]) == 3
end