#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( publisher new computed_publisher ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->publisher( 'O\'Reilly' );
is( $code->publisher, 'O\'Reilly', 'Checking if the publisher stored is correct' );
is( $code->computed_publisher, 'E', 'Checking if the computed publisher is correct' );
is( length( $code->computed_publisher ), 2, 'Checking the size of a computed publisher' );

done_testing( 6 );
