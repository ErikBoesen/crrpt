#!/usr/bin/perl
use strict;
use warnings;

my $fn = $ENV{'HOME'} . '/Desktop/hey';
open(my $f, '>', $fn);
print $f "This came from launching $0!\n";
