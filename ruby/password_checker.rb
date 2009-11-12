#!/usr/bin/env ruby

# Constants
MIN_LENGTH = 8
COMBO_BIG_BONUS = 25
COMBO_SMALL_BONUS = 15
PENALTY_LETTERS = -15
PENALTY_NUMBERS = -35

# Variables
@base  = 0
@total = 0
@types = {'excess' => 0, 'upper' => 0, 'numbers' => 0, 'symbols' => 0}
@bonus = {'excess' => 3, 'upper' => 4, 'numbers' => 5, 'symbols' => 5, 'combo' => 0, 'penalty' => 0}

# Functions
def analyze(pass)
  # First, check out each character of the password and check
  # uppercase, numbers, symbols, and how many characters over
  # the minimum the password is.
  pass.each_char { |char|
    @types['upper'] += 1 if char.match(/[A-Z]/)
    @types['numbers'] += 1 if char.match(/[0-9]/)
    @types['symbols'] += 1 if char.match(/[^\w\d]/)
    @types['excess'] = pass.length - MIN_LENGTH
  }
  
  # Assign a combo bonus for combinations of uppercase, numbers
  # and symbols (all three gives the biggest bonus).
  if (!@types['upper'].zero? and !@types['numbers'].zero? and !@types['symbols'].zero?)  
    @bonus['combo'] = COMBO_BIG_BONUS
  elsif ((!@types['upper'].zero? and !@types['numbers'].zero?) or (!@types['upper'].zero? and !@types['symbols'].zero?) or (!@types['numbers'].zero? and !@types['symbols'].zero?))
    @bonus['combo'] = COMBO_SMALL_BONUS
  end
  
  # If the password is only made up of lowercase letters, assign 
  # a penalty (not as bad as the numbers-only penalty).
  @bonus['penalty'] = PENALTY_LETTERS if pass.match(/^[\sa-z]+$/)
  
  # If the password is only made up of numbers, assign a big
  # penalty (since there are so few numbers to work with).
  @bonus['penalty'] = PENALTY_NUMBERS if pass.match(/^[\s0-9]+$/)
  
  # Calculate the total
  total = @base + (@types['excess'] * @bonus['excess']) + (@types['upper'] * @bonus['upper']) + (@types['numbers'] * @bonus['numbers']) + 
          (@types['symbols'] * @bonus['symbols']) + @bonus['combo'] + @bonus['penalty']
  return total
end

# Main Program
print "Enter a password to test: "
pass = gets

if (pass.length >= MIN_LENGTH)
  @base = 25
  @total = analyze(pass.chomp)
  @total = 0 if @total < 0
end

puts "\n" <<
     '=================' << "\n" <<
     'Password: ' << pass << "\n" <<
     'Base (did you meet the 8 char minimum?): ' << @base.to_s << "\n" <<
     'Excess Characters bonus: ' << (@types['excess'] * @bonus['excess']).to_s << ' [' << @types['excess'].to_s << ' x ' << @bonus['excess'].to_s << ']' << "\n" <<
     'Uppercase Characters bonus: ' << (@types['upper'] * @bonus['upper']).to_s << ' [' << @types['upper'].to_s << ' x ' << @bonus['upper'].to_s << ']' << "\n" <<
     'Numbers bonus: ' << (@types['numbers'] * @bonus['numbers']).to_s << ' [' << @types['numbers'].to_s << ' x ' << @bonus['numbers'].to_s << ']' << "\n" <<
     'Symbols bonus: ' << (@types['symbols'] * @bonus['symbols']).to_s << ' [' << @types['symbols'].to_s << ' x ' << @bonus['symbols'].to_s << ']' << "\n" <<
     'Combo (mix of letters, numbers, symbols): ' << @bonus['combo'].to_s << "\n" <<
     'Penalty (lowercase only or numbers-only): ' << @bonus['penalty'].to_s << "\n" <<
     'Total: ' << @total.to_s << "\n"
     case @total
     when 0..30
       puts 'Strength: Weak' << "\n"
     when 31..60
       puts 'Strength: Decent' << "\n"
     when 61..90
       puts 'Strength: Strong' << "\n"
     else
       puts 'Strength: Extreme' << "\n"
     end
puts '=================' << "\n" <<
     "\n"