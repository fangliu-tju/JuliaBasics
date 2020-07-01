"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/solvgcd.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    solvgcd(a, b)

Returns the greatest common divisor of a and b.

# Arguments
- `a`: an Integer.
- `b`: an Integer.
"""
function solvgcd(a, b)
    if b == 0
        return a
    end
    r = a % b
    return solvgcd(b, r)
end

println(solvgcd(1, 3))
println(solvgcd(2, 0))
println(solvgcd(27, 9))
println(solvgcd(37, 6))
