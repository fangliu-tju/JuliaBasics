"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/markov.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    processfile(filename, order=2)

Reads a file and performs Markov analysis.

#Argument

- `filename`: string
- `order`: integer number of words in the prefix

returns: map from prefix to array of possible suffixes.
"""
function processfile(filename, order=2)
    fp = open(filename)
    # map from prefixes to an array of suffixes
    suffixmap = Dict()
    # current tuple of words
    prefix = ()
    skipgutenbergheader(fp)

    for line in eachline(fp)
        if startswith(line, "*** END OF THIS")
            break
        end

        for word in split(rstrip(line))
            prefix = processword!(suffixmap, prefix, word, order)
        end
    end
    close(fp)
    return suffixmap
end

"""
    skipgutenbergheader(fp)

Reads from fp until it finds the line that ends the header.

#Argument

- `fp`: open file object.
"""
function skipgutenbergheader(fp)
    for line in eachline(fp)
        if startswith(line, "*** START OF THIS")
            break
        end
    end
end

"""
    processword!(suffixmap, prefix, word, order=2)
    
Processes each word.

#Argument

- `suffixmap`: map from prefixes to an array of suffixes.
- `prefix`: current tuple of words.
- `word`: string
- `order`: integer

During the first few iterations, all we do is store up the words; 
after that we start adding entries to the dictionary.
"""
function processword!(suffixmap, prefix, word, order=2)
    if length(prefix) < order
        prefix = (prefix..., word)
        return prefix
    end
    get!(suffixmap, prefix, [])
    push!(suffixmap[prefix], word)
    prefix = shift(prefix, word)
    return prefix
end

"""
    randomtex(suffixmap, n=100)

Generates random words from the analyzed text.
Starts with a random prefix from the dictionary.

#Argument

- `suffixmap`: map from prefixes to an array of suffixes.
- `n`: number of words to generate.
"""
function randomtext(suffixmap, n=100)
    # choose a random prefix (not weighted by frequency)
    start = rand(keys(suffixmap))

    for i in 1:n
        suffixes = get(suffixmap, start, nothing)
        if suffixes == nothing
            # if the start isn't in map, we got to the end of the
            # original ext, so we have to start again.
            randomtext(n-i)
            return
        end

        # choose a random suffix
        word = rand(suffixes)
        print(word, " ")
        start = shift(start, word)
    end
end

"""
    shift(t, word)

Forms a new tuple by removing the head and adding word to the tail.

#Argument

- `t`: tuple of strings.
- `word`: string.
Returns: tuple of strings
"""
function shift(t, word)
    return (t[2:end]..., word)
end

## methods for Data Encapsulation in Chapter 18. 
## Ignore them now and go back when learning section 18.11.

struct Markov
    order :: Int64
    suffixmap :: Dict{Tuple{String, Vararg{String}}, Array{String, 1}}
    prefix :: Array{String, 1}

    function Markov(order::Int64=2)
        new(order, Dict{Tuple{String, Vararg{String}}, Array{String, 1}}(), Array{String, 1}())
    end
end

function processfile(filename, order::Float64)

    markov = Markov(Int(order))
    
    fp = open(filename)
  
    skipgutenbergheader(fp)

    for line in eachline(fp)
        if startswith(line, "*** END OF THIS")
            break
        end

        for word in split(rstrip(line))
            processword!(markov, word)
        end
    end
    close(fp)
    return markov.suffixmap
end

function processword!(markov::Markov, word::AbstractString)
    if length(markov.prefix) < markov.order
        push!(markov.prefix, word)
        return
    end
    get!(markov.suffixmap, (markov.prefix...,), Array{String, 1}())
    push!(markov.suffixmap[(markov.prefix...,)], word)
    popfirst!(markov.prefix)
    push!(markov.prefix, word)
end


### main program
suffixmap = processfile("./scr/emma.txt");
randomtext(suffixmap)

suffixmap = processfile("./scr/emma.txt",2.0);
randomtext(suffixmap)
