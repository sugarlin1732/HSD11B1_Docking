#!/bin/usr/perl
#vina post processing
#v.0.0.1-20100505

use strict;

if ($ARGV[0] eq "")
{
	print "Please assign 1 parameters, when executing this script.\n";
	print "\t1 the file name of input data.\m\n";
	exit();
}

my $line;
my @words;
my @tmp;

open(INFILE, "$ARGV[0]");

while($line = <INFILE>)
{
  chomp($line);
  @words = split(/\s+/, $line);
  if($words[0] eq "MODEL")
  {
    $tmp[0] = sprintf("%02d", $words[1]);
    open(OUTFILE, "> $tmp[0].pdb");
    while($line = <INFILE>)
    {
      @words = split(/\s+/, $line);
      if($words[0] eq "ATOM")
      {
        print OUTFILE $line;
      }
      elsif($words[0] eq "ENDMDL")
      {
        print OUTFILE "END\n";
        close OUTFILE;
        last;
      }
    }
  }
}

close INFILE;
