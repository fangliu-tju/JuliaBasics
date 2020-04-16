"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Isinbisect

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

wordlist = makewordlist();
for word in ["aa", "alien", "allen", "zymurgy"]
    println("$word in list ", isinbisect(wordlist, word))
end

end
