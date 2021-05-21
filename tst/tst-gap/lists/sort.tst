gap> RetWrap := function(f) 
>    return function(l...)
>               CallFuncListWrap(f, l);
>               return l[1];
>           end;
>  end;;
gap> RetSort := RetWrap(Sort);;
gap> QC_CheckEqual([ QC_ListOf(IsInt) ], RetSort, {l} -> RetSort(l, {x,y} -> (x < y)));;
gap> QC_CheckEqual([ QC_ListOf(IsPermGroup) ], RetSort, {l} -> RetSort(l, {x,y} -> (x < y)));;
