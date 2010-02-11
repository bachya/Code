#!/usr/bin/env perl
use Data::Dumper;
use Switch;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;

my @completed;
my $confFile = './conf/manifest.pl';

sub copyFiles {
  my $packageName = $_[0];
  my %fileDefs = %{$_[1]};
  while (my ($fileAlias, $filename) = each(%fileDefs)) {
    my $fullFile = "$ENV{HOME}/$filename";
    if (-e $fullFile) {
      print "- $fullFile already exists...do you want to replace it? [y/N]: ";
      chomp(my $option = <>);
      if ($option eq 'y' || $option eq 'Y') {
        print GREEN "---> Replacing $fullFile - I'll pull the old one in $fullFile.old...\n";
        system("mv $fullFile $fullFile.old");
        system("ln -s ./templates/$packageName/$fileAlias ~/$filename");
      }
      else {
        print MAGENTA "---> Leaving $fullFile alone...\n";
      }
    }
    else {
      print GREEN "---> $fullFile doesn't exist, so we'll create it...\n";
      system("ln -s ./templates/$packageName/$fileAlias ~/$filename");
    }
  }
}

#---------------------------------------------
#  Determine if an element exists in an array
#  Basically a reproduction of PHP's in_array.
#---------------------------------------------
sub in_array {
  my ($arr, $search_for) = @_;
  foreach my $value (@$arr) {
    return 1 if $value eq $search_for;
  }
  return 0;
}

#---------------------------------------------
#  Load a package
#  Does so recursively, checking for
#  dependencies and loading those before the
#  base package is loaded
#---------------------------------------------
sub loadPackage {
  my $packageName = $_[0];
  my %fileDefs = %{$_[1]};

  # The first error we check for is whether or not there is a template directory
  # that matches the package's name.
  if (!-d "./templates/$packageName") {
    print(STDERR "ERROR: '$packageName' package defined, but no template directory with the same name exists...", "\n\n");
    exit(1);
  }
  
  # We also check to make sure that no bogus package name is being passed into
  # this subroutine.
  if (!exists $CFG::packages{$packageName}) {
    print(STDERR "ERROR: No package named '$packageName' in your configuration...", "\n\n");
    exit(1);
  }
  
  if (exists($CFG::packages{$packageName}{prereqs})) { # If prereqs exist...
    foreach (@{$CFG::packages{$packageName}{prereqs}})
    {
      my $prereqPackageName = $_;
      
      # Ensure that the prereq package name exists elsewhere in the configuration.
      if (!exists($CFG::packages{$_})) {
        print(STDERR "ERROR: Prerequisite package '$_' (defined for package '$packageName') doesn't exist or is incorrectly defined...", "\n\n");
        exit(1);
      }
      
      # If we haven't already processed the prereq package, do so now.
      if (!in_array(\@completed, $prereqPackageName)) {
        print BLUE "Setting up the $prereqPackageName package:\n";
        copyFiles($prereqPackageName, \%{$CFG::packages{$prereqPackageName}{files}});
        push(@completed, $prereqPackageName);
      }
    }
    
    if (!in_array(\@completed, $packageName)) {
      print BLUE "Setting up the $packageName package:\n";
      copyFiles($packageName, \%fileDefs);
      push(@completed, $packageName);
    }
  }
  else { # If no prereqs...
    if (!in_array(\@completed, $packageName)) {
      print BLUE "Setting up the $packageName package:\n";
      copyFiles($packageName, \%fileDefs);
      push(@completed, $packageName);
    }
  }
}

#---------------------------------------------
#  Read a configuration file
#  The arg can be a relative or full path, or
#  it can be a file located somewhere in @INC.
#---------------------------------------------
sub readCfg {
  my $file = $_[0];
  our $err;

  { # Put config data into a separate namespace
    package CFG;

    # Process the contents of the config file
    my $rc = do($file);

    # Check for errors
    if ($@) {
      $::err = "ERROR: Failure compiling '$file' - $@";
    } 
    elsif (! defined($rc)) {
      $::err = "ERROR: Failure reading '$file' - $!";
    } 
    elsif (! $rc) {
      $::err = "ERROR: Failure processing '$file'";
    }
  }
}

#---------------------------------------------
#  MAIN PROGRAM
#---------------------------------------------

#---------------------------------------------
#  Step 1.  Read the configuration file
#  Nothing too surprising going on here.  Just
#  import the file and spit out any errors if
#  they occur.
#---------------------------------------------
print "\n+----------------------- CONFIGS -----------------------+
Welcome to Configs. I'll walk you through getting your
files set up. First thing we're going to do is read any
files in the conf directory...
\n";
print "Hit <enter> to get started or <ctrl-c> to bail out:";
chomp($command = <>);
print "+-------------------------------------------------------+\n";
if ($err = readCfg($confFile)) {
  print (STDERR $err, "\n\n");
  exit(1);
}

#---------------------------------------------
#  Step 2.  Loop through the package configs
#  and set them up.  A few things happen:
#    a. The configuration file is scanned for
#       prerequisites.  Those packages are
#       loaded first.
#    b. After prerequisites are loaded, the
#       the original packages are loaded.
#---------------------------------------------
for my $packageName (keys %CFG::packages) {
  loadPackage($packageName, \%{$CFG::packages{$packageName}{files}});
}