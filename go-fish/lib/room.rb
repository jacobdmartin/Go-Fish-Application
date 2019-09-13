#start game
#-with clients ready
#talk to players clients
#talk to game

require_relative '../lib/player'
require_relative  '../lib/game'
require_relative '../lib/room_player'

class GameRoom
  attr_reader :room_players
  
  def initialize(room_player)
    @room_players = []
  end

  def start_game
    game = GoFishGame.new
    game.start
    room_players.each {|player| player.puts "A Game of Go Fish Has Started"}
    return true
  end
  
  def players_ready
    room_players.each do |player|
      player.puts "If you are ready press Enter"
      player.puts("Enter\n")
    end
  end

  def play_game

  end

  def display_message_to_client

  end

  def display_message_to_group

  end
end