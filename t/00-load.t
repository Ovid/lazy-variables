#!/usr/bin/env perl

use lib 'lib';
use Test::Most;

use Lazy::Variables ();

pass "We were able to lood our primary modules";

diag "Testing Lazy::Variables Lazy::Variables:VERSION, Perl $], $^X";

done_testing;
