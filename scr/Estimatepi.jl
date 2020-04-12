"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Estimatepi

"""
    estimatepi()

Computes an estimate of pi. 

Algorithm due to Srinivasa Ramanujan, from

https://brilliant.org/wiki/srinivasa-ramanujan/

"""
function estimatepi()
    total = 0.0
    k = 0
    factor = 2.0 * sqrt(2.0) / 9801.0
    while true
        num = factorial(4k) * (1103.0 + 26390.0k)
        den = factorial(k)^4 * 396.0^(4k)
        term = factor * num / den
        total += term 
        if abs(term) < 1e-15
            break
        end
        k += 1
    end
    return 1 / total
end

println(estimatepi())

end