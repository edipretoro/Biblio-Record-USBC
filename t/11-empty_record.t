#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
}

my $record = new_ok( 'Biblio::Record::USBC' );
$record->language( '');
$record->date( '' );
$record->title( '' );
$record->edition( '' );
$record->volume( '' );
$record->publisher( '' );
$record->check_digit( 'X' );

my $usbc = $record->get_usbc();
is( $usbc, '09000000000000000X', 'Checking an empty record' );

done_testing( 3 );
