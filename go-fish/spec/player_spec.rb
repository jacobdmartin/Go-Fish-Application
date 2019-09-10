require_relative '../lib/player'

describe 'GoFishPlayer' do
  def initialize_two_players
    @player1 = GoFishPlayer.new("Mike")
    @player2 = GoFishPlayer.new("Joel")
  end

  describe '#remove_from_hand' do
    it 'it removes and returns an array of cards matching a rank from a players hand' do
      player = GoFishPlayer.new("Billy")
      card1 = PlayingCard.new("4", "Hearts")
      card2 = PlayingCard.new("7", "Hearts")
      card3 = PlayingCard.new("4", "Spades")
      player.add_cards_to_hand(card1)
      player.add_cards_to_hand(card2)
      player.add_cards_to_hand(card3)
      matching_cards = player.remove_from_hand("4")
      expect(player.hand).to eq [card2]
      expect(matching_cards).to eq [card1, card3]
    end
  end

  describe '#has_cards?' do
    it 'returns a true if the player has the given rank in their hand' do
      player = GoFishPlayer.new("Billy")
      player.add_cards_to_hand(PlayingCard.new("4", "Spades"))
      player.add_cards_to_hand(PlayingCard.new("6", "Diamonds"))
      expect(player.has_card?("4")).to eq true
      expect(player.has_card?("Ace")).to eq false
    end
  end

  describe '#add_cards_in_hand' do
    it 'adds an array of cards to a given players hand' do
      player = GoFishPlayer.new("Jamie")
      card1 = PlayingCard.new("3", "Clubs")
      card2 = PlayingCard.new("8", "Diamonds")
      player.add_cards_to_hand(card1, card2)
      expect(player.hand.count).to eq 2
    end
  end
end