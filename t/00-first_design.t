#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
}

my $record = new_ok( 'Biblio::Record::USBC' );
my $usbc = $record->get_usbc();

ok( length( $usbc ) == 18, 'A USBC code a string of 16 characters' );
ok( substr( $usbc, 0, 1 ) =~ m/\d/, 'The first character of a USBC is a number' );
ok( substr( $usbc, 1, 1 ) =~ m/\d/, 'The second character of a USBC is a number' );
ok( substr( $usbc, 2, 3 ) =~ m/\d{3}/, 'The third to sixth characters of a USBC are numbers' );
ok( substr( $usbc, 5, 7 ) =~ m/[[:alpha:]]{7}/, 'The seventh to fourteenth characters of a USBC are alphanumerics' );
ok( substr( $usbc, 12, 1 ) =~ m/\d/, 'The fifteenth character of a USBC is a number' );
ok( substr( $usbc, 13, 2 ) =~ m/\d{2}/, 'The sixteenth to eighteenth characters of a USBC are numbers' );
ok( substr( $usbc, 15, 2 ) =~ m/[[:alpha:]]{2}/, 'Testing the publisher part of a USBC are alphabetics' );
ok( substr( $usbc, 17, 1 ) =~ m/[\d\w]/, 'Testing the check digit part of a USBC are alphanumeric' );

done_testing( 11 );
