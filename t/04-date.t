#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( date new ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->date( 1990 );
is( $code->date, 1990, 'Checking if the date stored is correct' );
is( $code->computed_date, 990, 'Checking if the computed date is correct' );
is( length( $code->computed_date ), 3, 'Checking the size of a computed date' );
$code->date( '[1990]' );
is( $code->date, '[1990]', 'Checking if the date stored is correct' );
is( $code->computed_date, 990, 'Checking if the computed date is correct' );
is( length( $code->computed_date ), 3, 'Checking the size of a computed date' );
$code->date( '1990' );
is( $code->date, '1990', 'Checking if the date stored is correct' );
is( $code->computed_date, 990, 'Checking if the computed date is correct' );
is( length( $code->computed_date ), 3, 'Checking the size of a computed date' );

done_testing( 12 );
