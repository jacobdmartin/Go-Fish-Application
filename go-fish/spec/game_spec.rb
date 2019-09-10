require_relative '../lib/game'
require_relative '../lib/card_deck'
require 'pry'

describe 'GoFishGame' do
  def initialize_four_players
    @player1 = GoFishPlayer.new("Danny")
    @player2 = GoFishPlayer.new("Amy")
    @player3 = GoFishPlayer.new("Skyie")
    @player4 = GoFishPlayer.new("Persie")
  end

  def initialize_two_players
    @player1 = GoFishPlayer.new("Mike")
    @player2 = GoFishPlayer.new("Joel")
  end

  describe '#start' do
    it 'shuffles the deck of cards' do
      game1 = GoFishGame.new("Bill")
      game2 = GoFishGame.new("Louis")
      game1.start
      expect(game1.card_deck).to_not eq(game2.card_deck)
    end
  end

  describe '#deal_cards_to_players' do
    it 'puts 7 cards into the given players hand' do
      game = GoFishGame.new("Jim", "Jansen")
      game.start
      game.deal_count
      game.deal_cards
      expect(game.players[0].hand.count).to eq 7
      expect(game.card_deck.cards_left).to eq 38
    end

    it 'deals 5 cards into the given players hands' do
      game = GoFishGame.new("Juliet", "James", "John")
      game.start
      game.deal_count
      game.deal_cards
      expect(game.players[0].hand.count).to eq 5
      expect(game.card_deck.cards_left).to eq 37
    end
  end
  
  describe '#deal_count' do
    it 'counts number of players in a game' do
      game = GoFishGame.new("Diana")
      game.deal_count
      expect(game.deal_count).to eq 7
    end
  end

  it 'returns true if player1 gets an 8 from player3' do

  end
end