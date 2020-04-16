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
    makewordlist()

Reads lines from a file and builds a list using append.
"""
function makewordlist()
    wordlist = []
    for line in eachline("./scr/CROSSWD.TXT")
        word = strip(line)
        push!(wordlist, word)
    end
    return wordlist
end

"""
    isinbisect(wordlist, word)

Checks whether a word is in a list using bisection search.

Precondition: the words in the list are sorted

# Arguments
- `wordlist`: list of strings.
- `word`: string.
returns: true if the word is in the list; false otherwise
"""
function isinbisect(wordlist, word)
    length(wordlist) == 0 && return false
    i = length(wordlist) ÷ 2 + 1
    wordlist[i] == word && return true
    (wordlist[i] > word) ? (return isinbisect(wordlist[begin:i-1], word)) : (return isinbisect(wordlist[i+1:end], word))
end

"""
    isinterlock(wordlist, word)

Checks whether a word appears in word_list as an interlock.

# Arguments
- `wordlist`: list of strings.
- `word`: string.
"""
function isinterlock(wordlist, word)
    return isinbisect(wordlist, word[begin:2:end]) && isinbisect(wordlist, word[begin+1:2:end])
end

"""
    interlock()
Return all interlock words.
"""
function interlock()
    wordlist = makewordlist()
    for word in wordlist
        isinterlock(wordlist, word) && println("$word = $(word[begin:2:end]) interlock $(word[begin+1:2:end])")
    end
end

function istriinterlock(wordlist, word)
    return isinbisect(wordlist, word[begin:3:end]) && isinbisect(wordlist, word[begin+1:3:end]) && isinbisect(wordlist, word[begin+2:3:end])
end

function triinterlock()
    wordlist = makewordlist()
    for word in wordlist
        istriinterlock(wordlist, word) && println("$word = $(word[begin:3:end]), $(word[begin+1:3:end]) and $(word[begin+2:3:end])")
    end
end

interlock()
triinterlock()

end