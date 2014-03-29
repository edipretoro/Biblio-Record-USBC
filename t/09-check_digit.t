#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( new computed_check_digit ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->language( '');
$code->date( '' );
$code->title( '' );
$code->edition( '' );
$code->volume( '' );
$code->publisher( '' );

is( $code->computed_check_digit, '1', 'Checking if the computed check digit is correct' );
is( length( $code->computed_check_digit ), 1, 'Checking the size of a computed check digit' );

done_testing( 5 );
