#
# QuickCheck: Randomised Testing for GAP Functions
#
# Implementations
#

QC_Skip := "SKIP TEST";

# Store the generators we support
QC_Filters := [];

QC_RegisterFilterGen := function(filt, func)
    Add(QC_Filters, [filt, func]);
end;


InstallGlobalFunction(QC_MakeRandomArgument,
    function(object, rg, limit)
        local pos;
        # Handle filter case
        if IsFilter(object) then
            pos := PositionProperty(QC_Filters, {f} -> object=f[1]);
            if pos = fail then
                ErrorNoReturn("Filter with no random generator: ", object);
            fi;
            return QC_Filters[pos][2](rg, limit);
        fi;

        if IsFunction(object) then
            return object(rg, limit);
        fi;
    end);

_QC.defaultConfig := rec(tests := 100, limit := 9, seed := 1);

_QC.fillConfig := function(configlist)
    local r, retval, config;
    if Length(configlist) > 1 then
        ErrorNoReturn("Too many arguments to QC_Check");
    fi;

    retval := StructuralCopy(_QC.defaultConfig);

    if Length(configlist) = 1 then
        config := configlist[1];
        for r in RecNames(config) do
            if not IsBound(retval.(r)) then
                ErrorNoReturn("Invalid option: ", r);
            fi;
            retval.(r) := config.(r);
        od;
    fi;
    return retval;
end;

InstallGlobalFunction(QC_Check,
    function(argtypes, func, configarg...)
        local testCount, skipCount, args, rg, call, ret, config;

        config := _QC.fillConfig(configarg);

        rg := RandomSource(IsMersenneTwister, config.seed);

        testCount := 0;
        skipCount := 0;
        while testCount < config.tests and skipCount < config.tests * 100 do
            args := List(argtypes, {a} -> QC_MakeRandomArgument(a, rg, config.limit));
            ret := CallFuncList(func, StructuralCopy(args));
            if ret = QC_Skip then
                skipCount := skipCount + 1;
            elif ret <> true then
                PrintFormatted("Test {} of {} failed:\n", testCount, config.tests);
                Print(" Input: ", args,"\n");
                Print(" Output: ", ret,"\n");
                return false;
            else
                testCount := testCount + 1;
            fi;
        od;
        if testCount < config.tests then
            PrintFormatted("Too many tests skipped. Only managed {} out of {} tests", testCount, config.tests);
            return false;
        fi;
        return true;
end);

InstallGlobalFunction(QC_CheckEqual,
    function(argtypes, funcL, funcR, configarg...)
        local funccheck;

        funccheck := function(args...)
            local retL, retR;
            retL := CallFuncList(funcL, StructuralCopy(args));
            retR := CallFuncList(funcR, args);
            if retL = QC_Skip or retL = QC_Skip then
                return QC_Skip;
            fi;
            if retL = retR then
                return true;
            fi;
            return StringFormatted("Return values differ: {} and {}", retL, retR);
        end;
        return CallFuncList(QC_Check, Concatenation([argtypes, funccheck], configarg));
end);
