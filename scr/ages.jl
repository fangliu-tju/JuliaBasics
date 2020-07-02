"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/ages.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    isreversed(i, j)

Checks if i and j are the reverse of each other.

# Arguments
- `i`: integer.
- `j`: integer.
"""
function isreversed(i, j)
    return string(i, pad=2) == reverse(string(j, pad=2))
end

"""
    numinstances(diff, flag=false)

Counts the number of palindromic ages.
Returns the number of times the mother and daughter have
palindromic ages in their lives, given the difference in age.

# Arguments
- `diff`: int difference in ages.
- `flag`: bool, if True, prints the details.
"""
function numinstances(diff, flag=false)
    daughter = 0
    count = 0
    while true
        mother = daughter + diff

        if isreversed(daughter, mother) 
            count += 1
            if flag
                println(lpad(daughter, 2), "  ", lpad(mother, 2))
            end
        end
        if mother >99
            break
        end
        daughter += 1
    end
    return count
end

"""
    ages()

Finds age differences that satisfy the problem.

Enumerates the possible differences in age between mother
and daughter, and for each difference, counts the number of times
over their lives they will have ages that are the reverse of
each other.
"""
function ages()
    diff = 10
    while diff < 70
        n = numinstances(diff)
        if n > 0
            println(diff, "  ", n)
        end
        diff += 1
    end
end

println("diff #instances")
ages()

println("daughter mother")
numinstances(18, true)
