#!/usr/bin/env perl
use warnings;
use strict;

sub regex
{
  my $variable = $_[0];
  my $pattern = "(\\S+)@([^:\\s]+)(:(\\d+))?";
  my $user = "";
  my $host = "";
  my $port = "";

  if ($variable =~ m/$pattern/i)
  {
    $user = $1;
    $host = $2;
    $port = $4;
  }

  my $portString = ($port ? " -oPort=$port" : "");
  print "Variable: $variable\n";
  print "Output: ssh|scp|sftp$portString $user\@$host\n";
}

regex @ARGV