require_relative '../lib/war_game'

describe 'WarGame' do
  def initialize_two_new_cards
    @card1 = PlayingCard.new("Jack", "Hearts")
    @card2 = PlayingCard.new("Ace", "Diamonds")
  end

  it 'creates a new game and gives each player 26 cards.' do
    game = WarGame.new
    game.start
    expect(game.player1.players_hand.count).to eq 26
    expect(game.player2.players_hand.count).to eq 26
  end

  it 'returns true if the "@tie_stack" array is empty' do
    game = WarGame.new
    @player1 = WarPlayer.new("Billy")
    initialize_two_new_cards
    game.add_to_tie_stack(@card1, @card2)
    game.give_tie_stack(@player1)
    expect(@player1.players_hand.count).to eq 2
    expect(@tie_stack).to eq nil
  end

  it 'returns true if tie_rounds divides the tie_stack in two' do
    game = WarGame.new
    @player1 = WarPlayer.new("billy")
    initialize_two_new_cards
    game.add_to_tie_stack(@card1, @card2)
    game.tie_rounds
    expect(game.tie_rounds).to eq(1)
  end

  it 'returns true if one card wins' do
    game = WarGame.new
    player1 = WarPlayer.new("Billy")
    player2 = WarPlayer.new("Tessa")
    initialize_two_new_cards
    expect(@card2.wins(@card1)).to returns("Tessa took a Jack of Hearts with a Ace of Diamonds")
  end
end
