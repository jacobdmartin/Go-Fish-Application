require_relative 'playing_card'
require_relative 'war_game'

class CardDeck
  STANDARD_DECK_SIZE = 52

  def initialize
    @card_pile = []
    stock_deck
  end

  def cards_left
    @card_pile.count
  end

  def any_cards_left?
    @card_pile.count > 0 ? true : false
  end

  def deal
    @card_pile.pop
  end

  def stock_deck
    @rank = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    @suit = %w(Spades Hearts Diamonds Clubs)
    @suit.each do |suit|
      @rank.each do |rank|
        @card_pile.push(PlayingCard.new(rank, suit))
        @card_pile.each { |card| card.assign_card_value }
      end
    end
  end 

  def card_pile
    @card_pile
  end

  def shuffle
    @card_pile = card_pile.shuffle
  end
end
