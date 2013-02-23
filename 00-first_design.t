#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

is ( length( get_usbc() ) == 16, 'A USBC code a string of 16 characters' );

done_testing( 0 );
