"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Reducible

"""
    makeworddict()

Read the words and return a dictionary that contains the words as keys
"""
function makeworddict()
    d = Dict()
    for line in eachline("./scr/CROSSWD.TXT")
        word = lowercase(strip(line))
        d[word] = nothing
    end

    # have to add single letter words to the word dict;
    # also, the empty string is considered a word.
    for letter in ["a", "i", ""]
        d[letter] = nothing
    end

    return d
end

"""
    children(worddict, word)

Returns an array of all words that can be formed by removing one letter.

# Arguments
- 'worddict': a dictionary that contains the words as keys.
- 'word': strings.
Retruns: array of strings
"""
function children(worddict, word)
    res = []
    for i in 1:length(word)
        child = word[begin:i-1] * word[i+1:end]
        if child in keys(worddict)
            push!(res, child)
        end
    end
    res
end

"""
    isreducible(worddict, word)

If word is reducible, returns an array of its reducible children.

Also adds an entry to the memo dictionary.

A string is reducible if it has at least one child that is 
reducible. The empty string is also reducible.

# Arguments
- 'worddict': a dictionary that contains the words as keys.
- 'word': strings.
Retruns: Bool value.
"""
function isreducible(worddict, word)
    word ∉ keys(worddict) && error("please enter correct word!")

    # if have already checked this word, return true.
    word ∈ keys(memo) && return true
    
    # check each of the children and make an array of the reducible ones.
    for child in children(worddict, word)
        isreducible(worddict, child) && (memo[word] = push!(get(memo, word, []), child))
        return isreducible(worddict, child) 
    end
    return false
end

"""
    allreducible(worddict)
    
Checks all words in the word_dict; returns an array reducible ones.

# Arguments
- 'worddict': a dictionary that contains the words as keys.
"""
function allreducible(worddict)
    res = []
    for word in keys(worddict)
        isreducible(worddict, word) && push!(res, word)
    end
    res
end

"""
    printtrail(worddict, word)
    
Prints the sequence of words that reduces this word to the empty string.

# Arguments
- 'worddict': a dictionary that contains the words as keys.
- `word`: string.
"""
function printtrail(worddict, word)
    length(word) == 0 && return ""
    print("$word ")
    isreducible(worddict, word) && printtrail(worddict, memo[word][1])
end

"""
    printlongestwords(worddict)
    
Finds the longest reducible words and prints them.

# Arguments
- 'worddict': a dictionary that contains the words as keys.
"""
function printlongestwords(worddict)
    words = allreducible(worddict)
    # sort by word length
    t = []
    for word in words
        push!(t, (length(word), word))
    end
    sort!(t, rev=true)

    for (_, word) in t[1:5]
        printtrail(worddict, word)
        print("\n")
    end
end

memo = Dict();
memo[""] = [""];

worddict = makeworddict();
printlongestwords(worddict)

end