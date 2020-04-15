"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Findtripledouble

"""
    istripledouble(word)

Tests if a word contains three consecutive double letters.

# Arguments
- `word`: string.
"""
function istripledouble(word)
    i = 1
    count = 0
    while i < length(word)
        if word[i] == word[i+1]
            count += 1
            if count == 3
                return true
            end
            i += 2
        else
            i = i - 2count + 1
            count = 0
        end
    end
    false
end

"""
Reads a word list and prints words with triple double letters.
    findtripledouble()
"""
function findtripledouble()
    fin = open("./scr/CROSSWD.TXT")
    for line in eachline(fin)
        word = strip(line)
        istripledouble(word) && println(word)
    end
end

println("Here are all the words in the list that have")
println("three consecutive double letters.")
findtripledouble()

end
