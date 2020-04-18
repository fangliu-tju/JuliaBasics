"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Mostfrequent

"""
    mostfrequent(s)

Sorts the letters in s in reverse order of frequency.

# Arguments
- `s`: string.
returns: array of letters
"""
function mostfrequent(s)
    hist = makehistogram(s)
    t = []
    for (x, freq) in hist
        push!(t, (freq, x))
    end
    sort!(t, rev=true)
    res = []
    for (freq, x) in t
        push!(res, x)
    end
    return res
end

"""
    makehistogram(s)

Make a map from letters to number of times they appear in s.

# Arguments
- `s`: string.
returns: map from letter to frequency
"""
function makehistogram(s)
    hist = Dict()
    for x in s
        if isletter(x) 
            x = lowercase(x)
            hist[x] = get(hist, x, 0) + 1
        end
    end
    return hist
end

"""
    readfile(filename)

Returns the contents of a file as a string.

# Arguments
- `filename`: a path to a file.
"""
function readfile(filename)
    arr = (join∘readlines)(filename)
end


str = readfile("./scr/emma.txt");
letterseq = mostfrequent(str)

end