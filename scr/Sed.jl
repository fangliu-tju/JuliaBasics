"""
This module contains a code example related to

Think Julia, 2nd Edition
by Fang Liu
http://

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""
module Sed

"""
    sed(pat, rep, source, dest)

Reads a source file and writes the destination file.

In each line, replaces pattern with replace.

# Arguments
- `pat`: string.
- `rep`: string.
- `source`: string filename.
- `dest`: string filename.
"""
function sed(pat, rep, source, dest)
    fin = open(source, "r")
    fout = open(dest, "w")

    try
        for line in eachline(fin, keep=true)
            line = replace(line, pat => rep)
            write(fout, line)
        end
    catch exc
        error(exc)
    finally
        close(fin)
        close(fout)
    end
end

pat= "pattern";
rep = "replace";
source = "sed_tester.txt";
dest = source * "replaced";
sed(pat, rep, source, dest);

end