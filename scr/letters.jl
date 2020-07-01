"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/blob/master/scr/letters.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

using Luxor

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
    circle(t, r)

Draws a circle with the given radius.

# Arguments
- `t::Turtle: Turtle
- `r::Real`: radius
"""
function circle(t, r)
    arc(t, r, 360)
end

# LEVEL 0 PRIMITIVES 
# fd, bk, lt, rt, pu, pd

function fd(t, len)
    Forward(t, len)
end

function bk(t, len)
    Forward(t, -len)
end

function lt(t, angle=90)
    Turn(t, -angle)
end

function rt(t, angle=90)
    Turn(t, angle)
end

function pd(t)
    Pendown(t)
end

function pu(t)
    Penup(t)
end

# LEVEL 1 PRIMITIVES are simple combinations of Level 0 primitives.
# They have no pre- or post-conditions.

"""
forward and turn left
"""
function fdlt(t, n, angle=90)
    fd(t, n)
    lt(t, angle)
end

"""
forward and back, ending at the original position
"""
function fdbk(t, n)
    fd(t, n)
    bk(t, n)
end

"""
lift the pen and move
"""
function skip(t, n)
    pu(t)
    fd(t, n)
    pd(t)
end

"""
Makes a vertical line and leave the turtle at the top, facing right
"""
function stump(t, n, angle=90)
    lt(t)
    fd(t, n)
    rt(t, angle)
end

"""
move the turtle vertically and leave it at the top, facing right
"""
function hollow(t, n)
    lt(t)
    skip(t, n)
    rt(t)
end

# LEVEL 2 PRIMITIVES use primitives from Levels 0 and 1
# to draw posts (vertical elements) and beams (horizontal elements)
# Level 2 primitives ALWAYS return the turtle to the original
# location and direction.

"""
Makes a vertical line and return to the original position
"""
function post(t, n)
    lt(t)
    fdbk(t, n)
    rt(t)
end

"""
Makes a horizontal line at the given height and return.
"""
function beam(t, n, height)
    hollow(t, n*height)
    fdbk(t, n)
    hollow(t, -n*height)
end

"""
Makes a vertical line to the given height and a horizontal line
at the given height and then return.
This is efficient to implement, and turns out to be useful, but
it's not so semantically clean.
"""
function hangman(t, n, height)
    stump(t, n * height)
    fdbk(t, n)
    lt(t)
    bk(t, n*height)
    rt(t)
end

"""
Makes a diagonal line to the given x, y offsets and return
"""
function diagonal(t, x, y)
    angle = atan(y, x) * 180 / pi
    dist = hypot(x, y)
    lt(t, angle)
    fdbk(t, dist)
    rt(t, angle)
end

function vshape(t, n, height)
    diagonal(t, -n/2, height*n)
    diagonal(t, n/2, height*n)
end

"""
Makes a bump with radius n at height*n 
"""
function bump(t, n, height)
    stump(t, n*height)
    arc(t, n/2.0, 180)
    lt(t)
    fdlt(t, n*height+n)
end


#=
The letter-drawing functions all have the precondition
that the turtle is in the lower-left corner of the letter,
and postcondition that the turtle is in the lower-right
corner, facing in the direction it started in.

They all take a turtle as the first argument and a size (n)
as the second.  Most letters are (n) units wide and (2n) units
high.
=#


function draw_a(t, n)
    diagonal(t, n/2, 2*n)
    skip(t, n/4)
    beam(t, n/2, 2)
    skip(t, 3n/4)
    diagonal(t, -n/2, 2*n)
end

function draw_b(t, n)
    bump(t, n, 1)
    bump(t, n, 0)
    skip(t, n/2)
end

function draw_c(t, n)
    skip(t, n)
    hollow(t, 2n)
    lt(t, 180)
    arc(t, n, 180)
end

function draw_d(t, n)
    bump(t, 2*n, 0)
    skip(t, n)
end

function draw_ef(t, n)
    hangman(t, n, 2)
    hangman(t, n, 1)
end

function draw_e(t, n)
    draw_ef(t, n)
    fd(t, n)
end

function draw_f(t, n)
    draw_ef(t, n)
    skip(t, n)
end

function draw_g(t, n)
    hangman(t, n, 2)
    fd(t, n/2)
    beam(t, n/2, 2)
    fd(t, n/2)
    post(t, n)
end

function draw_h(t, n)
    post(t, 2*n)
    hangman(t, n, 1)
    skip(t, n)
    post(t, 2*n)
end

function draw_i(t, n)
    beam(t, n, 2)
    fd(t, n/2)
    post(t, 2*n)
    fd(t, n/2)
end

function draw_j(t, n)
    beam(t, n, 2)
    arc(t, n/2, 90)
    fd(t, 3*n/2)
    skip(t, -2*n)
    rt(t)
    skip(t, n/2)
end

function draw_k(t, n)
    post(t, 2*n)
    stump(t, n, 180)
    vshape(t, 2*n, 0.5)
    fdlt(t, n)
    skip(t, n)
end

function draw_l(t, n)
    post(t, 2*n)
    fd(t, n)
end

function draw_n(t, n)
    post(t, 2*n)
    skip(t, n)
    diagonal(t, -n, 2*n)
    post(t, 2*n)
end

function draw_m(t, n)
    post(t, 2*n)
    draw_v(t, n)
    post(t, 2*n)
end

function draw_o(t, n)
    skip(t, n)
    circle(t, n)
    skip(t, n)
end

function draw_p(t, n)
    bump(t, n, 1)
    skip(t, n/2)
end

function draw_q(t, n)
    draw_o(t, n)
    diagonal(t, -n/2, n)
end

function draw_r(t, n)
    draw_p(t, n)
    diagonal(t, -n/2, n)
end

function draw_s(t, n)
    fd(t, n/2)
    arc(t, n/2, 180)
    arc(t, n/2, -180)
    fdlt(t, n/2, -90)
    skip(t, 2*n)
    lt(t)
end

function draw_t(t, n)
    beam(t, n, 2)
    skip(t, n/2)
    post(t, 2*n)
    skip(t, n/2)
end

function draw_u(t, n)
    post(t, 2*n)
    fd(t, n)
    post(t, 2*n)
end

function draw_v(t, n)
    skip(t, n/2)
    vshape(t, n, 2)
    skip(t, n/2)
end

function draw_w(t, n)
    draw_v(t, n)
    draw_v(t, n)
end

function draw_x(t, n)
    diagonal(t, n, 2*n)
    skip(t, n)
    diagonal(t, -n, 2*n)
end

function draw_y(t, n)
    skip(t, n/2)
    stump(t, n)
    vshape(t, n, 1)
    rt(t)
    fdlt(t, n)
    skip(t, n/2)
end

function draw_z(t, n)
    beam(t, n, 2)
    diagonal(t, n, 2*n)
    fd(t, n)
end

function draw_(t, n)
    # draw a space
    skip(t, n)
end


# create and position the turtle
size = 10
bob = Turtle()

skip(bob, -280)
@svg for f in [draw_a, draw_b, draw_c, draw_d, draw_e, draw_f, draw_g, draw_h, draw_i, draw_j, draw_k, draw_l, draw_m, draw_n, draw_o, draw_p,draw_q,draw_r, draw_s, draw_t, draw_u, draw_v, draw_w, draw_x, draw_y, draw_z]
    f(bob, size)
    skip(bob, size)
end
