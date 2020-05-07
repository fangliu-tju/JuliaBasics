"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
https://github.com/llffyy2971/JuliaBasics/tree/master/scr/Ntimesday.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Ntimesday

using Dates

isbday(day, bday) = monthday(day) == monthday(bday)
isbday(bday) = Base.Fix2(isbday, bday)

function ntimesday(bd1, bd2, n)
    bd1 = Dates.date2epochdays(bd1)
    bd2 = Dates.date2epochdays(bd2)
    bdmin, bdmax = minmax(bd1, bd2)
    ntsd = (n * bdmax - bdmin) ÷ (n - 1)
    ntsd = Dates.epochdays2date(ntsd)
end


function main()
    println("Today's date and the day of the week:")
    td = today()
    print("$td is $(dayname(td)).")

    print("\nEnter your birthday in y-m-d format: ")
    s = readline()
    df = DateFormat("y-m-d")
    bday = Date(s, df)
    
    next_bday = tonext(isbday(bday), td)
    
    age = year(td) - year(bday)
    days = Dates.value(next_bday) - Dates.value(td)
    hours = days * 24
    minutes = hours * 60
    seconds = minutes * 60
    print("You are $age old. And there are $days days or $hours hours or $minutes minutes or $seconds seconds untile you next birthday.")

    print("\nEnter first birthday in y-m-d format: ")
    s1 = readline()
    bd1 = Date(s1, df)
    print("\nEnter second birthday in y-m-d format: ")
    s2 = readline()
    bd2 = Date(s2, df)
    print("\nEnter an integer for n times day: ")
    s3 = readline()
    n = parse(Int, s3)
    
    ntsd = ntimesday(bd1, bd2, n)
    println("The $n times day of $bd1 and $bd2 is $ntsd.")

end

main()

end

