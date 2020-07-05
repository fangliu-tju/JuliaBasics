"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/tree/master/scr/myTime.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

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
