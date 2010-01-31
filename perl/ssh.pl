#!/usr/bin/env perl
use warnings;
use strict;
use Getopt::Long;
use Switch;

my @args = @ARGV;

#|
#|  SSH/SFTP argument style.  Should support these examples:
#|    s [--ssh --sftp] user@host
#|    s [--ssh --sftp] user@host:port
#|
my $sshRegex = "^([a-z0-9]+)@([^\\d:\\s]+)(:(\\d+))?\$";

#|
#|  SCP argument style.  Should support these examples:
#|    s --scp ~/.tmp/*.txt user@host:port
#|    s --scp user@host:port:/home/user/*.txt /some/path
#|
my $scpRegex = "^([a-z0-9]+)@([^\\d:\\s]+)(:(\\d+))?:([a-z0-9\\\\\/*\\.~]+)\\s([a-z0-9\\\\\/*\\.~]+)|([a-z0-9\\\\\/*\\.~]+)\\s([a-z0-9]+)@([^\\d:\\s]+)(:(\\d+))?:([a-z0-9\\\\\/*\\.~]+)?\$";

sub parseCommand
{
  my ($option, $command, $regex) = @_;
  if ($command =~ m/$regex/i)
  {
    print "match\n";
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
  parseCommand('ssh', $ssh, $sshRegex);
}
elsif (@scp)
{
  my $scpString = '';
  foreach (@scp) { $scpString .= $_ . ' '; }
  $scpString =~ s/\s+$//;
  parseCommand('scp', $scpString, $scpRegex);
}
elsif ($sftp)
{
  parseCommand('sftp', $sftp, $sshRegex);
}
else
{
  printUsageMessage();
}