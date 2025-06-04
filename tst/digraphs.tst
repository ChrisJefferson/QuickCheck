gap> LoadPackage("digraphs", false);
true
gap> LoadPackage("quickcheck", false);
true
gap> QC_CheckEqual([IsDigraph], DigraphHasLoops, {d} -> DigraphLoops(d) <> []);
true
gap> QC_Check([IsDigraph], function(d) local a; a := DigraphDiameter(d); return a = fail or a <= DigraphNrVertices(d); end);
true
gap> QC_Check([IsDigraph], {d} -> IsList(DigraphMaximalClique(d)));
true