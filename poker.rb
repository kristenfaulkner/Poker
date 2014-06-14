class Card
end

class Deck
  
  attr_accessor :deck
  
  NUMBERS = [1, 2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 ,11 , 12, 13]
  SUITS = [:heart, :spade, :club, :diamond]
  
  def initialize
    make_deck 
  end
    
  def make_deck
    @deck = []
    NUMBERS.each do |num|
      SUITS.each do |suit|
        @deck << [num, suit]
      end
    end
    @deck.shuffle
  end
  
end
# 
class Hand
  attr_accessor :hand
  def initialize(deck)
    @hand = deck.take(5)
  end
  
  def type
    self.three_kind? || self.two_pair? || self.pair? || "losing hand"
  end
  
  def selects_best
    
  end
  
  def pair?
    paircards = @hand.select {|card| @hand.flatten.count(card[0]) == 2}
    if paircards.length == 2
      return paircards
    else
      return false
    end
  end

  def three_kind?
    triplecards = @hand.select {|card| @hand.flatten.count(card[0]) == 3}
    if triplecards.length == 3
      return triplecards
    else 
      return false
    end
  end
  
  def two_pair?
    paircards = @hand.select {|card| @hand.flatten.count(card[0]) == 2}
    if paircards.length == 4
      return paircards
    else
      return false
    end
  end
  
  # def straight?
  #   !@hand.pair? && @hand.flatten.sort
  #   end
  #   
  #   def flush?
  #   end
  #   
  #   def full_house?
  #   end
end

class Player
  
  attr_accessor :hand, :pot
  attr_reader :name
  
  def initialize(hand, pot, name)
    @hand, @pot = hand, pot, @name
  end
  
    
  def discard_cards(to_discard)
    self.hand.delete(to_discard)
    return self.hand
  end
  
  def make_move(choice)
    if choice == "see"
      @pot -= 
      #see
    when "raise"
      #end
    end
  end
  
end


class Game
  attr_reader :deck, :players, :currentbet
  def initialize(*players)
    @deck = Deck.new.deck
    @currentbet = 0
    @moneybowl = 0
    @players = players
    @players.each {|name| Player.new(Hand.new(@deck), 100, name)}
    play
  end
  
  def play
    players.each {|player| get_move(player)}
    players.each {|player| get_discard(player)}
    players.each {|player| get_move(player)}
    check_winner
  end
  
  def hand_list
    winning_hands = {
      pair
    }
    player_hands = players.map {|player| [player, player.hand]} 
    player_hands.select {|hand| hand.type ==  } ||
    player_hands.select {|hand| hand.type ==  } ||
    player_hands.select {|hand| hand.type ==  } ||
    player_hands.select {|hand| hand.type ==  } ||
    player_hands.select {|hand| hand.type ==  } ||
    player_hands.select {|hand| hand.type ==  } ||
      
    
    
  end
  
  def get_discard(player)
    puts "Please type the cards you would like to discard in an array [[]]"
    discard = gets.chomp
    if player.hand.all? {|card| player.hand.include?(discard)}
      puts "Sorry, you can't discard cards that arent in your hand"
      get_discard(player)
    else
      player.discard_cards(discard)
    end
  end
  
  def get_move(player)
    puts "Would you like to fold, see, or raise?"
    choice = gets.chomp
    if choice == "fold"
      players.remove(player)
    elsif player.pot < currentbet
      puts "Sorry, you don't have enough money to bet"
      players.remove(player)
    elsif choice == "see"
      @moneybowl += currentbet
      player.pot -= currentbet
    else
      puts "how much in total would you like to bid?"
      new_bet = gets.chomp.to_i
      if player.pot < new_bet
        puts "Sorry, you don't have enough money to raise"
        @moneybowl += currentbet
        player.pot -= currentbet
      else
        @moneybowl += new_bet
        player.pot -= new_bet
        current_bet = new_bet
      end
    end
  end
end