require_relative '../lib/room'
class RoomPlayer
  attr_accessor :player, :name
  def initialize(name)
    @name = name
  end
end