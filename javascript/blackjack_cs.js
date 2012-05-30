// Generated by CoffeeScript 1.3.3
(function() {
  var Card, Deck, Hand, deck, declareWinner, playAsDealer, playAsUser, playGame;

  Card = (function() {

    function Card(suit, number) {
      this.suit = suit;
      this.number = number;
      this._id = "" + this.suit + this.number;
    }

    Card.prototype.getId = function() {
      return this._id;
    };

    Card.prototype.getNumber = function() {
      return this.number;
    };

    Card.prototype.getSuit = function() {
      return this.suit;
    };

    Card.prototype.getValue = function() {
      var card;
      card = this.number % 13;
      if (card === 0 || card === 11 || card === 12) {
        return 10;
      } else if (card === 1) {
        return 11;
      }
    };

    return Card;

  })();

  Deck = (function() {

    function Deck() {
      var number, suit, _i, _j, _len, _len1, _ref, _ref1;
      this.cards = [];
      this.suits = [1, 2, 3, 4];
      this.numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      _ref = this.suits;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        suit = _ref[_i];
        _ref1 = this.numbers;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          number = _ref1[_j];
          this.cards.push(new Card(suit, number));
        }
      }
    }

    Deck.prototype.deal = function() {
      var cIndex, number, results, suit;
      suit = Math.floor(Math.random() * this.suits.length + 1);
      number = Math.floor(Math.random() * this.numbers.length + 1);
      cIndex = this.hasCard(new Card(suit, number));
      if (cIndex !== -1) {
        results = this.cards.splice(cIndex, 1);
        return results[0];
      } else {
        return this.deal();
      }
    };

    Deck.prototype.hasCard = function(card) {
      var i, _i, _len, _ref;
      i = 0;
      _ref = this.cards;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        card = _ref[i];
        if (card.getId() === this.cards[i].getId()) {
          return i;
        }
      }
      return -1;
    };

    Deck.prototype.numberOfCardsLeft = function() {
      return this.cards.length;
    };

    return Deck;

  })();

  Hand = (function() {

    function Hand(deck) {
      this.cards = [];
      this.cards.push(deck.deal());
      this.cards.push(deck.deal());
    }

    Hand.prototype.getHand = function() {
      return this.cards;
    };

    Hand.prototype.hitMe = function() {
      if (deck.numberOfCardsLeft() >= 1) {
        return this.cards.push(deck.deal());
      }
    };

    Hand.prototype.printHand = function() {
      var card, hand, i, n, s, _i, _len, _ref;
      hand = "";
      _ref = this.cards;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        card = _ref[i];
        s = card.getSuit();
        n = card.getNumber();
        switch (n) {
          case 1:
            hand += "Ace";
            break;
          case 11:
            hand += "Jack";
            break;
          case 12:
            hand += "Queen";
            break;
          case 13:
            hand += "King";
            break;
          default:
            hand += n;
        }
        hand += " of ";
        switch (s) {
          case 1:
            hand += "Hearts";
            break;
          case 2:
            hand += "Diamonds";
            break;
          case 3:
            hand += "Clubs";
            break;
          case 4:
            hand += "Spades";
        }
        if (i < this.cards.length - 1) {
          hand += ", ";
        }
      }
      return hand;
    };

    Hand.prototype.score = function() {
      var card, cardValue, numOfAces, total, _i, _len, _ref;
      total = 0;
      numOfAces = 0;
      _ref = this.cards;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        card = _ref[_i];
        cardValue = card.getValue();
        if (cardValue === 11) {
          numOfAces++;
        }
        total += cardValue;
        if (total > 21 && numOfAces > 0) {
          while (numOfAces > 0) {
            total -= 10;
            numOfAces--;
          }
        }
      }
      return total;
    };

    return Hand;

  })();

  declareWinner = function(userHand, dealerHand) {
    var dealerScore, userScore;
    userScore = userHand.score();
    dealerScore = dealerHand.score();
    if (userScore > 21) {
      if (dealerScore > 21) {
        return "You tied (bust)!";
      } else {
        return "You lost (bust)!";
      }
    } else {
      if (dealerScore > 21) {
        return "You win (dealer bust)!";
      } else {
        if (userScore === dealerScore) {
          return "You tied!";
        } else if (userScore > dealerScore) {
          return "You won!";
        } else {
          return "You lost!";
        }
      }
    }
  };

  playAsDealer = function() {
    var h;
    h = new Hand(deck);
    while (h.Score() < 17) {
      h.hitMe();
    }
    return h;
  };

  playAsUser = function() {
    var continuePlaying, h;
    h = new Hand(deck);
    continuePlaying = false;
    while (true) {
      continuePlaying = confirm("HAND: " + h.printHand() + "; SCORE: " + h.score() + "; 'OK' to hit, 'CANCEL' to stay");
      if (h.score() > 21) {
        break;
      }
      if (continuePlaying) {
        h.hitMe();
      }
      if (!continuePlaying) {
        break;
      }
    }
    return h;
  };

  playGame = function() {
    var dealerHand, userHand;
    userHand = playAsUser(deck);
    dealerHand = playAsDealer(deck);
    console.log(declareWinner(userHand, dealerHand) + "\n");
    console.log("User hand: " + userHand.printHand() + " (score of " + userHand.score() + ")\n");
    console.log("Dealer hand: " + dealerHand.printHand() + " (score of " + dealerHand.score() + ")\n");
  };

  deck = new Deck();

  playGame();

}).call(this);
