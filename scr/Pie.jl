"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Pie

using Luxor

"""
    drawpie(t, n, r)

Draws a pie, then moves into position to the right.

# Arguments
- `t::Turtle`: the turtle object which for drawing with.
- `n::Integer`: the number of segments to draw.
- `r::Real`: the length of radial spokes.
"""
function drawpie(t, n, r)
    polypie(t, n, r)
    Penup(t)
    Forward(t, 2r+10)
    Pendown(t)
end

"""
Draws a pie divided into radial segments.

t: Turtle
n: number of segments
r: length of the radial spokes
"""
function polypie(t, n, r)
    angle = 360.0 / n
    for _ in 1:n
        isosceles(t, r, angle/2)
        Turn(t, -angle)
    end
end

"""
Draws an icosceles triangle.

The turtle starts and ends at the peak, facing the middle of the base.

t: Turtle
r: length of the equal legs
angle: half peak angle in degrees
"""
function isosceles(t, r, angle)
    y = r * sin(angle * pi / 180)
    Turn(t, angle)
    Forward(t,r)
    Turn(t,-90-angle)
    Forward(t, 2y)
    Turn(t, -90-angle)
    Forward(t, r)
    Turn(t, -180+angle)
end


bob = Turtle()

Penup(bob)
Forward(bob, -150)
Pendown(bob)

# draw polypies with various number of sides
size = 50
@svg begin
    for i in 5:8
        drawpie(bob,i,size)
    end
end

end