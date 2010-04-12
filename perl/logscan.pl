#!/usr/bin/perl -w

# Libraries
use Mail::Sendmail 0.75;
use IO::Seekable;
use IO::Handle;

# Subroutine Prototypes
sub DNSlookup;
sub genEmail;
sub geoLookup;

# File paths
my $loginsDB = "/var/local/logins.db";
my $authlog = "/var/log/auth.log";
my $geoDB = "/var/local/IpToCountry.csv";

# Globally-used variables
my %existingEntries;
my @countryInfo;
my $found = 0;
my $SLEEP = 1;

#########################################
#### Read previous logins from logins.db 
#########################################
open(LOGINS, "<", $loginsDB) or die("Can't open /var/local/logins.db: $!\n");

LOGINS->autoflush(1);

while (<LOGINS>) {
	# Regex for parsing the logins.db file
	/^(\S*),(\S*),(.*)/;
	
	foreach (@{$existingEntries{$1}}) {
		if ($_ eq $2) {
			$found = 1;
			last;
		}
	}
	
	if (!$found) {
		push @{$existingEntries{$1}}, $2;
		$found = 0;
	}
}

close LOGINS;

#########################################
#### Read new logins from auth.log 
#########################################
$found = 0;

open(AUTH, "<", $authlog) or die("Can't open /var/log/auth.log: $!\n");
open(LOGINS, ">>".$loginsDB) or die("Can't open /var/local/logins.db: $!\n");

AUTH->autoflush();
LOGINS->autoflush();

for (;;) {
	while (<AUTH>) {
		if (/^(.*) rowsdower.* Accepted (password|publickey) for (\S*) from (\S*) port/) {
			foreach my $oldIP (@{$existingEntries{$3}}) {
				if ($4 eq $oldIP) {
					$found = 1;
					last;
				}
			}
			
			if (!$found) {
				print LOGINS "$3,$4,$1\n";
				push @{$existingEntries{$3}}, $4;
				@countryInfo = geoLookup($4);
				genEmail($3, $4, $1, DNSlookup($4), $countryInfo[0], $countryInfo[1]);
			}
			$found = 0;
		}
	}
	sleep $SLEEP;
	AUTH->clearerr();
}

close AUTH;
close LOGINS;

#########################################
#### DNSlookup Subroutine
#########################################
sub DNSlookup {
	# Shift off the only parameter we're passing:
	# the IP address.
	my $ip = shift;

	# Pipe in the short results from dig to
	# the command prompt.
	open(CMD, "dig -x ".$ip." +short |");

	# There will only be one line, so
	# that's all we need to return.
	while (<CMD>) {
		chomp;
		last;
	}

	# Close off the CMD filehandle and return the
	# line from dig.
	close CMD;
	return $_;
}

#########################################
#### genEmail Subroutine
#########################################
sub genEmail {
	# Save our parameters for use.
	my ($username, $ip, $timestamp, $reverseDNS, $countryCode, $countryName) = @_;

	# Create variables for some header info.
	my %email;
	my $boundary;
	my $subject = "New IP address seen for user \'".$username."\'";
	my $content = "A new username/ipaddress combination was seen:\n\n"
		. "Timestamp:\t[".$timestamp."]\n"
		. "Username:\t[".$username."]\n"
		. "IP address:\t[".$ip."]\n"
		. "Reverse DNS:\t[".$reverseDNS."]\n"
		. "Country Code:\t[".$countryCode."]\n"
		. "Country Name:\t[".$countryName."]\n\n"
		. "Sincerely,\n"
		. "The Simple Log Scanner";

		
	# Set up the actual email.
	$boundary = "====" . time() . "====";
		
	%email = 
		(
			'from' => '"New Login Report" <root@rowsdower.cs.colorado.edu>',
			'to' => '"root" <root@rowsdower.cs.colorado.edu>',
			'subject' => "$subject",
			'content-type' => "multipart/alternative; boundary=\"$boundary\"",
		);

	$boundary = '--'.$boundary;

	$email{'body'} = <<END_OF_BODY;

$boundary
Content-Type: text/plain; charset="iso-8859-1"

$content

$boundary--
END_OF_BODY

	# Send the email.
	sendmail(%email) || print "Error: $Mail::Sendmail::error\n";
}

#########################################
#### geoLookup Subroutine
#########################################
sub geoLookup {
	# Shift off the IP address.
	my $ip = shift;

	# Split the IP address into its
	# four octet pieces.
	my @pieces = split(/\./, $ip);

	# Put together the geographical ID.
	my $geoID = (($pieces[0]*256*256*256) + ($pieces[1]*256*256) + ($pieces[2]*256) + $pieces[3]);

	# Open up the geographical lookup database to see where
	# this IP is coming from.
	open(GEO, "/var/local/IpToCountry.csv") or die("Can't open /var/local/IpToCountry.csv: $!");

	# This is the crap part - we have to split up each line into its components,
	# and then check the $geoID against the first two elements of each line. If
	# we find a line that matches, we return the split pieces of geographical info.
	my @geoPieces;

	while (<GEO>) {
		if (/^"(\d+)","(\d+)","(\D+)","(\d+)","(\D+)","(\D+)","(\D+)"/) {
			if ($1 <= $geoID && $geoID <= $2) {
				@geoPieces = ($5, $7);
				last;
			}
		}
	}

	close GEO;
	return @geoPieces;
}
