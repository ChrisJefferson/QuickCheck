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

_QC.defaultConfig := rec(tests := 500, limit := 9, ramp:= 30, seed := 1);

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

InstallGlobalFunction(QC_SetConfig,
    function(config)
        _QC.defaultConfig := _QC.fillConfig([config]);
    end);

InstallGlobalFunction(QC_GetConfig, {} -> ShallowCopy(_QC.defaultConfig));

InstallGlobalFunction(QC_LastFailure, {} -> _QC.LastFailure);

_QC.LastFailure := false;

_QC.Check := function(argtypes, func, configarg...)
        local testCount, skipCount, args, rg, call, ret, config, testSize;

        config := _QC.fillConfig(configarg);

        rg := RandomSource(IsMersenneTwister, config.seed);

        testCount := 0;
        skipCount := 0;
        while testCount < config.tests and skipCount < config.tests * 100 do
            # start with smaller sized tests
            testSize := Minimum(Int(testCount/config.ramp)+1, config.limit);
            args := List(argtypes, {a} -> QC_MakeRandomArgument(a, rg, testSize));
            _QC.LastFailure.args := StructuralCopy(args);
            ret := CallFuncListWrap(func, StructuralCopy(args));
            if IsEmpty(ret) then
                PrintFormatted("Test {} of {} did not return a value", testCount, config.tests);
                return false;
            fi;

            ret := ret[1];

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
end;

InstallGlobalFunction(QC_Check,
    function(argtypes, func, configarg...)
        local ret, savefailure;
        savefailure := _QC.LastFailure;
        _QC.LastFailure := rec(func := func);
        ret := CallFuncList(_QC.Check, Concatenation([argtypes, func], configarg));
        if ret then
            _QC.LastFailure := savefailure;
        fi;
        return ret;
end);


InstallGlobalFunction(QC_CheckEqual,
    function(argtypes, funcL, funcR, configarg...)
        local funccheck, ret, savefailure;
        
        savefailure := _QC.LastFailure;
        _QC.LastFailure := rec(funcs := [funcL, funcR]);

        funccheck := function(args...)
            local retL, retR;
            retL := CallFuncListWrap(funcL, StructuralCopy(args));
            retR := CallFuncListWrap(funcR, args);
            if retL = QC_Skip or retL = QC_Skip then
                return QC_Skip;
            fi;

            if IsEmpty(retL) or IsEmpty(retR) then
                return "A least one function did no return a value";
            fi;

            retL := retL[1];
            retR := retR[1];

            if retL = retR then
                return true;
            fi;
            return StringFormatted("Return values differ: {} and {}", retL, retR);
        end;
        ret := CallFuncList(_QC.Check, Concatenation([argtypes, funccheck], configarg));
        if ret then
            _QC.LastFailure := savefailure;
        fi;
        return ret;
end);
