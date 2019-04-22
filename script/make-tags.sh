#!/bin/bash 

echo "ctags: taging"
find . -type f -name "*.[ch]" | sort -f | xargs ctags --C-kinds=+p --fields=+aS --extra=+q

echo "cscope: cross referencing"
cscope -Rbq

echo "find: finding files"
find . -not -regex '.*\.\(png\|gif\|html\|f\|java\)' -type f -name "*.[ch]" -printf "%f\t%p\t1\n" | sort -f > filenametags

echo "done"

