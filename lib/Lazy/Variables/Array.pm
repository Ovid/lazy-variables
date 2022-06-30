package Lazy::Variables::Array

# ABSTRACT: Backend for lazy arrays

use v5.20.0;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

our $VERSION = '0.01';

# TIEARRAY classname, LIST
# FETCH this, key
# STORE this, key, value
# FETCHSIZE this
# STORESIZE this, count
# CLEAR this
# PUSH this, LIST
# POP this
# SHIFT this
# UNSHIFT this, LIST
# SPLICE this, offset, length, LIST
# EXTEND this, count
# DELETE this, key
# EXISTS this, key
# DESTROY this
# UNTIE this

1;

__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

