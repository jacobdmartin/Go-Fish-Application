require_relative 'playing_card'
require_relative 'game'
require_relative 'player'
require 'pry'

class CardDeck
  attr_reader :card_deck

  STANDARD_DECK_SIZE = 52

  def initialize
    @card_deck = []
    stock_deck
  end

  def shuffle
    @card_deck = card_deck.shuffle
  end

  def deal
    @card_deck.pop
  end

  def cards_left
    @card_deck.count
  end

  def stock_deck
    @rank = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    @suit = %w(Spades Hearts Diamonds Clubs)
    @suit.each do |suit|
      @rank.each do |rank|
        @card_deck.push(PlayingCard.new(rank, suit))
        @card_deck.each { |card| card.value }
      end
    end
  end 
end
