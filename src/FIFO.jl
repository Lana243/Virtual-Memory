module FIFO

include("add.jl")
using .add

function up_opened(q, time_in, page, cur_ind)
#recalc q and time_in if page already opened
    return q, time_in
end

function replacement(q, time_in, page, cur_ind)
#find necessary page to replace
     cur = q[1]
     popfirst!(q)
     push!(q, page)
     @info q[1]
     return q, time_in, cur
end

function up_short(q, time_in, page, cur_ind)
#update q and time_in if there is an empty frame for the page
    push!(q, page)
    return q, time_in
end

function main(n, m, seq)
    @info "FIFO started"
    q = Vector{Int}(undef, 0)
    time_in = Vector{Int}(undef, 0)
    ans = add.download_page(n, m, seq, q, time_in, up_opened, replacement, up_short)
    @info "FIFO finished"
    return ans
end

end