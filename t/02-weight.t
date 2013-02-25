#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( weight new ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->weight( 10 );
is( $code->weight, 10, 'Checking if the weight stored is correct' );

done_testing( 4 );
