#!/bin/perl

use strict;
use warnings;

sub derive_list {
	my (@list) = @_;
	my @derivatives;
	my @couple;
	my $ref;

	for (my $i = 1 ; $i < scalar @list - 1 ; ++$i) {
		push @derivatives, derive_point($list[$i], $list[$i - 1], $list[$i + 1])
	}
	return @derivatives;
}

sub derive_point {
	my ($to_derive, $point1, $point2) = @_;
	my @derivative;
	my $ref;

	push @derivative, $to_derive->[0];
	push @derivative, ($point2->[1] - $point1->[1]) / ($point2->[0] - $point1->[0]);
	return \@derivative;
}

sub get_equivalent_deriv {
	my (@list) = @_;
	my $biggest = 0;
	my $eq = 0;

	for (my $i = 0 ; $i < scalar @list ; ++$i) {
		if ($list[$i]->[1] > $biggest) {
			$biggest = $list[$i]->[1];
			$eq = $i;
		}
	}
	return $eq;
}

1;