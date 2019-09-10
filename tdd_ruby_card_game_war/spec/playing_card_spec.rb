require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'creates a card with a rank and suit' do
    card = PlayingCard.new("2", "Hearts")
    expect(card.rank).to eq "2"
    expect(card.suit).to eq "Hearts"
  end

  it "returns true if player1's card beats player2's card" do
    card1 = PlayingCard.new("5", "Spades")
    card2 = PlayingCard.new("3", "Hearts")
    expect(card1.wins(card2)).to eq true
  end

  it "returns true if player1 and player2's cards tie" do
    card1 = PlayingCard.new("5", "Spades")
    card2 = PlayingCard.new("5", "Hearts")
    expect(card1.tie(card2)).to eq true
  end

  it "should assign each card a value" do
    card = PlayingCard.new("Jack", "Clubs")
    card2 = PlayingCard.new("Queen", "Hearts")
    expect(card.assign_card_value).to eq 11
    expect(card2.assign_card_value).to eq 12
  end

  it 'returns true if player1 card equals the correct output string' do
    player1_card = PlayingCard.new("7", "Clubs")
    expect(player1_card.to_s).to eq("7 of Clubs")
  end

  it 'causes player2 to win against player1 in a single round of play_round' do
    game = WarGame.new
    @card1 = PlayingCard.new("Jack", "Hearts")
    @card2 = PlayingCard.new("Ace", "Diamonds")
    game.start
    game.play_round
    expect(@card2.wins(@card1)).to eq true
  end
end
