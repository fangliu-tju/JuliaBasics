"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
https://github.com/llffyy2971/JuliaBasics/tree/master/scr/Draw.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Draw

using Luxor

struct MyPoint
    x
    y
end

"""
Represents a rectangle.

fields: width, height, corner.
"""
struct MyRectangle
    width
    height
    corner
end

"""
Represents a circle.

Attributes: radius, center.
"""
struct MyCircle
    radius
    center
end

"""
    drawrect(t, myrect)

Draws a rectangle.

# Arguments
- `t::Turtle`: Turtle
- `myrect::MyRectangle`: Rectangle.
"""
function drawrect(t, myrect)
    Reposition(t, myrect.corner.x, myrect.corner.y)
    for len = (myrect.width, myrect.height, myrect.width, myrect.height)
        Forward(t, len)
        Turn(t, -90)
    end
end

"""
    drawcircle(t, mycircle)

Draws a circle.

# Arguments
- `t::Turtle`: Turtle
- `mycircle::MyCircle`: Circle.
"""
function drawcircle(t, mycircle)
    Reposition(t, mycircle.center.x, mycircle.center.y+radius)
    circle(t, mycircle.radius)
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
    arc(t, r, angle)

Draws an arc with the given radius and angle.

# Arguments
- `t::Turtle`: turtle
- `r::Real`:radius
- `angle::Real`: angle subtended by the arc in degrees
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
    circle(t, r)

Draws a circle with the given radius.

# Arguments
- `t::Turtle: Turtle
- `r::Real`: radius
"""
function circle(t, r)
    arc(t, r, 360)
end


bob = Turtle()

corner = MyPoint(50.0, -50.0);
width = 100.0;
height = 200.0;
rec = MyRectangle(width, height, corner)

center = MyPoint(150.0, -100.0);
radius = 75.0;
cir = MyCircle(radius, center);

@svg begin
    drawrect(bob, rec)
    drawcircle(bob, cir)
end


end