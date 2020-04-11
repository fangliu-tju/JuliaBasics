"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Flower

using Luxor

"""
    arc(t, r, angle)

Draws an arc with the given radius and angel.

# Arguments
- `t::Turtle`: turtle
- `r::Real`:radius
- `angle::Real`: angle subtended by the arc, in degrees
"""
function arc(t, r, angle)
    arc_len = 2π * r * abs(angle) / 360
    n = trunc(arc_len / 4) + 3
    step_len = arc_len / n
    step_angle = angle / n

    # making a slight left turn before starting reduces
    # the error caused by the linear approximation of the arc
    Turn(t, -step_angle/2)
    polyline(t, n, step_len, step_angle)
    Turn(t, step_angle/2)
end

"""
    polyline(t, n, len, angle)

Draws n line segments with the given length and
angle (in degrees) between them.

# Arguments
- `t::Turtle`: Turtle object
- `n::Integer`: number of line segments
- `len::Real`: length of each segment
- `angle::Real`: degrees between segments
"""
function polyline(t, n, len, angle)
    for _ in 1:n
        Forward(t, len)
        Turn(t, -angle)
    end
end

"""
    petal(t, r, angle)

Draws a petal using two arcs.

# Arguments
- `t::Turtle`: Turtle
- `r::Real`: radius of the arcs
- `angle::Real`: angle (degrees) that subtends the arcs
"""
function petal(t, r, angle)
    for _ in 1:2
        arc(t, r, angle)
        Turn(t, -180+angle)
    end
end

"""
    flower(t, n, r, angle)
Draws a flower with n petals.

# Arguments
- `t::Turtle`: Turtle
- `n::Integer`: number of petals
- `r::Real`: radius of the arcs
- `angle::Real`: angle (degrees) that subtends the arcs
"""
function flower(t, n, r, angle)
    for i in 1:n
        petal(t, r, angle)
        Turn(t, -360.0/n)
    end
end

"""
    move(t, len)

Move Turtle (t) forward (len) units without leaving a trail.
    Leaves the pen down.

# Arguments
- `t::Turtle`: turtle object
- `len::Real`: length of turtle movement with penup
"""
function move(t, len)
    Penup(t)
    Forward(t, len)
    Pendown(t)
end


bob = Turtle()

# draw a sequence of three flowers, as shown in the book.
@svg begin
    move(bob, -130)
    flower(bob, 7, 60.0, 60.0)
    move(bob, 130)
    flower(bob, 10, 40.0, 80.0)
    move(bob, 130)
    flower(bob, 20, 140.0, 20.0)
end

end 
