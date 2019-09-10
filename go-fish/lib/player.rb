#says start game
#look at hand and see if they have cards

require_relative '../lib/game'
require_relative '../lib/playing_card'
require 'pry'

class GoFishPlayer
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def remove_from_hand(rank)
    inquired_rank = []
    hand.each do |card| 
      if card.value == value(rank)
        inquired_rank.push(card)
        hand.delete(card)
      end
    end
    inquired_rank
  end

  def has_card?(rank)
    hand.map(&:rank).include?(rank)
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  private

  def value(rank)
    return 11 if rank == "Jack"
    return 12 if rank == "Queen"
    return 13 if rank == "King"
    return 14 if rank == "Ace"
    rank.to_i
  end
 end
