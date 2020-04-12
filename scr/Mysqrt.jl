"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Mysqrt

"""
    mysqrt(a)

Computes square  root of a.

# Arguments
- `a`: non-negative number.
"""
function mysqrt(a)
    x = 2.0
    ɛ = 1.0e-15
    y = 0.0
    while true
        y = (x + a/x) / 2
        if abs(y - x) < ɛ
        break
        end
    x = y
    end
    y
end

function testsquareroot()
    println(rpad("a",4),rpad("mysqrt",20),rpad("sqrt",20),rpad("diff",20))
    println(rpad("-",4),rpad("------",20),rpad("----",20),rpad("----",20))
    for i in 1.0:9.0
        println(rpad(i,4),rpad(mysqrt(i),20),rpad(sqrt(i),20),rpad(abs(mysqrt(i)-sqrt(i)),20)) 
    end
end

testsquareroot()

end
    