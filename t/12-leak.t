#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::LeakTrace;

BEGIN {
    use_ok( 'Biblio::Record::USBC' ) or exit;
}

my $record = new_ok( 'Biblio::Record::USBC' );
my $usbc;
no_leaks_ok {
	$record->date( '' );
	$record->edition( '' );
	$record->language( '');
	$record->publisher( '' );
	$record->title( '' );
	$record->volume( '' );
	$usbc = $record->get_usbc();
};

is( $usbc, '090000000000000001', 'Checking an empty record' );

done_testing( 4 );
