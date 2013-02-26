#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( volume new computed_volume ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->volume( '2' );
is( $code->volume, '2', 'Checking if the volume stored is correct' );
is( $code->computed_volume, '02', 'Checking if the computed volume is correct' );
is( length( $code->computed_volume ), 2, 'Checking the size of a computed volume' );

done_testing( 6 );
