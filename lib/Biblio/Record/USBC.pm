use strict;
use warnings;
package Biblio::Record::USBC;

use Moo;

has 'weight' => (
    is => 'rw'
);

has 'language' => (
    is => 'rw'
);

has 'date' => (
    is => 'rw'
);

sub computed_weight {
    my ( $self ) = @_;
    return substr( $self->weight, length( $self->weight ) - 1, 1);
}

sub computed_language {
    return 0;
}

sub computed_date {
    my ( $self ) = @_;
    return substr( $self->date, length( $self->date ) - 3, 3);
}

1;
