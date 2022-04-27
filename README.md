# README.md of fsort #

## 1. Usage ##

Only the source code **fsort.f90** is provided, so please compile it yourself.
An example of usage is provided as **test.f90** with a **Makefile**, please follow this instruction.

Simply, for the generation of the library of fsort, just modify the `SHELL` variable and some variables below, then type the command `make`.
For building the executable **test.exe**, please type the command `make test`.

The default is to sort in the ascending sequence, if you want to use the descending sequence, please replace all `.lt.` to `.gt.` om fsort.f90 and recompile it.

The default is to sort the real(kind=8) kind variables, if you want to use other kinds, e.g. integer(kind=4), you can replace all `real(kind=8)` to `integer(kind=4)` and recompile it.

If you want to use a user-defined type, e.g. type :: mytype, please uncomment the `type :: mytype` paragraph (for defining the structure type), the `interface operator(.lt.)` paragraph (for providing a compare method), then replace all `real(kind=8)` except those in the defination of `type :: mytype` to `type(mytype)` and recompile it.

## 2. Algorithm ##

There are 2 constants defined in **fsort.f90**: `low_threshold = 8` and `high_threshold = 8192`.

If the size of the array is lower than or equal to `low_threshold`, the insert sort method, instead of the general quick sort method, will be used, because althouth the average time complexity of insert sort is O(N^2) that seems greater than O(NlogN) of quick sort, when the size is really small, the insert method is actually faster.

If the size of the array is greater than `low_threshold` but lower than `high_threshold`, then the quick method will be used. For most situations this is the fastest method, but it is based on a recursive method and its space complexity is O(logN), so if the recursion is too deep there may cause stack overflow, hence if the size of the array is greater than or equal to `high_threshold`, the heap sort method will be used instead. This is usually slower than quick sort method for common data, but it will never meet the stack size limitation as it is a non-recursive algorithm with a O(1) space complexity, and also since its worst time complexity is O(NlogN) (where the worst time complexity of quick sort is O(N^2)), this will never cost too much time for a quite huge array even if the worst situation occured, as long as you can afford a O(NlogN) time complexity.

