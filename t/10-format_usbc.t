#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
}

my $record = new_ok( 'Biblio::Record::USBC' );
can_ok( 'Biblio::Record::USBC', qw( format_mapping format_string ) );
$record->format_mapping( { '%w' => 'weight' } );
$record->format_string( '%w' );
$record->title( 'Test-Driven Development' );
my $usbc = $record->get_usbc();
is( $usbc, 3, 'Checking the size of my own formatted USBC' );

done_testing( 4 );
