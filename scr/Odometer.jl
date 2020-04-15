"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Odemeter

"""
    haspalindrome(i, start, len)

Checks if the string representation of i has a palindrome.

# Arguments
- `i`: integer.
- `start`: where in the string to start.
- `len`: length of the palindrome to check for.
"""
function haspalindrome(i, start, len)
    s = string(i,pad=6)[start:start+len-1]
    return reverse(s) == s
end

"""
    ispassall(i)

Checks if the integer (i) has the desired properties.

# Arguments
- `i`: integer.
"""
function ispassall(i)
    return (haspalindrome(i, 3, 4) && !haspalindrome(i, 2, 5) && !haspalindrome(i, 1, 6)) &&
    (haspalindrome(i+1, 2, 5) && !haspalindrome(i+1, 1, 6)) &&
    (haspalindrome(i+2, 2, 4) && !haspalindrome(i+2, 2, 5) && !haspalindrome(i+2, 1, 5) && !haspalindrome(i+2, 1, 6)) && 
    haspalindrome(i+3, 1, 6)
end

"""
Enumerate the six-digit numbers and print any winners.
"""
function odemeter()
    for i in 0:999996
        ispassall(i) && println(i)
    end
end

end
