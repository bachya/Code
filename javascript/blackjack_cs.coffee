class Card
  
  # Class Constructor
  constructor: (@suit, @number) ->
    @_id = "" + @suit + @number
  
  # Class Functions
  getId: ->
    return @_id
    
  getNumber: ->
    return @number
    
  getSuit: ->
    return @suit
    
  getValue: ->
    card = @number % 13
    if card == 0 or card == 11 or card == 12
      return 10
    else if card == 1
      return 11
      
class Deck
  
  constructor: ->
    @cards = []
    @suits = [1, 2, 3, 4]
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    
    for suit in @suits
      for number in @numbers
        @cards.push(new Card(suit, number))
    
  deal: ->
    suit = Math.floor(Math.random() * @suits.length + 1)
    number = Math.floor(Math.random() * @numbers.length + 1)
    cIndex = @hasCard(new Card(suit, number))
    
    if cIndex != -1
      results = @cards.splice(cIndex, 1)
      return results[0]
    else
      return @deal()
    
  hasCard: (card) ->
    i = 0
    for card, i in @cards
      return i if card.getId() == @cards[i].getId()
    return -1
    
  numberOfCardsLeft: ->
    return @cards.length
    
class Hand
  
  constructor: (deck) ->
    @cards = []
    @cards.push(deck.deal())
    @cards.push(deck.deal())
    
  getHand: ->
    return @cards
    
  hitMe: ->
    @cards.push(deck.deal()) if deck.numberOfCardsLeft() >= 1
    
  printHand: ->
    hand =""
    
    for card, i in @cards
      s = card.getSuit()
      n = card.getNumber()
      
      switch n
        when 1 then hand += "Ace"
        when 11 then hand += "Jack"
        when 12 then hand += "Queen"
        when 13 then hand += "King"
        else hand += n
        
      hand += " of "
      
      switch s
        when 1 then hand += "Hearts"
        when 2 then hand += "Diamonds"
        when 3 then hand += "Clubs"
        when 4 then hand += "Spades"
        
      hand += ", " if i < @cards.length - 1
    
    return hand
    
  score: ->
    total = 0
    numOfAces = 0
    
    for card in @cards
      cardValue = card.getValue()

      numOfAces++ if cardValue == 11
      total += cardValue
      
      if total > 21 and numOfAces > 0
        while numOfAces > 0
          total -= 10
          numOfAces--
    
    return total
    
declareWinner = (userHand, dealerHand) ->
  userScore = userHand.score()
  dealerScore = dealerHand.score()
  
  if userScore > 21
    if dealerScore > 21
      return "You tied (bust)!"
    else
      return "You lost (bust)!"
  else
    if dealerScore > 21
      return "You win (dealer bust)!"
    else
      if userScore == dealerScore
        return "You tied!"
      else if userScore > dealerScore
        return "You won!"
      else
        return "You lost!"
        
playAsDealer =  ->
  h = new Hand(deck)
  h.hitMe() while h.Score() < 17
  return h
  
playAsUser = ->
  h = new Hand(deck)
  continuePlaying = false
  
  loop
    continuePlaying = confirm("HAND: " + h.printHand() + "; SCORE: " + h.score() + "; 'OK' to hit, 'CANCEL' to stay");
    break if h.score() > 21
    h.hitMe() if continuePlaying
    break if !continuePlaying
  
  return h
  
playGame = ->
  userHand = playAsUser(deck)
  dealerHand = playAsDealer(deck)
  
  console.log(declareWinner(userHand, dealerHand) + "\n")
  console.log("User hand: " + userHand.printHand() + " (score of " + userHand.score() + ")\n")
  console.log("Dealer hand: " + dealerHand.printHand() + " (score of " + dealerHand.score() + ")\n")
  return
  
deck = new Deck()
playGame()