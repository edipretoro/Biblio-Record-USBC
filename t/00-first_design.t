#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my $usbc = get_usbc();
ok( length( $usbc ) == 16, 'A USBC code a string of 16 characters' );
my @chars = split( '', $usbc );
ok( $chars[0] =~ m/\d/, 'The first character of a USBC is a number' );

sub get_usbc {
    return ' ' x 16;
}

done_testing( 1 );
