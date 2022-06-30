package Lazy::Variables::Hash;

# ABSTRACT: Backend for lazy hashes

use v5.20.0;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use Carp 'croak';
use Ref::Util 'is_plain_coderef';
use namespace::autoclean;

our $VERSION = '0.01';

sub TIEHASH ( $class, $generator, @args ) {
    unless ( is_plain_coderef($generator) ) {
        croak("generator for lazy hashes must be a code reference");
    }
    return bless {
        generator => $generator,
        args      => \@args,
        hash      => {},
    }, $class;
}

sub FETCH ( $self, $key ) {
    return $self->{hash}{$key};
}

sub STORE ( $self, $key, $value ) {
    $self->{hash}{$key} = $self->{generator}->( $value, @{ $self->{args} } );
}

sub DELETE ( $self, $key ) {
    return delete $self->{hash}{$key};
}

sub CLEAR ($self) {
    $self->{hash} = {};
}

sub EXISTS ( $self, $key ) {
    return exists $self->{hash}{$key};
}

sub FIRSTKEY ($self) {
    keys %{ $self->{hash} };    # reset each() iterator
    each %{ $self->{hash} };
}

sub NEXTKEY ( $self, $lastkey ) {

    # lastkey is here for documentation, but we don't use it
    return each %{ $self->{hash} };
}

sub SCALAR ($self) {
    return scalar keys %{ $self->{hash} };
}

sub _data_printer ($self, @) {
    return $self->{hash};
}
# DESTROY this is not needed
# UNTIE this is not needed

1;

__END__

=head1 SYNOPSIS

This is the backend for L<Lazy::Variables> hashes. It has no user-serviceable parts.
