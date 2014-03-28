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
$record->check_digit();

my $usbc = $record->get_usbc();
is( $usbc, '090000000000000001', 'Checking an empty record' );

done_testing( 3 );
