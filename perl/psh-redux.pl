#!/usr/bin/env perl
use warnings;
use strict;
use Getopt::Long;
use Switch;

my $wee = 'psh --ssl -N -L 9999:whiteknight:22 root@bachya.dnsdojo.com';
my $userHostPort = '[\w\d_.-]+@[\w\d_.-]+(:(\d+))?';

sub parseAndRun
{
  my $command = $_[0];
  if ($command =~ m/--(\w+)/i)
  {
    my $option = $1;
    if ($command =~ m/$userHostPort/i)
    {
      if ($& =~ m/:(\d+)/i)
      {
        my $portString = '';
        switch ($option)
        {
          case ('ssh')      { $portString = "-p $1"; }
          case (/sftp|scp/) { $portString = "-oPort=$1"; }
        }
        $command =~ s/$&//;
        $command =~ s/psh --$option/$option $portString/;
        print "$command\n";
      }
      else
      {
        $command =~ s/psh --$option/$option/;
        print "$command\n";
      }
    }
  }
  else
  {
    printUsageMessage();
  }
}

#|
#|  Prints the usage message.
#|
sub printUsageMessage 
{ 
  print "Usage:
  psh.pl --ssh user\@host[:port]
  psh.pl --sftp user\@host[:port]
  psh.pl --scp /path/to/file user\@host[:port]:[/remote/path]
  psh.pl --scp user\@host[:port]:/remote/path/to/file /local/path\n";
}

parseAndRun $wee
