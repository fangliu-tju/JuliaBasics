"""
This module contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/lineCount.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

module LineCount
export linecount

function linecount(filename)
    count = 0
    for line in eachline(filename)
        count += 1
    end
    count
end
end