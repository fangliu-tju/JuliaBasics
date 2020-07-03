"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/birthday.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    hasduplicates(t)

Returns true if any element appears more than once in a sequence.

# Arguments
- `t::Array`: list
"""
function hasduplicates(t)
    s = sort(t)
    lastind = lastindex(s)

    # check for adjacent elements that are equal
    for i in eachindex(s)
        i < lastind && s[i] == s[nextind(s, i)] && return true
    end
    return false
end

"""

    randombdays(n)

Returns an array of integers between 1 and 365, with length n.

# Arguments
- `n::Integer`: an integer.
"""
function randombdays(n)
    t = []
    for _ in 1:n
        bday = rand(1:365)
        append!(t, bday)
    end
    return t
end

"""
    countmatch(numstudents, numsamples)

Generates a sample of birthdays and counts duplicates.

# Arguments
- `numstudents::Integer`: how many students in the group.
- `numsamples::Integer`: how many groups to simulate.
"""
function countmatches(numstudents, numsamples)
    count = 0
    for _ in 1:numsamples
        t = randombdays(numstudents)
        if hasduplicates(t)
            count += 1
        end
    end
    return count
end

numstudents = 23
numsamples = 1000
count = countmatches(numstudents, numsamples)
println("After $numsamples simulations with $numstudents students, there were $count simulations with at least one match.")
