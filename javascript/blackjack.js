/**** CLASSES *****/

function Card(suit, number) {
    // Variables
    var _id = "" + suit + number;
    var _suit = suit;
    var _number = number;
    
    // Functions
    this.getId = function() {
        return _id;
    }

    this.getNumber = function() {
        return _number;
    };

    this.getSuit = function() {
        return _suit;
    };

    this.getValue = function() {
        var card = _number % 13;
        if (card == 0 || card == 11 || card == 12)
        return 10;
        else if (card == 1)
        return 11;
        else
        return card;
    };
}

function Deck() {
    // Variables
    var _cards = [];
    var _suits = [1, 2, 3, 4];
    var _numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

    // Functions
    this.deal = function() {
        var suit = Math.floor(Math.random() * _suits.length + 1);
        var number = Math.floor(Math.random() * _numbers.length + 1);
        var c = new Card(suit, number);
        var cIndex;

        if ((cIndex = this.hasCard(c)) != -1) {
            var results = _cards.splice(cIndex, 1);
            return results[0];
        }
        else {
            return this.deal();
        }
    };

    this.hasCard = function(card) {
        for (var i = 0; i < _cards.length; i++) {
            if (card.getId() == _cards[i].getId())
            return i;
        }

        return - 1;
    }
    
    this.numberOfCardsLeft = function() {
        return _cards.length;
    };
    
    // Logic
    for (var i = 0; i < _suits.length; i++) {
        for (var j = 0; j < _numbers.length; j++) {
            _cards.push(new Card(_suits[i], _numbers[j]));
        }
    }
}

function Hand() {
    // Variables
    var _cards = [];

    // Functions
    this.getHand = function() {
        return _cards;
    };

    this.hitMe = function() {
        if (deck.numberOfCardsLeft() >= 1)
        _cards.push(deck.deal());
    };

    this.printHand = function() {
        var hand = "";
        for (var i = 0; i < _cards.length; i++) {
            var s = _cards[i].getSuit();
            var n = _cards[i].getNumber()

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
                break;
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
                break;
            default:
                break;
            }

            if (i < _cards.length - 1)
            hand += ", ";
        }

        return hand;
    }

    this.score = function() {
        var total = 0;
        var numOfAces = 0;
        for (var i = 0; i < _cards.length; i++) {
            // Count how many aces we have
            if (_cards[i].getValue() == 11)
            numOfAces++;

            // Count up our score; by default, treat
            // aces as 11
            total += _cards[i].getValue();

            // If we're over 21 and we have at least
            // once ace, let's try reducing those to
            // a value of 1
            if (total > 21 && numOfAces > 0) {
                while (numOfAces > 0) {
                    total -= 10;
                    numOfAces--;
                }
            }
        }

        return total;
    };
    
    // Logic
    _cards.push(deck.deal());
    _cards.push(deck.deal());
}

/**** FUNCTIONS *****/

function declareWinner(userHand, dealerHand) {
    var userScore = userHand.score();
    var dealerScore = dealerHand.score();

    if (userScore > 21) {
        if (dealerScore > 21)
          return "You tied (bust)!";
        else
          return "You lose (bust)!";
    }
    else {
        if (dealerScore > 21)
          return "You win (dealer bust)!";
        else {
            if (userScore == dealerScore)
            return "You tied!";
            else if (userScore > dealerScore)
            return "You win!";
            else
            return "You lose!";
        }
    }
}

function playAsDealer() {
    var h = new Hand();
    while (h.score() < 17) {
        h.hitMe();
    }

    return h;
}

function playAsUser() {
    var h = new Hand();
    var continuePlaying = false;

    do {
        continuePlaying = confirm("HAND: " + h.printHand() + "; SCORE: " + h.score() + "; 'OK' to hit, 'CANCEL' to stay");
        if (h.score() > 21)
          break;
        if (continuePlaying)
          h.hitMe();
    }
    while (continuePlaying)

    return h;
}

function playGame() {
    var userHand = playAsUser(deck);
    var dealerHand = playAsDealer(deck);

    console.log(declareWinner(userHand, dealerHand) + "\n");
    console.log("User hand: " + userHand.printHand() + " (score of " + userHand.score() + ")\n");
    console.log("Dealer hand: " + dealerHand.printHand() + " (score of " + dealerHand.score() + ")\n");
}

/**** MAIN PROGRAM *****/
var deck = new Deck();
playGame();