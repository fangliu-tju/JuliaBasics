"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Dofour

"""
Runs a function twice.

func: function object
arg: argument passed to the function
"""
function dotwice(func, arg)
    func(arg)
    func(arg)
end

"""
Prints the argument twice.

arg: anything printable
"""
function printtwice(arg)
    println(arg)
    println(arg)
end

"""
Runs a function four times.

func: function object
arg: argument passed to the function
"""
function dofour(func, arg)
    dotwice(func, arg)
    dotwice(func, arg)
end

dotwice(println, "spam")
dofour(println, "spam")

end

