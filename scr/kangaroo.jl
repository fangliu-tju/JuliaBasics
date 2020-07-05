"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/tree/master/scr/kangaroo.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

struct Kangaroo
    pouchcontents
end

Kangaroo() = Kangaroo([])

function putinpouch!(k::Kangaroo,s)
    push!(k.pouchcontents, s)
    nothing
end

Base.show(io::IO, k::Kangaroo)=println(io, "Kangaroo: $(k.pouchcontents)")


kanga = Kangaroo()
roo = Kangaroo()
putinpouch!(kanga, roo)
