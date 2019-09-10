require_relative '../lib/war_player'

describe 'WarPlayer' do
  it 'returns true if player1 name equals "Billy" and player2 name equals "Tessa"' do
    player1 = WarPlayer.new("Billy")
    player2 = WarPlayer.new("Tessa")
    expect(player1.name).to eq "Billy"
    expect(player2.name).to eq "Tessa"
  end

  it 'adds a card to players_hand array' do
    player1 = WarPlayer.new("Billy")
    card1 = PlayingCard.new("4", "Diamonds")
    player1.add_cards_to_hand(card1)
    expect(player1.players_hand.count).to eq 1
  end

  it 'returns true if player1 hand equals 0 after he draws a card' do
    player1 = WarPlayer.new("Billy")
    card1 = PlayingCard.new("8", "Diamonds")
    player1.add_cards_to_hand(card1)
    player1.draw_card
    expect(player1.players_hand.count).to eq 0
  end

  it 'returns true if player1 has cards left in hand after drawing a card' do
    player1 = WarPlayer.new("Billy")
    player1.initialize_two_cards
    player1.add_cards_to_hand(@card1, @card2)
    player1.draw_card
    player1.any_cards_left?
    expect(player1.players_hand.count).to eq 1
  end
end
