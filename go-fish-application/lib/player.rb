class Player
  attr_accessor :name, :hand, :completed_matches

  def initialize(name)
    @name = name
    @hand = []
    @completed_matches = []
  end

  def has_card?(rank)
    hand.map(&:rank).include?(rank)
  end

  def unique_ranks
    @hand.map{|card| card.rank}.uniq
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  def add_players_cards_to_hand(cards)
    cards.each {|card| hand.push(card)}
  end

  def hand_rank_counter
    hand_rank_counter = Hash.new(0)
    hand.each {|card| hand_rank_counter[card.rank] += 1}
    hand_rank_counter
  end

  def remove_from_hand(given_rank)
    inquired_rank_arr = hand.select do |card|
      card.rank == given_rank
    end
    hand.delete_if do |card|
      card.rank == given_rank
    end
    inquired_rank_arr
  end

  def count_matches_in_hand(rank)
    card_rank_counter = Hash.new(0)
    hand.each {|card| card_rank_counter[card.rank] += 1}
    card_rank_counter.each do |rank, cards|
      if cards == 4
        remove_from_hand(rank)
        completed_matches.push(rank)
      end
    end
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
