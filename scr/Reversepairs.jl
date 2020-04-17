"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Reversepairs

"""
    makewordarray()

Reads lines from a file and builds an array using push!.
"""
function makewordarray()
    wordarray = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        push!(wordarray, word)
    end
    return wordarray
end

"""
    isinbisect(wordarray, word)

Checks whether a word is in an array using bisection search.

Precondition: the words in the array are sorted

# Arguments
- `wordarray`: array of strings.
- `word`: string.
returns: true if the word is in the array; false otherwise
"""
function isinbisect(wordarray, word)
    length(wordarray) == 0 && return false
    i = length(wordarray) ÷ 2 + 1
    wordarray[i] == word && return true
    (wordarray[i] > word) ? (return isinbisect(wordarray[begin:i-1], word)) : (return isinbisect(wordarray[i+1:end], word))
end

"""
    isreversepair(wordarray, word)

Checks whether a reversed word appears in wordarray.

# Arguments
- `wordarray`: array of strings.
- `word`: string.
"""
function isreversepair(wordarray, word)
    return isinbisect(wordarray, reverse(word))
end

"""
    reversepairs()
Return all reversepair words.
"""
function reversepaires()
    wordarray = makewordarray()
    for word in wordarray
        isreversepair(wordarray, word) && println(word, "  ", reverse(word))
    end
end

reversepaires()

end