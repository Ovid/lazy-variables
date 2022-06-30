#!/usr/bin/env perl

use Test::Most;
use Lazy::Variables::Hash;

sub munger {
    my ( $key, @args ) = @_;
    return "Stored: " . join '-', $key, @args;
}

tie my %hash, 'Lazy::Variables::Hash', \&munger, 1, 2, 3;

ok !exists $hash{bar},        '... and not be in the hash, either';
ok $hash{bar} = 'some-value', 'We should be able to set a hash value';
ok exists $hash{bar},         '... and now the key should exist';
is $hash{bar}, 'Stored: some-value-1-2-3',
  '... and we should have the correct value set in our hash';

ok my $value = delete $hash{bar}, 'We should be able to delete a hash key';
is $value, 'Stored: some-value-1-2-3', '... and get the correct value back';
ok !exists $hash{bar}, '... but see that the key no longer exists in the hash';
ok !defined delete $hash{bar}, '... and deleting it again returns undef';

$hash{this} = "that";
$hash{name} = "Ovid";

my $count = 0;
while ( my ( $key, $value ) = each %hash ) {
    explain "$key is $value";
    $count++;
}
is $count, 2, 'We should have iterated through our hash twice';
use DDP;
p %hash;

my %hash_2 = (
    name => $hash{name},
    this => $hash{this},
);
p %hash_2;

%hash = ();
$count = 0;
while ( my ( $key, $value ) = each %hash ) {
    explain "$key is $value";
    $count++;
}
is $count, 0, 'Empty hashes should not be iterable';

explain \%hash;

done_testing;
