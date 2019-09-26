require_relative '../lib/card_deck'
require_relative '../lib/game'

class PlayingCard
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "/images/cards/#{image_name}"
  end

  def image_name
    if rank == "10"
    "#{rank}#{suit[0]}"
    else
      "#{rank[0]}#{suit[0]}"
    end
  end

  def value
    return 11 if rank == "Jack"
    return 12 if rank == "Queen"
    return 13 if rank == "King"
    return 14 if rank == "Ace"
    rank.to_i
  end
end