"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/tree/master/scr/circle.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

struct Point
    x
    y
end

"""
Represents a rectangle.

fields: width, height, corner.
"""
struct Rectangle
    width
    height
    corner
end

"""
Represents a circle.

Attributes: radius, center.
"""
struct Circle
    radius
    center
end

"""
    distance_between_points(point1, point2)

Finds the distance between two points.

# Arguments
- 'point1': Point.
- 'point2': Point.
"""
function distance_between_points(point1, point2)
    dis = sqrt((point1.x - point2.x)^2 + (point1.y - point2.y)^2)
end

"""
    pointincircle(circle, point)

Checks whether a point lies inside a circle (or on the boundary).

# Arguments
- 'circle': Circle.
- 'point': Point.
"""
function pointincircle(circle, point)
    d = distance_between_points(circle.center, point)
    d <= circle.radius
end

"""
    rectincircle(circle, rect)

Checks whether the corners of a rect fall in/on a circle.

# Arguments
- 'circle': Circle.
- 'rect': Rectangle.
"""
function rectincircle(circle, rect)
    pointincircle(circle, rect.corner) || return false # left bottom corner
    pointincircle(circle, Point(rect.corner.x + rect.width, rect.corner.y)) || return false # right bottom corner
    pointincircle(circle, Point(rect.corner.x, rect.corner.y + rect.height)) || return false # left top corner
    pointincircle(circle, Point(rect.corner.x + rect.width, rect.corner.y + rect.height)) || return false # right top corner
    return true
end

"""
    rectcircleoverlap(circle, rect)

Checks whether any part of a rect fall in/on a circle.

# Arguments
- 'circle': Circle.
- 'rect': Rectangle.
"""
function rectcircleoverlap(circle, rect)
    for x in range(rect.corner.x, rect.corner.x+rect.width, length=101)
        for y in range(rect.corner.y, rect.corner.y+rect.height, length=101)
            point = Point(x,y)
            pointincircle(circle, point) && return true
        end
    end
    return false
end


corner = Point(50.0, 50.0);
width = 100.0;
height = 200.0;
box = Rectangle(width, height, corner)

center = Point(150.0, 100.0);
radius = 75.0;
circle = Circle(radius, center);

pointincircle(circle, box.corner)
rectincircle(circle, box)
rectcircleoverlap(circle, box)
