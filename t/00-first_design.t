#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my $usbc = get_usbc();
ok( length( $usbc ) == 16, 'A USBC code a string of 16 characters' );
my @chars = split( '', $usbc );
ok( $chars[0] =~ m/\d/, 'The first character of a USBC is a number' );
ok( $chars[1] =~ m/\d/, 'The second character of a USBC is a number' );
ok( $chars[2-4] =~ m/\d{3}/, 'The third to sixth characters of a USBC are numbers' );

sub get_usbc {
    return '11' . ' ' x 14;
}

done_testing( 3 );
