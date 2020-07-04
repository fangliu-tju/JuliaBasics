"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/tree/master/scr/findduplicates.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

"""
    walk(dirname)

Finds the names of all files in dirname and its subdirectories.

# Arguments
- 'dirname': string name of directory.
"""
function walk(dirname)
    names = []

    for (root, dirs, files) in walkdir(dirname)
        for file in files
            push!(names, joinpath(root, file))
        end
    end

    names
end

"""
    compute_checksum(filename)

Computes the MD5 checksum of the contents of a file.

# Arguments
- 'filename': string name of file.
"""
function compute_checksum(filename)
    cmd = `md5 $filename`
    res = read(cmd, String)
    first(split(res))
end

"""
    check_diff(name1, name2)

Computes the difference between the contents of two files.

See: http://gnuwin32.sourceforge.net/packages/diffutils.htm

# Arguments
- 'name1': string filename.
- 'name2': string filename.
"""
function check_diff(name1, name2)
    cmd = `diff -q $name1 $name2`
    res = read(cmd, String)
    endswith(res, "diff")
end

"""
    compute_checksums(dirname, suffix)

Computes checksums for all files with the given suffix.

# Arguments
- 'dirname': string name of directory to search.
- `suffix`: string suffix to match.

Returns: map from checksum to array of files with that checksum.
"""
function compute_checksums(dirname, suffix)
    names = walk(dirname)

    d = Dict()
    for name in names
        if endswith(name, suffix)
            res = compute_checksum(name)
            d[res] = push!(get(d, res, []), name)
        end
    end
    return d
end

"""
    check_pairs(names)

Checks whether any in an array of files differs from the others.

# Arguments
- 'names': array of string filenames.
"""
function check_pairs(names)
    for name1 in names
        for name2 in names
            if name1 < name2
                check_diff(name1, name2) && return false
            end
        end
    end
    return true
end

"""
    printduplicates(d)

Checks for duplicate files.

Reports any files with the same checksum and checks whether they
are, in fact, identical.

# Arguments
- 'd': map from checksum to array of files with that checksum.
"""
function printduplicates(d)
    for (key, names) in d
        if length(names) > 1
            print("The following files have the same checksum: ")
            for name in names
                print(name, " ")
            end
            print("\b. ")
            
            if check_pairs(names)
                print("And they are identical.")
            end
        end
    end
end

d = compute_checksums(pwd(),".md");
printduplicates(d) 
