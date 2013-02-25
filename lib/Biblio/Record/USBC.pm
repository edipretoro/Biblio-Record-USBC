use strict;
use warnings;
package Biblio::Record::USBC;

use Moo;

has 'weight' => (
    is => 'rw'
);

sub computed_weight {
    my ( $self ) = @_;
    return substr( $self->weight, length( $self->weight ) - 1, 1);
}

1;
