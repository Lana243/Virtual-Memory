module add

function download_page(n, m, seq, q, params, up_opened, replacement, up_short)
    used = fill(0, n)
    ans = 0
    for i in 1:n
        if used[seq[i]] == 1
            q, params = up_opened(q, params, seq[i], i)
            continue
        end
        if length(q) == m
            ans += 1
            q, params, removed = replacement(q, params, seq[i], i)
            used[seq[i]] = 1
            used[removed] = 0
            continue
        end
        used[seq[i]] = 1
        q, params = up_short(q, params, seq[i], i)
    end
    return ans
end

end