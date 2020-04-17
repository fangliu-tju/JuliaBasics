"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Wordlist

"""
    makewordlist1()

Reads lines from a file and builds a list using push!.
"""
function makewordlist1()
    t = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        push!(t, word)
    end
    return t
end

"""
    makewordlist2()

Reads lines from a file and builds a list using array.
"""
function makewordlist2()
    t = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        t = [t..., word]
    end
    return t
end

t = makewordlist1();
@time t=makewordlist1();
println(length(t));
println(t[1:10]);

t = makewordlist2();
@time t=makewordlist2();
println(length(t));
println(t[1:10]);

end
