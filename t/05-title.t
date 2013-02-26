#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( title new computed_title ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->title( 'E' );
is( $code->title, 'E', 'Checking if the title stored is correct' );
is( $code->computed_title, 'E000000', 'Checking if the computed title is correct' );
is( length( $code->computed_title ), 7, 'Checking the size of a computed title' );

done_testing( 6 );
