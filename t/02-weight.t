#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( weight new ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->title( 'Perl Programming' );
is( $code->weight, 16, 'Checking if the weight stored is correct' );
is( $code->computed_weight, 6, 'Checking if the computed weight is correct' );
is( length( $code->computed_weight ), 1, 'Checking the size of a computed weight' );

done_testing( 6 );
