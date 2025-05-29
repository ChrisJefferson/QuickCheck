gap> LoadPackage("quickcheck", false);
true
gap> QC_CheckEqual([IsInt, IsInt], {x,y} -> x - y, {x,y} -> x + y*(-1));
true
gap> QC_CheckEqual([IsInt, IsInt], {x,y} -> x + y, {x,y} -> y + x);
true
gap> QC_CheckEqual([IsInt, IsInt, IsInt], {x,y,z} -> (x + y) + z, {x,y,z} -> x + (y + z));
true
gap> QC_CheckEqual([IsPosInt, IsPosInt], {x,y} -> x * y, {x,y} -> y * x);
true
gap> QC_CheckEqual([IsInt, IsInt, IsInt], {x,y,z} -> x * (y + z), {x,y,z} -> x*y + x*z);
true
gap> QC_CheckEqual([IsPosInt, IsPosInt], {x,y} -> x ^ y, {x,y} -> Product([1..y], i -> x));
true
gap> QC_CheckEqual([IsRat, IsRat], 
> function(x,y) if y = 0 then return QC_Skip; else return x/y * y; fi; end,
> {x,y} -> x);
true
gap> QC_CheckEqual([IsPosRat, IsPosRat], {x,y} -> 1/(x*y), {x,y} -> (1/x) * (1/y));
true
gap> QC_Check([IsPosInt, IsNegInt], {x,y} -> x^y * x^(-y) = 1);
true
gap> QC_Check([IsRat, IsRat, IsRat], {x,y,z} -> (x+y)+z = x+(y+z));
true
gap> QC_Check([IsNegRat, IsPosRat], {x,y} -> x < y);
true
