"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Ack

"""
    ack(m, n)

Computes the Ackermann function.

See https://mathworld.wolfram.com/AckermannFunction.html

# Arguments
- `m`: non-negative integer.
- `n`: non-negative integer.
"""
function ack(m, n)
    if m == 0
        return n+1
    end
    if n == 0
        return ack(m-1, 1)
    end
    return ack(m-1, ack(m, n-1))
end

println(ack(3, 4))

end