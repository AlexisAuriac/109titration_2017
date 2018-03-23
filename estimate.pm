#!/bin/perl

use strict;
use warnings;

sub estimate {
	my (@list) = @_;
	my $eq = pop @list;
	my ($A, $B, $C) = ($list[$eq - 1], $list[$eq], $list[$eq + 1]);
	my @estimated;

	push @estimated, trace_line($A, $B);
	pop @estimated;
	push @estimated, trace_line($B, $C);
	return @estimated;
}

sub trace_line {
	my ($A, $B) = @_;
	my @line;

	for (my $i = $A->[0] ; $i < $B->[0] ; $i += 0.1) {
		my @tmp;
		$tmp[0] = $i;
		$tmp[1] = $A->[1] + ($B->[1] - $A->[1]) / ($B->[0] - $A->[0]) * ($i - $A->[0]);
		push @line, \@tmp;
	}
	return @line;
}

sub get_equivalent_est {
	my (@list) = @_;
	my $closest = abs($list[0]->[1]);
	my $eq = 0;

	for (my $i = 1 ; $i < scalar @list ; ++$i) {
		if (abs($list[$i]->[1]) < $closest) {
			$closest = abs($list[$i]->[1]);
			$eq = $i;
		}
	}
	return $eq;
}

1;