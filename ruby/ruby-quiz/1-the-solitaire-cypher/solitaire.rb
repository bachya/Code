# This program implements the Solitaire Cryptographic
# cypher (proposed at http://rubyquiz.com/quiz1.html).
#
# Cryptologist Bruce Schneier designed the hand cipher 
# "Solitaire" for Neal Stephenson's book "Cryptonomicon". 
# Created to be the first truly secure hand cipher, Solitaire 
# requires only a deck of cards for the encryption and 
# decryption of messages.
#
# Author:: Aaron Bach (bachya1208@googlemail.com)

# This class represents a regular deck of cards (52 cards plus
# 2 jokers). It provides "shuffling" methods specific to
# the Solitaire cypher and the main method generateKeystream,
# which creates the "seed" we use to encrypt messages.
class Deck
  
  # Moves a specific card in the deck down a certain number
  # of spots. Example: moveCard(:A, 3) would move Joker #1 
  # down 3 spots in the deck.
  def moveDown(card, spots)
  	new_index = @deck.index(card) + spots
  	if new_index > 53
  		new_index -= 53
  	end
  	@deck.delete_at(@deck.index(card))
  	@deck.insert(new_index, card)
  end
  
  # Returns the value of a given card (which is simply the 
  # card's face value). Jokers are valued at 53.
  def cardToValue(card)
  	return 53 if card == :A or card == :B
  	return card
  end
  
  # Step #1
  # -------
  # Initializes a deck object and creates a variable with
  # 1, 2, 3 ... 51, 52, :A, :B (where :A is "Joker #1" and
  # :B is "Joker #2").
  def initialize
    @deck = (1..52).to_a + [:A, :B]
  end
  
  # Step #2
  # -------
  # Moves Joker #1 down 1 spot from its initial location.
  def moveJokerA
  	moveDown(:A, 1)
  end
  
  # Step #3
  # -------
  # Moves Joker #2 down 2 spots from its initial location.
  def moveJokerB
  	moveDown(:B, 2)
  end
  
  # Step #4
  # -------
  # Performs a "triple cut," wherein all cards above Joker #1
  # move below Joker #2 and vice versa.
  def tripleCut
  	joker_indices = [@deck.index(:A), @deck.index(:B)]
  	top, bottom = joker_indices.min, joker_indices.max
  	@deck = @deck[(bottom + 1)..53] + @deck[top..bottom] + @deck[0..(top - 1)]
  end
  
  # Step #5
  # -------
  # Performs a "count cut," wherein x number of cards are removed
  # from the top of the deck and placed just above the bottom card.
  # x is determined by the value of bottom card.
  def countCut
  	cards_to_cut = @deck.last
  	@deck = @deck[(cards_to_cut...53)] + @deck[(0...cards_to_cut)] + [cards_to_cut]
  end
  
  # Step #6
  # -------
  # Picks a letter for the keystream - the value is chosen from a
  # card x cards down from the top of the deck. x is chosen by
  # selecting the top card's value. Jokers are ignored.
  def pickLetter
  	  target = @deck.at(cardToValue(@deck.first))
  	  unless target == :A or target == :B
        return (target + 38).chr if target > 26
        return (target + 64).chr
      end
  end
  
  # Step #7
  # -------
  # Generates a keystream with a given length. Basically performs
  # steps #1 - #6 until the keystream length matches the length
  # parameter. Finally, the keystream is split into blocks of 5
  # characters, with the last blocked being padded by X's if not
  # a multiple of 5.
  def generateKeystream(length)
	  keystream = ''
	  while keystream.length < length
  		moveJokerA
  		moveJokerB
  		tripleCut
  		countCut
  		keystream << pickLetter.to_s
	  end
	  keystream << "X" * (5 - (keystream.length % 5)) unless keystream.length % 5 == 0
	  return keystream.scan(/.{1,5}/).join(' ').strip
  end
  
end

# This class represents a Solitaire cypher encrypter/decrypter.
# It provides methods to sanitize the string to encrypt/decrypt
# and performs the actual conversion
class Solitaire
  
  # Takes the message to work with and generates
  # a keystream for it.
  def initialize(message)
    @keystream = Deck.new.generateKeystream(message.length)
  end

  # Sanitizes an input string.
  # * Uppercases all letters
  # * Deletes non-alphabetic characters
  # * Splits the string into blocks of 5 characters and pad if needed
  def sanitizeInput(input)
    out = ''
    input = input.upcase
    input = input.gsub(/[^A-Z]/, '')
    input << "X" * (5 - (input.length % 5)) unless input.length % 5 == 0
    return input.scan(/.{1,5}/).join(' ').strip
  end

  # Safely contains a character within the 1-26 range
  # (only alphabet characters).
  def contain(char)
    return char - 26 if char > 26
    return char + 26 if char < 1
    return char
  end

  # The main function in this class; performs either
  # an encryption or decryption for a passed string
  # based on a lambda conversion function.
  def conversion(string, &conversion_function)
    out = ''
    sanitized = sanitizeInput(string)
    sanitized.each_byte.with_index { |char, index|
      if char >= 'A'[0].ord and char <= 'Z'[0].ord
        out << conversion_function.call(char, @keystream[index].ord)
      else
        out << char
      end
    }
    return out
  end

  # Wrapper for encryption. Also provides the conversion mechanism to use.
  def encrypt(string)
    return conversion(string) { |char, key_index| contain((char + key_index) % 64) + 64 }
  end

  # Wrapper for decryption. Also provides the conversion mechanism to use.
  def decrypt(string)
    return conversion(string) { |char, key_index| contain(char - key_index) + 64 }
  end

end