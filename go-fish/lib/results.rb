require_relative '../lib/player'
require_relative '../lib/game'

# you want to know everything about what happened.
#inquiring player
#inquired player
#inquired rank
#something about what happened
#give me a summary for player 3

class GameResult
  attr_reader :player_results
  attr_accessor :player_results 

  def initialize(inquiring_player, inquired_player, rank)
    @player_results = { inquiring_player_no_rank_message: "#{inquiring_player} you don't have a #{rank}, #{inquiring_player} ask for a different rank", inquring_player_take_rank_message: "#{inquiring_player} took a #{rank} from #{inquired_player}", inquired_player_no_rank_message: "#{inquiring_player} asked for a #{rank} from #{inquired_player} but had to Go Fish", inquiring_player_fished_rank: "#{inquiring_player} fished what they asked for, #{inquiring_player} take another turn" }
  end
end