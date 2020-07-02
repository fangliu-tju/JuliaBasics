"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/rotateword.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    rotate_letter(letter, n)
Rotates a letter by n places.  Does not change other chars.
# Arguments
- `letter`: single-letter string
- `n`: int
Returns: single-letter string
"""
function rotate_letter(letter, n)
    if isuppercase(letter)
        start = Int('A')
    elseif islowercase(letter)
        start = Int('a')
    else
        return letter
    end

    c = Int(letter) - start
    i = mod((c+n), 26) + start
    return Char(i)
end

"""
    rotateword(word, n)
Rotates a word by n places.
# Arguments    
- `word`: string
- `n`: integer
Returns: string
"""
function rotateword(word, n)
    res = ""
    for letter in word
        res *= rotate_letter(letter, n)
    end
    return res
end


println(rotateword("cheer", 7))
println(rotateword("melon", -10))
println(rotateword("sleep", 9))
