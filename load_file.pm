#!/bin/perl

use strict;
use warnings;

sub help {
    print << 'END_HELP';
USAGE
    ./109titration file
DESCRIPTION
    file    a csv file containing "vol;ph" lines
END_HELP
}

sub is_decimal_number {
	my ($nb, $line) = @_;

	if ($_ =~ tr/.// > 1 || substr($_, 0, 1) eq "." || substr($_, length($_) - 1, 1) eq ".") {
		print STDERR "Invalid line: '$line'\n";
    	return 0;
	}
    elsif (!($_ =~ /^[0-9.]+$/)) {
    	print STDERR "Invalid line: '$line'\n";
    	return 0;
    }
    return 1;
}

sub error_file {
	my ($file) = @_;

    if (!-e $file) {
    	print STDERR "The file doesn't exist\n";
    	return 1;
    }
    elsif (!-r $file) {
    	print STDERR "The file can't be read\n";
    	return 1;
    }
    elsif (!-f $file) {
    	print STDERR "The file is not a plain file\n";
    	return 1;
    }
    elsif (-z $file) {
    	print STDERR "The file is empty\n";
    	return 1;
    }
    return 0;
}

sub load_file {
    my @content;
    my @content2;
    my $fh;

    if (scalar @ARGV != 1) {
    	print STDERR "Invalid number of argument\n";
        return ();
    }
    if ($ARGV[0] eq "-h") {
        help();
        exit (0);
    }
    elsif (error_file($ARGV[0])) {
    	return ();
    }
    open $fh, "<", $ARGV[0] or return ();
    push @content, $_ while (<$fh>);
    chomp @content;
    foreach my $line (@content) {
    	my @tmp = split(";", $line);
    	if (scalar @tmp != 2 || $line =~ tr/;/./ != 1) {
    		print STDERR "Invalid line: '$line'\n";
    		return ();
    	}
    	foreach (@tmp) {
    		if (!is_decimal_number($_, $line)) {
    			return ();
    		}
    	}
    	push @content2, \@tmp;
    }
    return @content2;
}

1;