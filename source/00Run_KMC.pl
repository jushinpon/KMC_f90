=b
convert f77 to f90 or f95
=cut
use warnings;
use strict;
use Data::Dumper;
use Cwd;
use POSIX;
system("gfortran -o KMC.x KMC.f90 2>&1");
system("./KMC.x") unless ($?);