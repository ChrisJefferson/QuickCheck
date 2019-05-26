gap> QC_CheckEqual([IsPermGroup, IsPermGroup], Intersection, Group(Intersection(AsList(g), AsList(h))));;
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPerm], {g,h,p} -> Intersection(g,h)^p, {g,h,p} -> Intersection(g^p, h^p));;
gap> QC_CheckEqual([IsPermGroup, IsPermGroup, IsPermGroup], {g1, g2, g3} -> Intersection(Intersection(g1,g2),g3), {g1,g2,g3} -> Intersection(g1,Intersection(g2,g3)));
