"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/homophone.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    makeworddict()

Read the words and return a dictionary that contains the words as keys
"""
function makeworddict()
    d = Dict()
    for line in eachline("./scr/CROSSWD.TXT")
        word = uppercase(strip(line))
        d[word] = nothing
    end
    return d
end

"""
    makephonedict()

Read the phone's dictionary and return a dictionary that contains the words as keys and phones as values.
"""
function makephonedict()
    d = Dict()
    for line in eachline("./scr/cmudict-07b.txt")
        words = split(strip(line), "  ")
        phone = words[1]
        d[phone] = words[2]
    end
    return d
end

"""
    homophones(phonetic, a, b)

Checks if words two can be pronounced the same way.

If either word is not in the pronouncing dictionary, return false

# Arguments
- 'a': strings.
- 'b': strings.
phonetic: map from words to pronunciation codes
"""
function homophones(phonetic, a, b)
    if a ∉ keys(phonetic) || b ∉ keys(phonetic)
        return false
    end
    return phonetic[a] == phonetic[b]
end

"""
    checkword(worddict, phonetic, word)

Checks to see if the word has the following property:
removing the first letter yields a word with the same
pronunciation, and removing the second letter yields a word
with the same pronunciation.

# Arguments


- 'word_dict': dictionary with words as keys.
- 'phonetic': map from words to pronunciation codes.
- 'word': string.
"""
function checkword(worddict, phonetic, word)
    word1 = word[2:end]
    if word1 ∉ keys(worddict)
        return false
    end
    if !homophones(phonetic, word, word1)
        return false
    end
    word2 = word[1] * word[3:end]
    if word2 ∉ keys(worddict)
        return false
    end
    if !homophones(phonetic, word, word2)
        return false
    end
    return true
end


worddict = makeworddict();
phonetic = makephonedict();
for word in keys(worddict)
    checkword(worddict, phonetic, word) && println("$word  $(word[2:end])  $(word[1]*word[3:end])")
end
