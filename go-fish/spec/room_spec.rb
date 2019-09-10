# require_relative '../lib/room'
# require_relative '../lib/game'

# describe 'GameRoom' do
#   def initialize_four_players
#     @player1 = GoFishPlayer.new("Danny")
#     @player2 = GoFishPlayer.new("Amy")
#     @player3 = GoFishPlayer.new("Skyie")
#     @player4 = GoFishPlayer.new("Persie")
#   end

#   describe '#with_four_people' do
#     it 'starts a game when four people are in a single room' do
#       initialize_four_players
#       @room_players.push(@player1)
#       @room_players.push(@player2)
#       @room_players.push(@player3)
#       @room_players.push(@player4)
#       if @room_players.count == 4
#         game = GoFishGame.new
#       end
#     end
#   end
# end