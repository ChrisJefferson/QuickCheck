#
# QuickCheck: Randomised Testing for GAP Functions
#
#! @Chapter Introduction
#!
#! QuickCheck is a package which does some
#! interesting and cool things
#!
#! @Chapter Functionality
#!
#!
#! @Section Example Methods
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
#! Arguments arguments, functionL, functionR,[, config]

DeclareGlobalFunction("QC_CheckEqual");


## For private data
_QC := rec();
