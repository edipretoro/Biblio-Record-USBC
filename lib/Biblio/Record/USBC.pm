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

has 'title' => (
    is => 'rw'
);

has 'edition' => (
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

sub computed_title {
    my ( $self ) = @_;

    my @chars = split( '', $self->title );
    my %freq;

    map { $freq{ uc($_) }++ if m/[[:alpha:]]/ } @chars;

    my %by_freq;
    foreach my $char (keys %freq) {
        my $lettres = $by_freq{$freq{$char}} || [];
        push @{ $lettres }, $char;
        @{ $lettres }  = sort @{ $lettres };
        $by_freq{$freq{$char}} = $lettres;
    }

    my $code;
    foreach (sort keys %by_freq) {
        $code .= join('', @{ $by_freq{ $_ } });
    }

    if (length( $code ) < 7) {
        $code .= '0' x (7 - length( $code ));
    }

    return $code;
}

sub computed_edition {
    my ( $self ) = @_;

    if ( $self->edition =~ /[^\d+]/ ) {
        return 0;
    } elsif ( $self->edition =~ /(\d+)/ ) {
        my $edition = $1;
        return substr( $edition, length( $edition ) - 1, 1 );
    }
}

1;
