#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
};

can_ok( 'Biblio::Record::USBC', qw( language new ) );
my $code = new_ok( 'Biblio::Record::USBC' );
$code->language( 'english' );
is( $code->language, 'english', 'Checking if the language stored is correct' );
is( $code->computed_language, 0, 'Checking if the computed language is correct' );
is( length( $code->computed_language ), 1, 'Checking the size of a computed language' );

done_testing( 6 );
