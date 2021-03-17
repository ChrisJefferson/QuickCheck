
QC_RegisterFilterGen(IsInt, {rg, limit} -> Random(rg, [-limit..limit]));
QC_RegisterFilterGen(IsPosInt, {rg, limit} -> Random(rg, [1..limit]));
QC_RegisterFilterGen(IsNegInt, {rg, limit} -> Random(rg, [-limit..-1]));
QC_RegisterFilterGen(IsEvenInt, {rg, limit} -> Random(rg, [-limit*2,-(limit-1)*2..limit*2]));
QC_RegisterFilterGen(IsOddInt, {rg, limit} -> Random(rg, [-limit*2-1,-(limit-1)*2-1..limit*2-1]));
QC_RegisterFilterGen(IsPerm, {rg, limit} -> Random(rg, SymmetricGroup(limit)));
QC_RegisterFilterGen(IsTransformation, function(rg, limit)
    local len;
    len := Random(rg, [1..limit]);
    return Transformation([1..len], x -> Random(rg, [1..len]));
    end);

# TODO: Improve greatly
QC_RegisterFilterGen(IsPermGroup, function(rg, limit)
    local size, ret;
    size := Random(rg, [1..limit]);
    if size = 1 then
        ret := SymmetricGroup(1);
    elif Random(rg, [1..5]) = 1 then
        ret := PrimitiveGroup(size, Random(rg, [1..NrPrimitiveGroups(size)]));
    else
        ret := TransitiveGroup(size, Random(rg, [1..NrTransitiveGroups(size)]));
    fi;

    # Want to remove name, for useful printing
    return Group(GeneratorsOfGroup(ret),());
end);

QC_ListOf := function(object)
    return function(rg, limit)
        return List([1..Random([1..limit])], {x} -> QC_MakeRandomArgument(object, rg, limit));
    end;
end;

QC_FixedLengthListOf := function(object, length)
    return function(rg, limit)
        return List([1..length], {x} -> QC_MakeRandomArgument(object, rg, limit));
    end;
end;

QC_PairOf := {o} -> QC_FixedLengthListOf(o, 2);


QC_SetOf := function(object)
    return function(rg, limit)
        local set, targetsize, testlimit;
        targetsize := Random([1..limit]);
        set := [];
        # In case we have trouble filling the set, put a limit on number of tests
        testlimit := targetsize * limit + 10;
        while Size(set) < targetsize and testlimit > 0 do
            AddSet(set, QC_MakeRandomArgument(object, rg, limit));
            testlimit := testlimit - 1;
        od;
        return set;
    end;
end;


QC_RegisterFilterGen(IsCyclic, {rg, limit} -> CyclicGroup(Random(rg, [1..limit])));
QC_RegisterFilterGen(IsFreeAbelian, {rg, limit} -> FreeAbelianGroup(Random(rg, [1..limit])));