"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/randomword.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    randomword(hist)

Chooses a random word from a histogram.

The probability of each word is proportional to its frequency.

# Arguments
- 'hist': map from word to frequency.
"""
function randomword(hist)
    words = []
    freqs = []
    totalfreq = 0

    # make an array of words and an array of cumulative frequencies
    for (word, freq) in hist
        totalfreq += freq
        push!(words, word)
        push!(freqs, totalfreq)
    end

    # choose a random value and find its location in the cumulative array
    x = rand(1:totalfreq)
    index = bisect(freqs,x)
    return words[index]
end

"""
    bisect(array, element)

Finds the index of an element in an array using bisection search.

Precondition: the elements in the array are sorted

# Arguments
- `array`: array.
- `element`: element.
"""
function bisect(array, element)
    length(array) == 0 && return -1
    element <= array[1] && return 1
    base = 1
    len = (length(array)+1) ÷ 2
    i = len + base
    while true
        len = (len+1) ÷ 2
        if array[i] >= element
            if array[i-1] < element
                return i
            else
                i = len + base
            end
        else
            base = i
            i = len + base
        end
    end
end


function processfile(filename, skipheaderandends)
    hist = Dict()
    file = open(filename)

    skipheaderandends && skipgutenbergheader(file)

    for line in eachline(file)
        skipheaderandends && startswith(line, "*** END OF THIS") && break
        processline!(hist, line)
    end
    close(file)
    hist
end

function skipgutenbergheader(file)
    for line in eachline(file)
        startswith(line, "*** START OF THIS") && break
    end
end
    
function processline!(hist, line)
    line = replace(line, '-'=>' ')
    for word in split(line)
        word = string(filter(isletter, [word...])...)
        word = lowercase(word)
        hist[word] = get(hist, word, 0) + 1
    end
end


hist = processfile("./scr/emma.txt", true);

println("Here are some random words from the book")
for _ in 1:100
    print(randomword(hist), " ")
end
