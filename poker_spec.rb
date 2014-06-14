require 'poker.rb'

describe Player do
  let(:mike) {Player.new([1,2,3,4,5], 5)}
  let(:kristen) {Player.new(7)}
  let(:bob) {Player.new([1,2,3,6,4]) }
  let(:sally) {Player.new()}
  
  
  describe "#initialize" do

    it "should return the initialized values of a new player instance" do
      expect(mike.hand).to eq([1,2,3,4,5])
    end
    
    it "should return error for empty hand" do
      expect{ kristen.hand}.to raise_error(ArgumentError)
    end
      
    it "should return error for empty pot" do
      expect{ bob.hand}.to raise_error(ArgumentError)
    end
      
    it "should return error for no parameter initialized" do
      expect{ sally.hand}.to raise_error(ArgumentError)
    end
  end
  
  describe "#discard_cards" do
    it "should discard cards" do  
      expect(mike.discard_cards(1)).to eq([2,3,4,5])
    end
    
    it "should not allow discarding cards player doesnt have" do 
      expect(mike.discard_cards(7)).to eq([1,2,3,4,5])
    end
  end
end

describe Deck do
  let(:deck1) {Deck.new.deck}
  
  describe "#make_deck" do
    
    it "should return a deck of length 52" do
      expect(deck1.length).to eq(52)
    end
    
    it "should include a random card from the deck" do
      expect(deck1.include?([4,:spade])).to be_true
    end
    
    it "should include 13 cards from each suit" do
      expect(deck1.select {|card| card[1] == :heart}.length).to eq(13)
    end
    
    it "shoud include 4 cards from each number" do
      expect(deck1.select {|card| card[0] == 5}.length).to eq(4)
    end
  end
end

describe Game do
  let(:new_game) {Game.new}
  describe "#initialize" do
    it "shoud initialize 2 players automatically" do
      expect(new_game.player1.pot).to eq(100)
    end
  
    it "Each player starts with a hand of 5 cards" do
      expect(new_game.player2.hand.hand.length).to eq(5)
    end
    
    it "shoud initialize a new deck" do
      expect(new_game.deck.length).to eq(52)
    end
  end
end

describe Hand do
  
  let(:my_hand1) {Hand.new(Deck.new.deck)}
  let(:my_hand3) {Hand.new(Deck.new.deck)}
  let(:my_hand2pair) {Hand.new(Deck.new.deck)}
  let(:my_hand_loser) {Hand.new(Deck.new.deck)}
  
  before(:each) do
    my_hand1.hand  = [[1, :heart],[7, :club],[4, :diamond],[4, :spade],[2, :heart]]
    my_hand3.hand = [[1, :heart],[4, :club],[4, :diamond],[4, :spade],[2, :heart]]
    my_hand2pair.hand = [[7, :heart],[7, :club],[4, :diamond],[4, :spade],[2, :heart]]
    my_hand_loser.hand = [[1, :heart],[7, :club],[5, :diamond],[4, :spade],[2, :heart]]
  end
      
    describe "#type" do

      it "should return the winning 3-of-a-kind cards" do
        expect(my_hand3.type).to eq([[4, :club], [4, :diamond], [4, :spade]])
      end
      it "should return the winning pair" do
        expect(my_hand1.type).to eq([[4, :diamond], [4, :spade]])
      end
      it "should return the winning 2-pairs" do
        expect(my_hand2pair.type).to eq([[7, :heart],[7, :club],[4, :diamond],[4, :spade]])
      end
      it "should call out a losing hand" do
        expect(my_hand_loser.type).to eq("losing hand")
      end
    end
      
    describe "#pair?" do

      it "should return the winning 3-of-a-kind cards" do
        expect(my_hand3.pair?).to eq(false)
      end
      it "should return the winning pair" do
        expect(my_hand1.pair?).to eq([[4, :diamond], [4, :spade]])
      end
      it "should return the winning 2-pairs" do
        expect(my_hand2pair.pair?).to eq(false)
      end
      it "should call out a losing hand" do
        expect(my_hand_loser.pair?).to eq(false)
      end
    end
      
    describe "#two_pair?" do

      it "should return the winning 3-of-a-kind cards" do
        expect(my_hand3.two_pair?).to eq(false)
      end
      it "should return the winning pair" do
        expect(my_hand1.two_pair?).to eq(false)
      end
      it "should return the winning 2-pairs" do
        expect(my_hand2pair.two_pair?).to eq([[7, :heart],[7, :club],[4, :diamond],[4, :spade]])
      end
      it "should call out a losing hand" do
        expect(my_hand_loser.two_pair?).to eq(false)
      end
    end
        
    describe "#three_kind?" do

      it "should return the winning 3-of-a-kind cards" do
        expect(my_hand3.three_kind?).to eq([[4, :club], [4, :diamond], [4, :spade]])
      end
      it "should return the winning pair" do
        expect(my_hand1.three_kind?).to eq(false)
      end
      it "should return the winning 2-pairs" do
        expect(my_hand2pair.three_kind?).to eq(false)
      end
      it "should call out a losing hand" do
        expect(my_hand_loser.three_kind?).to eq(false)
      end
    end
    
  end

  #describe "#winner?"
  #    my_hand1pair.[[1, :heart],[7, :club],[4, :diamond],[4, :spade],[2, :heart]]
  #error
  #before do
  #expect do
  #expect_to_Receive
  #epect_to_not_receive
  # dealer_hand.should_receive(:hit).with(deck).exactly(3).times do
  # dealer_hand.should_receive(:hit).once.with(deck) do
  #double
  # #    it "should not pay losers (or ties)" do
  #       player_hand
  #         .should_receive(:beats?)
  #         .with(dealer_hand)
  #         .and_return(false)
  # 
  #       player.should_not_receive(:pay_winnings)
  #       dealer.pay_bets
  #     end