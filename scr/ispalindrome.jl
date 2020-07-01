"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/ispalindrome.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    ispalindrome(word)

Returns true if word is a palindrome.

# Arguments
- `word`: a string.
"""
function ispalindrome(word)
    if length(word) <= 1
        return true
    end
    if first(word) != last(word)
        return false
    end
    return ispalindrome(middle(word))
end

"""
Returns the first character of a string.
"""
function first(word)
    first = firstindex(word)
    word[first]
end

"""
Returns the last of a string.
"""
function last(word)
    last = lastindex(word)
    word[last]
end

"""
Returns all but the first and last characters of a string.
"""
function middle(word)
    first = firstindex(word)
    last = lastindex(word)
    word[nextind(word, first) : prevind(word, last)]
end


println(ispalindrome("allen"))
println(ispalindrome("bob"))
println(ispalindrome("otto"))
println(ispalindrome("redivider"))
