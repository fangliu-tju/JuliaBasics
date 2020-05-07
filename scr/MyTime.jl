"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
https://github.com/llffyy2971/JuliaBasics/tree/master/scr/MyTime.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module MyTime

using Printf

struct MyTime
    hour
    minute
    second
end

function printtime(mytime)
    @printf "%02d:%02d:%02d" mytime.hour mytime.minute mytime.second
end

function isafter(t1, t2)
    t1.hour * 3600 + t1.minute * 60 + t1.second > t2.hour * 3600 + t2.minute * 60 + t2.second
end

end