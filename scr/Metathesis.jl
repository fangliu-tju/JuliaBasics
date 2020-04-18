"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Metathesis

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
    metathesispairs(d)

Print all pairs of words that differ by swapping two letters.

# Arguments
- `d`: map from word to array of anagrams.
"""
function metathesispairs(d)
    for anagrams in values(d)
        for word1 in anagrams
            for word2 in anagrams
                if word1 < word2 && worddistance(word1, word2) == 2
                    println("$word1 $word2")
                end
            end
        end
    end
end

"""
    worddistance(word1, word2)

Computes the number of differences between two words.

# Arguments
- `word1`: string.
- `word2`: string.

returns: integer
"""
function worddistance(word1, word2)
    @assert length(word1) == length(word2)

    count = 0
    for (c1, c2) in zip(word1, word2)
        c1 ≠ c2 && (count += 1)
    end
    count
end


anagrams = allanagrams("./scr/CROSSWD.TXT");
metathesispairs(anagrams)

end