#
# QuickCheck: Randomised Testing for GAP Functions
#
# This directory aims to test GAP, rather than the QuickCHeck
# Package.
#
LoadPackage( "QuickCheck" );

TestDirectory(DirectoriesPackageLibrary( "QuickCheck", "tst-gap" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
