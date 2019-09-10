require_relative 'war_game'

game = WarGame.new
game.start
@rounds = 0
until game.winner do
  puts game.play_round
  @rounds += 1
end
puts "Winner: #{game.winner.name}"
puts "Cards: #{game.winner.players_hand.count}"
puts "Rounds: #{@rounds}"