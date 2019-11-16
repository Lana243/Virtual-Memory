module LRU

include("add.jl")
using .add

function up_opened(q, lst_used, page, cur_ind)
#recalc q and lst_used if page already opened
    replace!(q, Pair(lst_used[page], page) => Pair(cur_ind, page), count = 1)
    lst_used[page] = cur_ind
    return q, lst_used
end

function replacement(q, lst_used, page, cur_ind)
#find necessary page to replace
    cur = minimum(q)
    lst_used[page] = cur_ind
    replace!(q, cur => Pair(cur_ind, page), count = 1)
    @info cur.second
    return q, lst_used, cur.second
end

function up_short(q, lst_used, page, cur_ind)
#update q and lst_used if there is an empty frame for the page
    push!(q, Pair(cur_ind, page))
    lst_used[page] = cur_ind
    return q, lst_used
end

function main(n, m, seq)
    @info "LRU started"
    q = Vector{Pair{Int, Int}}(undef, 0)
    lst_used = fill(0, n)
    ans = add.download_page(n, m, seq, q, lst_used, up_opened, replacement, up_short)
    @info "LRU finished"
    return ans
end

end