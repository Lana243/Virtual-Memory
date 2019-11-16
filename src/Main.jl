include("FIFO.jl")
include("LRU.jl")
include("OPT.jl")

using .FIFO, .LRU, .OPT
using Logging

logger = ConsoleLogger()
input = open("data/input.txt", "r")
@info "Input file opened"
output = open("data/output.txt", "w")
@info "Output file opened"

function read_file()
    n, m = split(readline(input), ' ')
    n = parse(Int, n) #pages
    m = parse(Int, m) #frames
    buffer = split(readline(input), ' ')
    @info "Input file read"
    seq = Vector{Int}(undef, n)
    for i in 1:n
        seq[i] = parse(Int, buffer[i])
    end
    return n, m, seq
end

n, m, seq = read_file()
cnt_fifo = FIFO.main(n, m, seq)
cnt_lru = LRU.main(n, m, seq)
cnt_opt = OPT.main(n, m, seq)
println(output, "FIFO - ", cnt_fifo, ", LRU - ", cnt_lru, ", OPT - ", cnt_opt, " replacements")

close(input)
@info "Input file closed"
close(output)
@info "Output file closed"