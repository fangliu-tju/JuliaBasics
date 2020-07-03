"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/anagram.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    signature(s)

Returns the signature of this string.
Signature is a string that contains all of the letters in order.

# Arguments
- `s`: string.
"""
function signature(s)
    t = collect(s)
    sort!(t)
    t = join(t)
end

"""
    allanagrams(filename)

Finds all anagrams in a list of words.

# Arguments
- `filename`: string filename of the word array

Returns: a map from each word to an array of its anagrams.
"""
function allanagrams(filename)
    d = Dict()
    for line in eachline(filename)
        word = lowercase(strip(line))
        t = signature(word)
        d[t] = push!(get(d, t, String[]), word)
    end
    for (k, v) in d
        length(v) == 1 && delete!(d, k)
    end
    d
end

"""
    printanagraminorder(d)
Prints the anagram sets in d in decreasing order of size.

# Arguments
- `d`: map from words to array of their anagrams.
- `n`: number of anagrams to be printed, default is to print all.
"""
function printanagraminorder(d, n=length(d))
    t = []
    # make an array of (length, word pairs)
    for v in values(d)
        push!(t, (length(v), v))
    end
    # sort in ascending order of length
    sort!(t, rev=true)
    # print the sorted array
    for i in 1:n
        println(t[i])
    end
end

"""
    filterlength(d, n)
    
Select only the words in d that have n letters.

# Arguments
- `d`: map from words to array of their anagrams
- `n`: integer number of letters

returns: new map from word to array of anagrams
"""
function filterlength(d, n)
    res = Dict()
    for (word, anagrams) in d
        length(word) == n && (res[word] = anagrams)
    end
    res
end


anagram = allanagrams("./scr/CROSSWD.TXT");
printanagraminorder(anagram)

eightletters = filterlength(anagram, 8);
printanagraminorder(eightletters)
