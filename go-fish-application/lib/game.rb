require_relative '../server'
require_relative '../lib/playing_card'
require_relative '../lib/player'
require_relative '../lib/results'
require 'pry'

class Game
  attr_reader :card_deck
  attr_accessor :current_player, :started, :results, :players

  def initialize(*players_names)
    @card_deck = CardDeck.new
    @players = players_names.map {|player_name| Player.new(player_name)}
    @started = false
    @current_player = players[0]
  end

  def add_player(player)
    @players << player
    start
  end

  def find_current_player(player_name)
    @players.each {|player| return player if player.name == player_name}
  end

  def empty?
    @players.empty?
  end

  def start
    if players.count > 1
      card_deck.shuffle
      deal_count
      deal_cards
      self.current_player = @players[0]
      self.started = true
    end
  end 

  def deal_count
    players.count >= 3 ? 5 : 7
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

  def inquire_for_card(inquiring_player, inquired_player, rank)
    result = GameResult.new(inquiring_player, inquired_player, rank, self)
    self.results = result.turn_outcomes(inquiring_player, inquired_player, rank)
  end

  def add_players_card_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  def advance_player
    if current_player == players.last
      self.current_player = players[0]
    else
      self.current_player = players[players.index(current_player)+ 1]
    end
  end
end