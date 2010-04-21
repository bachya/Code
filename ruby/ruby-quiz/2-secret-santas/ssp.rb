#!/usr/bin/env ruby
class Person
  
  attr_reader :first_name, :last_name, :email
  attr_accessor :santa
  
  def initialize(string)
    parts = string.match(/(\w+)\s(\w+)\s+<(.+)>/)
    raise "Invalid entry: " << string << "\n" if parts.nil?
    @first_name, @last_name, @email = parts[1], parts[2], parts[3]
  end
  
  def canBeSantaFor?(person)
    return @last_name != person.last_name
  end
  
end

banner = "\nWelcome to Aaron's Secret Santa Picker v.1!
--------------------------------------------------------------
Please enter name/email combinations in this form: 
FIRST_NAME space LAST_NAME space <EMAIL_ADDRESS> newline
Once you are done, please type 'done' - the SSP will 
do the rest!

NOTE: ./ssp.rb -f [filename] will read a line-by-line
TXT file of names/addresses (thus saving you a big headache).
--------------------------------------------------------------\n"

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
      participants << Person.new(line) if not line.empty?
    }
  end
end

santas = participants.dup
participants.each { |person|
  person.santa = santas.delete_at(rand(santas.size))
}

participants.each { |person|
  unless person.santa.canBeSantaFor? person
    candidates = participants.select { |p|
      p.santa.canBeSantaFor? person and person.santa.canBeSantaFor? p
    }
    
    raise "Bad set of candidates" if candidates.empty?
    temp_person = candidates[rand(candidates.size)]
    temp_santa = person.santa
    person.santa = temp_person.santa
    temp_person.santa = temp_santa 
  end
}

participants.each do |person|
  printf "%s %s -> %s %s\n", person.santa.first_name, person.santa.last_name,
                            person.first_name, person.last_name
end