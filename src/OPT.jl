module OPT

include("add.jl")
using .add

function build_next_pos(n::Int, seq::Vector{Int})
    ans = Vector{Int}(undef, n)
    lst = fill(n + 1, n)
    cur = n
    while cur > 0
        ans[cur] = lst[seq[cur]]
        lst[seq[cur]] = cur
        cur = cur - 1
    end
    @info "next_pos built"
    return ans
end

function up_opened(q, next_pos, page, cur_ind)
#update q and next_pos if page already opened
    replace!(q, Pair(cur_ind, page) => Pair(next_pos[cur_ind], page), count = 1)
    return q, next_pos
end

function replacement(q, next_pos, page, cur_ind)
#find necessary page to replace
    cur = maximum(q)
    replace!(q, cur => Pair(next_pos[cur_ind], page), count = 1)
    @info cur.second
    return q, next_pos, cur.second
end

function up_short(q, next_pos, page, cur_ind)
#update q and next_pos if there is an empty frame for the page
    push!(q, Pair(next_pos[cur_ind], page))
    return q, next_pos
end

function main(n, m, seq)
    @info "OPT started"
    next_pos = build_next_pos(n, seq)
    q = Vector{Pair{Int, Int}}(undef, 0)
    ans = add.download_page(n, m, seq, q, next_pos, up_opened, replacement, up_short)
    @info "OPT finished"
    return ans
end

end