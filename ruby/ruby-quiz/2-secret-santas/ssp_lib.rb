class Person
  
  attr_reader :first_name, :last_name, :email
  attr_accessor :santa, :santa_for
  
  def initialize(input)
    parts = input.match(/(\w+)\s(\w+)\s<(.+)>/)
    if parts.nil?
      print "Invalid entry: " << input << "\n"
      exit
    end
    @first_name, @last_name, @email = parts[1], parts[2], parts[3]
  end
  
  def to_s
    return @first_name << ' ' << @last_name << ' <' << @email << '>'
  end
  
end

class SecretSanta
  
  def initialize(participants)
    @participants = participants
  end
  
end