require_relative 'card_deck'
require_relative 'war_game'

class PlayingCard
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s 
    "#{@rank} of #{suit}"
  end

  def tie(other)
    self.assign_card_value == other&.assign_card_value
  end

  def wins(other)
    self.assign_card_value > other.assign_card_value
  end

  def assign_card_value
    return 11 if @rank == "Jack"
    return 12 if @rank == "Queen"
    return 13 if @rank == "King"
    return 14 if @rank == "Ace"
    @rank.to_i
  end
end
