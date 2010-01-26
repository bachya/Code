#!/usr/bin/env perl

$nbArguments = $#ARGV + 1;
print "Number of arguments: $nbArguments\n";
exit(1) unless $nbArguments == 3;

$a = $ARGV[0];
$b = $ARGV[2];
$op = $ARGV[1];

if ($op eq "+")
{
  $result = $a + $b;
}
elsif ($op eq "-")
{
  $result = $a - $b;
}
elsif ($op eq "x")
{
  $result = $a * $b;
}
elsif ($op eq "/")
{
  $result = $a / $b;
}

print "$a $op $b = $result\n"
