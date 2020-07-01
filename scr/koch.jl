"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/koch.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

using Luxor

"""
    koch(t, n)

Draws a koch curve with length n.    

# Arguments
- `t::Turtle`: turtle
- `n`: length of koch curve.
"""
function koch(t, n)
    if n < 3
        Forward(t, n)
        return
    end
    m = n / 3.0
    koch(t, m)
    Turn(t, -60)
    koch(t, m)
    Turn(t, 120)
    koch(t, m)
    Turn(t, -60)
    koch(t, m)
end

"""
    snowflake(t, n)

Draws a snowflake (a triangle with a Koch curve for each side).
# Arguments
- `t::Turtle`: turtle
- `n`: length of koch curve.
"""
function snowflake(t, n)
    
    for _ in 1:3
        koch(t, n)
        Turn(t, 120)
    end
end

function antikoch(t, n)
    if n < 3
        Forward(t, n)
        return
    end
    m = n / 3.0
    antikoch(t, m)
    Turn(t, 60)
    antikoch(t, m)
    Turn(t, -120)
    antikoch(t, m)
    Turn(t, 60)
    antikoch(t, m)
end

function antisnowflake(t, n)
    
    for _ in 1:3
        antikoch(t, n)
        Turn(t, 120)
    end
end

function flowkoch(t, n)
    if n < 3
        Forward(t, n)
        return
    end
    m = n / sqrt(7.0)
    flowkoch(t, m)
    Turn(t, -60)
    flowkoch(t, m)
    Turn(t, 60)
    flowkoch(t, m)
end

function flowsnake(t, n)
    
    for _ in 1:6
        flowkoch(t, n)
        Turn(t, 60)
    end
end

@svg begin
    bob = Turtle();

    Penup(bob)
    Forward(bob, -250)
    Pendown(bob)

    snowflake(bob, 100)

    Penup(bob)
    Turn(bob, -90)
    Forward(bob, 25)
    Turn(bob, 90)
    Forward(bob, 120)

    Pendown(bob)

    antisnowflake(bob, 120)

    Turn(bob, 90)
    Penup(bob)
    Forward(bob, 50)
    Turn(bob, -90)
    Forward(bob, 150)
    Pendown(bob)

    flowsnake(bob, 55)
end
