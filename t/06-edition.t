#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( edition new computed_edition ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->edition( '2' );
is( $code->edition, '2', 'Checking if the edition stored is correct' );
is( $code->computed_edition, '2', 'Checking if the computed edition is correct' );
is( length( $code->computed_edition ), 1, 'Checking the size of a computed edition' );

done_testing( 6 );
