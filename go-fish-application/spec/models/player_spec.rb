require_relative '../../lib/player'
require_relative '../../lib/playing_card'

describe 'Player' do
  let(:five_of_clubs) {PlayingCard.new("5", "Clubs")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}
  let(:queen_of_hearts) {PlayingCard.new("Queen", "Hearts")}
  let(:ace_of_diamonds) {PlayingCard.new("Ace", "Diamonds")}
  let(:five_of_diamonds) {PlayingCard.new("5", "Diamonds")}

  def initialize_two_players
    @player1 = Player.new("Mike")
    @player2 = Player.new("Joel")
  end

  def initialize_a_match_of_four
    @card1 = PlayingCard.new("5", "Clubs")
    @card2 = PlayingCard.new("8", "Diamonds")
    @card3 = PlayingCard.new("5", "Spades")
    @card4 = PlayingCard.new("5", "Diamonds")
    @card5 = PlayingCard.new("5", "Hearts")
  end

  def initialize_three_cards
    @card1 = PlayingCard.new("3", "Clubs")
    @card2 = PlayingCard.new("8", "Diamonds")
    @card3 = PlayingCard.new("3", "Spades")
  end

  describe '#remove_from_hand' do
    it 'it removes and returns an array of cards matching a rank from a players hand' do
      initialize_two_players
      initialize_three_cards
      @player1.add_cards_to_hand(@card1, @card3)
      @player2.add_cards_to_hand(@card2)
      matching_cards = @player1.remove_from_hand("3")
      expect(@player1.hand).to eq []
      expect(matching_cards).to eq [@card1, @card3]
    end
  end

  describe '#has_card?' do
    it 'returns a true if the player has the given rank in their hand' do
      player = Player.new("Billy")
      player.add_cards_to_hand(PlayingCard.new("4", "Spades"))
      player.add_cards_to_hand(PlayingCard.new("6", "Diamonds"))
      expect(player.has_card?("4")).to eq true
      expect(player.has_card?("Ace")).to eq false
    end

    it 'returns false if given player doesn\'t have given rank in hand' do
      player = Player.new("Danny")
      player.add_cards_to_hand(PlayingCard.new("5", "Clubs"))
      expect(player.has_card?("King")).to eq false
    end
  end

  describe '#add_cards_to_hand' do
    it 'adds an array of cards to a given players hand' do
      player = Player.new("Jamie")
      card1 = PlayingCard.new("3", "Clubs")
      card2 = PlayingCard.new("8", "Diamonds")
      player.add_cards_to_hand(card1, card2)
      expect(player.hand.count).to eq 2
    end
  end

  describe '#card_rank_counter' do
    it 'gives a player two fives because they asked for fives' do
      game = Game.new("Chris", "Evans")
      game.players[0].add_cards_to_hand(five_of_clubs, eight_of_diamonds)
      game.players[1].add_cards_to_hand(five_of_spades, five_of_diamonds, queen_of_hearts)
      game.players[0].count_matches_in_hand(five_of_clubs.rank)
      expect(game.players[0].hand.count).to eq 4
    end
  end

  describe '#count_matches_in_hand' do
    it 'if a given player has 4 of a rank, it is put into their completed_matches' do
      player = Player.new("Jack")
      initialize_a_match_of_four
      player.add_cards_to_hand(@card1, @card2, @card3, @card4, @card5)
      player.count_matches_in_hand(@card1.rank)
      expect(player.completed_matches.count).to eq 1
    end
  end
end