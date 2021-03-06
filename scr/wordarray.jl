"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/wordarray.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    makewordarray1()

Reads lines from a file and builds an array using push!.
"""
function makewordarray1()
    t = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        push!(t, word)
    end
    return t
end

"""
    makewordarray2()

Reads lines from a file and builds an array using vcat.
"""
function makewordarray2()
    t = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        t = vcat(t, [word])
    end
    return t
end

t = makewordarray1();
@time t=makewordarray1();
println(length(t));
println(t[1:10]);

t = makewordarray2();
@time t=makewordarray2();
println(length(t));
println(t[1:10]);
