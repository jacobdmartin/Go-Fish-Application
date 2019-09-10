require_relative 'war_player'
require_relative 'card_deck'
require_relative 'playing_card'
require 'pry'

class WarGame
  attr_reader :player1, :player2, :deck, :tie_stack
  
  def initialize
    @player1 = WarPlayer.new("Billy")
    @player2 = WarPlayer.new("Tessa")
    @deck = CardDeck.new
    @tie_stack = []
  end

  def start
    deck.shuffle
    while deck.any_cards_left? do
      player1.add_cards_to_hand(@deck.deal)
      player2.add_cards_to_hand(@deck.deal)
    end
  end

  def play_round
      card1 = player1.draw_card
      card2 = player2.draw_card
      cards_tie(card1, card2) if card1.tie(card2)
      wins(player1, card1, card2) if card1.wins(card2)
      wins(player2, card2, card1) if card2.wins(card1)
  end

  def cards_tie(card1, card2)
    add_to_tie_stack(card1, card2)
    "#{player1.name} and #{player2.name} tied with #{card1.to_s}"
  end

  def wins(player, card1, card2)
    player = player
    player.add_cards_to_hand(card1, card2)
    give_tie_stack(player)
    "#{player.name} took a #{card2} with a #{card1}"
  end

  def tie_rounds
    tie_stack.count / 2
  end

  def give_tie_stack(player)
    tie_stack.each do |tie_card|
      player.add_cards_to_hand(tie_card)
      tie_stack = []
    end
    "#{player.name} won the tie after #{tie_rounds} ties"
  end

  def add_to_tie_stack(card1, card2)
    tie_stack.push(card1, card2)
  end

  def winner
    if player1.players_hand.count == 0
      return player2
    elsif player2.players_hand.count == 0
      return player1
    end
  end
end
