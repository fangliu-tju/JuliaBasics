"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Spiral

using Luxor

"""
    draw_spiral(t, n, len=3, a=0.1, b=0.0002)

Draws an Archimedian spiral starting at the origin.    

# Arguments
- `t::Turtle`: turtle
- `n`: how many line segments to draw
- `len`: how long each segment is
- `a`: how loose the initial spiral starts out (larger is looser)
- `b`: how loosly coiled the spiral is (larger is looser)

http://www.2dcurves.com/spiral/spiral.html
"""
function draw_spiral(t, n, len=3, a=0.1, b=0.0002)
    
    theta = 0.0

    for _ in 1:n
        Forward(t, len)
        dtheta = 1 / (a + b * theta)

        Turn(t, dtheta)
        theta += dtheta
    end
end

# create the world and bob
bob = Turtle();
@svg draw_spiral(bob, 250)

end
