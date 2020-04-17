"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Ackmemo

cache = Dict()

"""
    ackmemo(m, n)

Computes the Ackermann function.

See https://mathworld.wolfram.com/AckermannFunction.html

# Arguments
- `m`: non-negative integer.
- `n`: non-negative integer.
"""
function ackmemo(m, n)
    if m == 0
        return n+1
    end
    if n == 0
        return ackmemo(m-1, 1)
    end
    if (m, n) in keys(cache)
        return cache[m, n]
    else
        cache[m, n] = ackmemo(m-1, ackmemo(m, n-1))
        return cache[m, n]
    end
end

println(ackmemo(3, 4))
println(ackmemo(3, 6))

end