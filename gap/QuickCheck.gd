#
# QuickCheck: Randomised Testing for GAP Functions
#
#! @Chapter Introduction
#!
#! QuickCheck is a package which tests a function by giving it
#! many randomly generated inputs. It can either check one function returns
#! 'true', or check two functions return the same value.
#!
#! It is designed to provide a fast way to test a function with many inputs,
#! including "boring" (but easy to get wrong) cases, such as empty lists, or the
#! identity group.
#!
#! @Chapter Tutorial
#!
#! @Chapter Functionality
#!
#!
#! @Section Methods
#!
#! This section will describe the example
#! methods of QuickCheck


#! @Description
#! Create a random object as described by
#! <A>ObjectDescription</A> of size at most <A>limit</A>
#! using <A>RandomSource</A>. How <A>limit</A> is interpreted
#! will vary depending on the type of object.
#! Arguments ObjectDescription, RandomSource, limit
DeclareGlobalFunction("QC_MakeRandomArgument");


#! @Description
#! Run tests on <A>function</A>, whose arguments are described
#! in <A>arguments</A>.
#! Arguments arguments, function[, config]
DeclareGlobalFunction("QC_Check");

#! @Description
#! Check that, given the same list of arguments, functionL and functionR
#! return the same value.
#! in <A>arguments</A>.
#! Arguments arguments, functionL, functionR[, config]
DeclareGlobalFunction("QC_CheckEqual");

#! @Description
#! Return the function called, and arguments given, last time a QuickCheck
#! test failed.
#!
#! Returns a record containing `args` (the arguments) and a function `func`
#! (if `QC_Check` failed) or a list of functions `funcs` (if `QC_CheckEqual` failed).
#! Returns `false` if no test has failed.
DeclareGlobalFunction("QC_LastFailure");


#! @Description
#! Rerun the last test which failed. This is most useful of a test in a '.tst' file
#! failed, as this will allow the test to enter the break loop.
DeclareGlobalFunction("QC_RerunLastFailure");

#! @Description
#! Set config options for QuickCheck globally, by passing a record. It is not required
#! to set all options.
#!
#! Current options are:
#!  * <C>tests</C>: Number of tests to run
#!  * <C>limit</C>: The size of the largest object to create
#!  * <C>seed</C>: Initial random seed
#!
#! Arguments  config
DeclareGlobalFunction("QC_SetConfig");


#! @Description
#! Get the current global configuration for QuickCheck, as a record
DeclareGlobalFunction("QC_GetConfig");


## For private data
_QC := rec();
