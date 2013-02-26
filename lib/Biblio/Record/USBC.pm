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

has 'volume' => (
    is => 'rw'
);

has 'publisher' => (
    is => 'rw'
);

has 'check_digit' => (
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

    my $code = $self->_get_string_by_freq( $self->title );

    if (length( $code ) < 7) {
        $code .= '0' x (7 - length( $code ));
    }

    return substr( $code, 0, 7 );
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

sub computed_volume {
    my ( $self ) = @_;

    my @digits;
    while ( $self->volume =~ /(\d+)/g ) {
        my $digit = $1;
        push @digits, $digit;
    }

    if (scalar( @digits ) == 0) {
        return "00";
    } elsif (scalar( @digits ) == 1) {
        return sprintf("%02s", substr( $digits[0], 0, 2 ));
    } elsif (scalar( @digits ) == 2) {
        my $vol = substr( $digits[0], length( $digits[0]) - 1, 1 );
        my $num = substr( $digits[1], length( $digits[1]) - 1, 1 );
        return "$vol$num";
    } else {
        # don't know waht to do. It isn't decribe in the original article
    }
}

sub computed_publisher {
    my ( $self ) = @_;

    my $code = $self->_get_string_by_freq( $self->publisher );

    return substr( $code, 0, 1 ) || "0";
}

sub computed_check_digit {
    return shift->check_digit;
}

sub _get_string_by_freq {
    my ( $self, $string ) = @_;

    my @chars = split( '', $string );
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

    return $code;
}

1;
