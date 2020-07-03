"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/hasduplicates.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    hasduplicates(t)

Checks whether any element appears more than once in a sequence.

Simple version using a for loop.

# Arguments
- `t`: sequence.
"""
function hasduplicates(t)
    d = Dict()
    for x in t
        x ∈ keys(d) && return true
        d[x] = nothing
    end
    return false
end

"""
    hasduplicates2(t)

Checks whether any element appears more than once in a sequence.

Faster version using a set.

# Arguments
- `t`: sequence.
"""
function hasduplicates2(t)
    return length(Set(t)) < length(t)
end

t = [1, 2, 3]
println(hasduplicates(t))
push!(t, 1)
println(hasduplicates(t))

t = [1, 2, 3]
println(hasduplicates2(t))
push!(t, 1)
println(hasduplicates2(t))
