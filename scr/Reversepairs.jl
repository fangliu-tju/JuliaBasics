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
    isreversepair(wordlist, word)

Checks whether a reversed word appears in word_list.

# Arguments
- `wordlist`: list of strings.
- `word`: string.
"""
function isreversepair(wordlist, word)
    return isinbisect(wordlist, reverse(word))
end

"""
    reversepairs()
Return all reversepair words.
"""
function reversepaires()
    wordlist = makewordlist()
    for word in wordlist
        isreversepair(wordlist, word) && println(word, "  ", reverse(word))
    end
end

reversepaires()

end