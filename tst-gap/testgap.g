#
# QuickCheck: Randomised Testing for GAP Functions
#
# This directory gives a variety of tests for GAP itself, showing
# how QuickCheck can be used in practice.
#
LoadPackage( "QuickCheck" );

TestDirectory(DirectoriesPackageLibrary( "QuickCheck", "tst-gap" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
