#!/usr/bin/env perl
#-------------------------------------------------------------------------
#  psh.pl
#  A wrapper for ssh, sftp, and scp that looks innoculous enough at first 
#  glance:
#    psh.pl --ssh user@host => ssh user@host
#    psh.pl --sftp user@host => sftp user@host
#    psh.pl --scp /home/file.txt user@host => scp /home/file.txt user@host
#-------------------------------------------------------------------------
use warnings;
use strict;
use Getopt::Long;
use Switch;

my @args = @ARGV;

my $userHostRegex = '(\w+)@([^\\s:]+)(:(\d+))?';
my $pathRegex = '(~?[\w/\\\.\\s\-*]+)';
my $scpRegex = "($pathRegex\\s$userHostRegex:($pathRegex:)?|$userHostRegex:$pathRegex\\s$pathRegex)";

sub parseAndRun
{
  my ($option, $command, $regex) = @_;
  if ($command =~ m/$regex/i)
  {
    my $newCommand = "$option ";
    if ($& =~ m/:(\d+)/)
    {
      my $portString = '';
      $command =~ s/:(\d+)//;
      switch ($option)
      {
        case ('ssh')      { $portString = "-p $1 "; }
        case (/sftp|scp/) { $portString = "-oPort=$1 "; }
      }      
      $newCommand .= "$portString";
    }

    $newCommand .= "$command";
    system($newCommand);
  }
  else
  {
    print "Bad specification for option [$option]: $command\n";
    return 1;
  }
}

sub printUsageMessage
{
  print "Usage: s [--ssh --scp --ftp]\n";
}

my ($ssh, $sftp) = '';
my @scp;
GetOptions('ssh=s' => \$ssh, 'scp=s{2}' => \@scp, 'sftp=s' => \$sftp);

if ($ssh)
{
  parseAndRun('ssh', $ssh, "^$userHostRegex\$");
}
elsif (@scp)
{
  my $scpString = '';
  foreach (@scp) { $scpString .= $_ . ' '; }
  $scpString =~ s/\s+$//;
  parseAndRun('scp', $scpString, "$scpRegex\$");
}
elsif ($sftp)
{
  parseAndRun('sftp', $sftp, "^$userHostRegex\$");
}
else
{
  printUsageMessage();
}