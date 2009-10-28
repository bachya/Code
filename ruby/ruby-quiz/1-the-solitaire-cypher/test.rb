#!/usr/bin/env ruby
require 'solitaire.rb'

if ARGV.length < 1 or ARGV.length > 2
  print 'Usage: ./test.rb -e [filename]' << "\n" << '       ./test.rb -d [filename]' << "\n"
  exit
end

action = ARGV[0]
message = ARGV[1]
case action
when '-encrypt' 
  if message.nil?
    print 'Please input a message to encrypt: '
    message = STDIN.gets.chomp
  end
  s = Solitaire.new(message)
  print 'Original message: ' << message << "\n"
  print 'Encrypted message: ' << s.encrypt(message) << "\n"
when '-decrypt'
  if message.nil?
    print 'Please input a message to decrypt: '
    message = STDIN.gets.chomp
  end
  s = Solitaire.new(message)
  print 'Original message: ' << message << "\n"
  print 'Decrypted message: ' << s.decrypt(message) << "\n"
else
  print 'Unknown action: ' << action << "\n"
  exit
end