"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/subtract.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    subtract(d1, d2)

Returns a set of all keys that appear in d1 but not d2.

# Arguments
- 'd1': dictionary.
- 'd2': dictionary.
"""
function subtract(d1, d2)
    setdiff(keys(d1), keys(d2))
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
words = processfile("./scr/CROSSWD.TXT", false);

diff = subtract(hist, words);
println("The words in the book that aren't in the word list are:")
for word in diff
    print(word, " ")
end
