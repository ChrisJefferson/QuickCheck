gap> QC_CheckEqual([IsPermGroup, IsPermGroup], Intersection, {g,h} -> Group(Intersection(AsList(g), AsList(h))));
true
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPerm], {g,h,p} -> Intersection(g,h)^p, {g,h,p} -> Intersection(g^p, h^p));
true
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPermGroup], {g1, g2, g3} -> Intersection(Intersection(g1,g2),g3), {g1,g2,g3} -> Intersection(g1,Intersection(g2,g3)));
true
gap> QC_Check([IsCyclic], {g} -> IsCyclic(g));
true
gap> QC_Check([QC_ElementOf(AlternatingGroup(7))], {p} -> LargestMovedPoint(p) <= 7);
true
gap> perf := InfoLevel(InfoPerformance);;
gap> SetInfoLevel(InfoPerformance, 0);;
gap> QC_Check([IsPermGroup, IsPermGroup], 
> function(g,u)
> local e;
> if not IsSubgroup(g,u) then
>  return QC_Skip;
> fi;
> e := IntermediateGroup(g,u);
> if e <> fail then
>  return e <> g and e <> u and IsSubgroup(g,e) and IsSubgroup(e,u);
> fi;
> return true;
> end);
true
gap> SetInfoLevel(InfoPerformance, perf);;
gap> QC_Check([IsPermGroup, IsPerm],
> function(g,p)
> local ng;
> ng := ClosureGroup(g,p);
> if p in g then
>   return g = ng;
> fi;
> return IsSubgroup(ng,g) and p in ng;
> end);
true