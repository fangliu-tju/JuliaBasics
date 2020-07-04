"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/zipf.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

using Plots

"""
    rankfreq(hist)

Returns an array of (rank, freq) tuples.

#Argument

- `hist`: map from word to frequency.

returns: array of (rank, freq) tuples
"""
function rankfreq(hist)
    # sort the array of frequencies in decreasing order
    freqs = collect(zip(values(hist), keys(hist)))
    sort!(freqs, rev=true)

    # enumerate the ranks and frequencies
    rf = [(r, f...) for (r, f) in enumerate(freqs)]
end

"""
    printranks(hist)

Prints the rank vs. frequency data.

#Argument

- `hist`: map from word to frequency.
"""
function printranks(hist)
    for (r, f, word) in rankfreq(hist)
        println("$word  $(log(f))  $(log(r))")
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
printranks(hist)
rf = rankfreq(hist);
plot(log10.(first.(rf)), log10.(getindex.(rf, 2)), title="Zipf plot", xlabel="rank", ylabel="frequency")

