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
    $self->weight( length( $self->title ) );
    return $self->weight % 10;
}

sub computed_language {
    my ( $self ) = @_;

    my %languages_code = (
        'english'       => 0,
        'german'        => 1,
        'germanic'      => 2,
        'scandinavian'  => 2,
        'dutch'         => 2,
        'french'        => 3,
        'italian'       => 4,
        'portuguese'    => 4,
        'spanish'       => 4,
        'rumanian'      => 4,
        'greek'         => 5,
        'latin'         => 5,
        'slavic'        => 6,
        'east_european' => 6,
        'finnish'       => 6,
        'asian'         => 7,
        'hebrew'        => 7,
        'african'       => 8,
        'arabic'        => 8,
        'others'        => 9
    );

    my $computed_weight;
    if (defined( $languages_code{ $self->language } )) {
        $computed_weight = $languages_code{ $self->language };
    } else {
        $computed_weight = 9;
    }
    return $computed_weight;
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
        return "0";
    } elsif ( $self->edition =~ /(\d+)/ ) {
        my $edition = $1;
        return substr( $edition, length( $edition ) - 1, 1 );
    } else {
        return "0";
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

    return substr( $code, 0, 2 ) || "00";
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

sub get_usbc {
    my ( $self ) = @_;

    return
        $self->computed_weight .
        $self->computed_language .
        $self->computed_date .
        $self->computed_title .
        $self->computed_edition .
        $self->computed_volume .
        $self->computed_publisher .
        $self->computed_check_digit;
}

after title => sub {
    my ( $self, $title ) = @_;
    $self->weight( length( $title ) );
};

1;
