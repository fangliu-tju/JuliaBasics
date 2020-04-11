"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Printgrid

# here is a mostly-straightforward solution to the
# two-by-two version of the grid.

function do_twice(f)
    f()
    f()
end

function do_four(f)
    do_twice(f)
    do_twice(f)
end

function print_beam()
    print("+ - - - - ")
end

function print_post()
    print("|         ")
end

function print_beams()
    do_twice(print_beam)
    println("+")
end

function print_posts()
    do_twice(print_post)
    println("|")
end

function print_row()
    print_beams()
    do_four(print_posts)
end

function printgrid()
    do_twice(print_row)
    print_beams()
end

printgrid()
    

# here is a less-straightforward solution to the
# four-by-four grid

function one_four_one(f, g, h)
    f()
    do_four(g)
    h()
end

function print_plus()
    print("+ ")
end

function print_dash()
    print("- ")
end

function print_bar()
    print("| ")
end

function print_space()
    print("  ")
end

function print_end()
    print("\n")
end

function print_nothing()
    nothing
end

function print1beam()
    one_four_one(print_nothing, print_dash, print_plus) # - - - - +
end

function print1post()
    one_four_one(print_nothing, print_space, print_bar) #         |
end

function print4beams()  # + - - - - + - - - - + - - - - + - - - - +
    one_four_one(print_plus, print1beam, print_end) 
end

function print4posts()  # |         |         |         |         |
    one_four_one(print_bar, print1post, print_end)
end

function print_row()
    one_four_one(print_nothing, print4posts, print4beams)
end

function printgrid()
    one_four_one(print4beams, print_row, print_nothing)
end

printgrid()

comment = """
After writing a draft of the 4x4 grid, I noticed that many of the
functions had the same structure: they would do something, do
something else four times, and then do something else once.

So I wrote one_four_one, which takes three functions as arguments; it
calls the first one once, then uses do_four to call the second one
four times, then calls the third.

Then I rewrote print1beam, print1post, print4beams, print4posts,
print_row and print_grid using one_four_one.

Programming is an exploratory process.  Writing a draft of a program
often gives you insight into the problem, which might lead you to
rewrite the code to reflect the structure of the solution.

--- Allen
"""

print(comment)

end