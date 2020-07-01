"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/ispower.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    ispower(a, b)

Returns true if a is power of b.

# Arguments
- `a`: an Integer.
- `b`: an Integer.
"""
function ispower(a, b)
    if b == 0
        error("zero can not be a base.")
    end
    if a == 1
        return true
    end
    return a % b == 0 && ispower(a ÷ b, b)

end

println(ispower(1, 3))
println(ispower(1, 0))
println(ispower(27, 3))
println(ispower(37, 6))
