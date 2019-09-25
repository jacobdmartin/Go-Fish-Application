require_relative '../../lib/game'
require_relative '../../lib/card_deck'
require 'pry'

describe 'Game' do
  def initialize_new_game
    @game = Game.new("Hannah", "John", "Abbie")
    @game.start
  end

  def initialize_four_players
    @player1 = Player.new("Danny")
    @player2 = Player.new("Amy")
    @player3 = Player.new("Skyie")
    @player4 = Player.new("Persie")
  end

  def initialize_two_players
    @player1 = Player.new("Mike")
    @player2 = Player.new("Joel")
  end

  def initialize_three_cards
    @card1 = PlayingCard.new("Jack", "Hearts")
    @card2 = PlayingCard.new("Jack", "Diamonds")
    @card3 = PlayingCard.new("9", "Hearts")
  end

  def add_initialized_cards_to_both_hands
    @game.players[0].add_cards_to_hand(@card1, @card3)
    @game.players[1].add_cards_to_hand(@card2)
  end

  describe '#start' do
    it 'shuffles the deck of cards' do
      game1 = Game.new("Bill")
      game2 = Game.new("Louis")
      game1.start
      expect(game1.card_deck).to_not eq(game2.card_deck)
    end
  end

  describe '#deal_count' do
    it 'counts number of players in a game' do
      game = Game.new("Diana")
      game.deal_count
      expect(game.deal_count).to eq 7
    end
  end

  describe '#add_cards_to_hand' do
    it 'adds two cards to a given players hand' do
      game = Game.new("Derrick")
      card1 = PlayingCard.new("Jack", "Hearts")
      card2 = PlayingCard.new("King", "Diamonds")
      game.players[0].add_cards_to_hand(card1, card2)
      expect(game.players[0].hand.count).to eq 2
    end
  end

  describe '#deal_cards' do
    it 'puts 7 cards into the 2 given players hands' do
      game = Game.new("Jim", "Jansen")
      game.start
      game.deal_count
      expect(game.players[0].hand.count).to eq 7
      expect(game.card_deck.cards_left).to eq 38
    end

    it 'deals 5 cards into the 3 (or more) given players hands' do
      game = Game.new("Juliet", "James", "John")
      game.start
      game.deal_count
      game.deal_cards
      expect(game.players[0].hand.count).to eq 5
      expect(game.card_deck.cards_left).to eq 37
    end
  end

  describe '#result' do
    it 'receives and passes parameters of (inquiring_player, inquired_player, rank) into result' do
      initialize_new_game
      initialize_three_cards
      add_initialized_cards_to_both_hands
      @game.inquire_for_card(@game.players[1], @game.players[0], "Jack")
      expect(@game.players[0].hand.count).to eq 1
      expect(@game.players[1].hand.count).to eq 2
    end
  end

  describe '#inquire_for_card' do
    # it 'takes card from a given player and gives it to another given player' do
    #   initialize_new_game
    #   initialize_three_cards
    #   add_initialized_cards_to_both_hands
    #   result = @game.inquire_for_card(@game.players[1], @game.players[0], "Jack")
    #   expect(@game.players[0].hand.count).to eq 1
    #   expect(@game.players[1].hand.count).to eq 2
    #   expect(result.return_cards).to eq 2 
    # end

    it 'a given player tells a player to go fish because they don\'t have a given rank' do
      initialize_new_game
      initialize_three_cards
      add_initialized_cards_to_both_hands
      @game.inquire_for_card(@game.players[0], @game.players[1], "9")
      expect(@game.players[0].hand.count).to eq 3
      expect(@game.players[1].hand.count).to eq 1
    end

    it 'a given player goes fishing and adds the card to their hand' do
      initialize_new_game
      initialize_three_cards
      add_initialized_cards_to_both_hands
      @game.inquire_for_card(@game.players[0], @game.players[1], "9")
      expect(@game.players[0].hand.count).to eq 3
      expect(@game.players[1].hand.count).to eq 1
    end

    describe '#advance_player' do
      it 'goes to the next players turn' do
        game = Game.new("Billy", "Jamie")
        game.start
        expect(game.advance_player).to eq(game.players[1])
      end
    end

    describe '#fish_rank_asked_for' do
      it 'tells a given player to take another turn because they fished what they asked for' do
        initialize_new_game
        initialize_three_cards
        add_initialized_cards_to_both_hands
        @game.inquire_for_card(@game.players[0], @game.players[1], "Ace")
        expect(@game.card_deck.deal.rank).to eq("Ace")
      end
    end
  end
end