require_relative '../lib/room'
class RoomPlayer
  attr_accessor :player, :name
  def initialize(name)
    @name = name
  end

  def assign_clients_to_players
    game.players.each do |player|
      room_players.each do |room_player|
        room_player.player == player.player
        room_player.player = player if room_player.name == player.name
      end
    end
  end
end