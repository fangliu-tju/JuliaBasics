"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
https://github.com/llffyy2971/JuliaBasics/tree/master/scr/Kangaroo.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Kangaroo

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

end