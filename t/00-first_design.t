#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my $usbc = get_usbc();
ok( length( $usbc ) == 18, 'A USBC code a string of 16 characters' );
my @chars = split( '', $usbc );
ok( $chars[0] =~ m/\d/, 'The first character of a USBC is a number' );
ok( $chars[1] =~ m/\d/, 'The second character of a USBC is a number' );
ok( substr( $usbc, 2, 3 ) =~ m/\d{3}/, 'The third to sixth characters of a USBC are numbers' );
ok( substr( $usbc, 5, 7 ) =~ m/[[:alpha:]]{7}/, 'The seventh to fourteenth characters of a USBC are alphanumerics' );
ok( substr( $usbc, 12, 1) =~ m/\d/, 'The fifteenth character of a USBC is a number' );
ok( substr( $usbc, 13, 2) =~ m/\d{2}/, 'The sixteenth to eighteenth characters of a USBC are numbers' );

sub get_usbc {
    return '11111aaaaaaa1' . ' ' x 5;
}

done_testing( 7 );
