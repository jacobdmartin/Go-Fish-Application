require_relative '../../lib/playing_card'

describe 'PlayingCard' do
  it 'creates a card with a rank and suit' do
    card = PlayingCard.new("2", "Hearts")
    expect(card.rank).to eq "2"
    expect(card.suit).to eq "Hearts"
  end

  it "should assign each card a value" do
    card = PlayingCard.new("Jack", "Clubs")
    card2 = PlayingCard.new("Queen", "Hearts")
    expect(card.value).to eq 11
    expect(card2.value).to eq 12
  end
end
