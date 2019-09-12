#TSTTCPW (the simplest thing that can possibly work)
#initialize: card deck, players
#shuffle cards
#deal cards

require_relative '../lib/room'
require_relative '../lib/server'
require_relative '../lib/playing_card'
require_relative '../lib/player'
require_relative '../lib/results'
require 'pry'

class GoFishGame
  attr_reader :card_deck, :players, :current_player

  def initialize(*players_names)
    @card_deck = CardDeck.new
    @players = players_names.map {|player_name| GoFishPlayer.new(player_name)}
    @current_player = @players[0]
  end

  def start
    card_deck.shuffle
  end 

  def deal_count
    players.count >= 3 ? 5 : 7
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  def deal_cards
    deal_count.times do 
      players.each {|player| player.add_cards_to_hand(card_deck.deal)}
    end
  end

  def go_fish(player)
    card = card_deck.deal
    player.add_cards_to_hand(card)
    card
  end

  def result(inquiring_player, inquired_player, rank)
    result = GameResult.new(inquiring_player.name, inquired_player.name, rank)
  end

  def inquire_for_card(inquiring_player, inquired_player, rank)
    if inquiring_player.has_card?(rank) == false
      inquiring_player_no_rank_outcome(inquiring_player, inquired_player, rank)
    elsif inquiring_player.has_card?(rank) && inquired_player.has_card?(rank)
      both_have_rank_outcome(inquiring_player, inquired_player, rank)
    elsif inquired_player.has_card?(rank) == false
      inquired_player_no_rank_outcome(inquiring_player, inquired_player, rank)
    end
  end
  
  def inquiring_player_no_rank_outcome(inquiring_player, inquired_player, rank)
    result(inquiring_player, inquired_player, rank).player_results[:inquiring_player_no_rank_message]
  end

  def both_have_rank_outcome(inquiring_player, inquired_player, rank)
    inquiring_player.add_cards_to_hand(inquired_player.remove_from_hand(rank))
    result(inquiring_player, inquired_player, rank).player_results[:inquring_player_take_rank_message]
  end

  def inquired_player_no_rank_outcome(inquiring_player, inquired_player, rank)
    card = go_fish(inquiring_player)
    fish_rank_asked_for(inquiring_player, inquired_player, card, rank)
  end

  def fish_rank_asked_for(inquiring_player, inquired_player, card, rank)
    if card.rank == rank
      result(inquiring_player, inquired_player, rank).player_results[:inquiring_player_fished_rank]
      current_player = inquiring_player
    elsif card.rank != rank
      advance_player
      result(inquiring_player, inquired_player, rank).player_results[:inquired_player_no_rank_message]
    end
  end

  def advance_player
    if current_player = players.last
      current_player
    else
      current_player = players[players.index(current_player + 1)]
    end
  end
end