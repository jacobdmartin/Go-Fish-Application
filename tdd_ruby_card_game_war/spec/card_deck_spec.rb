require_relative '../lib/card_deck'

describe 'CardDeck' do
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    deck = CardDeck.new
    card = deck.deal
    expect(card).to_not be_nil
    expect(deck.cards_left).to eq 51
  end

  it 'stocks deck with 52 unique cards' do
    deck = CardDeck.new
    expect(deck.card_pile.uniq.count).to eq 52
  end

  it 'will return true if the first array is shuffled' do
    deck = CardDeck.new
    deck2 = CardDeck.new
    deck.shuffle
    expect(deck.card_pile).to_not eq(deck2.card_pile)
  end
end
