"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Solvgcd

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

end