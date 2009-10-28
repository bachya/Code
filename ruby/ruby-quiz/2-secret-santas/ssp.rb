#!/usr/bin/env ruby
require('ssp_lib.rb')

banner = "\nWelcome to Aaron's Secret Santa Picker v.1!
-------------------------------------------------------------
Please enter name/email combinations in this form: 
FIRST_NAME space LAST_NAME space <EMAIL_ADDRESS> newline
Once you are done, please type 'done' - the SSP will 
do the rest!

NOTE: ./ssp.rb -f [filename] will read a line-by-line
TXT file of names/addresses (thus saving you a big headache).
-------------------------------------------------------------\n"

participants = []

unless ARGV.length == 0 or ARGV.length == 2
  print 'Usage: ./ssp.rb [-f [filename]]' << "\n" 
  exit
end

if ARGV.length == 0
  input = ''

  print banner
  until input == 'done'
    print "Please enter a person's information ('done' to quit): "
    input = gets.chomp
    participants << Person.new(input) if input != 'done'
  end
else
  flag = ARGV[0]
  file = ARGV[1]
  if flag != '-f'
    print 'Usage: ./ssp.rb [-f [filename]]' << "\n" 
    exit
  end
  
  if not File.file?(file)
    print "File doesn't exist or is not a regular file: " << file << "\n" 
    exit
  else
    participants = []
    File.open(file).each_line { |line|
      participants << Person.new(line) if not line.nil?
    }
  end
end

ss = SecretSanta.new(participants)
print ss