#!/usr/bin/env ruby
range = 1..99
ones = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
tens = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

range.each { |num| 
  if num < 20
    puts num.to_s << ': ' << ones[num - 1].to_s
  else
    ten, one = num.divmod(10)
    print num.to_s << ': ' << tens[ten - 2].to_s
    print '-' << ones[one - 1].to_s if one != 0
    print "\n"
  end
}