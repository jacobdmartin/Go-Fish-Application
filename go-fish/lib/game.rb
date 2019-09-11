#initialize: card deck, players
#shuffle cards
#deal cards

require_relative 'room'
require_relative 'server'
require_relative 'playing_card'
require_relative 'player'
require 'pry'

class GoFishGame
  attr_reader :card_deck, :players

  def initialize(*players_names)
    @card_deck = CardDeck.new
    @players = players_names.map {|player_name| GoFishPlayer.new(player_name)}
  end

#TSTTCPW (the simplest thing that can possibly work)

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
end