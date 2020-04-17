"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Interlock

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
    isinterlock(wordarray, word)

Checks whether a word appears in wordarray as an interlock.

# Arguments
- `wordarray`: list of strings.
- `word`: string.
"""
function isinterlock(wordarray, word)
    return isinbisect(wordarray, word[begin:2:end]) && isinbisect(wordarray, word[begin+1:2:end])
end

"""
    interlock()
Return all interlock words.
"""
function interlock()
    wordarray = makewordarray()
    for word in wordarray
        isinterlock(wordarray, word) && println("$word = $(word[begin:2:end]) interlock $(word[begin+1:2:end])")
    end
end

function istriinterlock(wordarray, word)
    return isinbisect(wordarray, word[begin:3:end]) && isinbisect(wordarray, word[begin+1:3:end]) && isinbisect(wordarray, word[begin+2:3:end])
end

function triinterlock()
    wordarray = makewordarray()
    for word in wordarray
        istriinterlock(wordarray, word) && println("$word = $(word[begin:3:end]), $(word[begin+1:3:end]) and $(word[begin+2:3:end])")
    end
end

interlock()
triinterlock()

end