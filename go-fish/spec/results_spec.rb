require_relative '../lib/results'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/playing_card'

describe 'GameResults' do
  def initialize_four_cards
    @card1 = PlayingCard.new("5", "Clubs")
    @card2 = PlayingCard.new("8", "Diamonds")
    @card3 = PlayingCard.new("5", "Spades")
    @card4 = PlayingCard.new("Queen", "Hearts")
  end

  describe '#initialize' do
    it 'returns a message when a given player asks for a rank they don\'t have' do
      game = GoFishGame.new("Andrew", "Garfield")
      result = GameResult.new(game.players[0].name, game.players[1].name, "Ace")
      initialize_four_cards
      game.players[0].add_cards_to_hand(@card1, @card2)
      game.players[1].add_cards_to_hand(@card3, @card4)
      expect(game.inquire_for_card(game.players[0], game.players[1], "Ace")).to eq result.player_results[:inquiring_player_no_rank_message]
    end

    it 'returns a message when a given player receives a card from another player' do
      game = GoFishGame.new("Matt", "Damon")
      result = GameResult.new(game.players[0].name, game.players[1].name, "5")
      initialize_four_cards
      game.players[0].add_cards_to_hand(@card1, @card2)
      game.players[1].add_cards_to_hand(@card3, @card4)
      expect(game.inquire_for_card(game.players[0], game.players[1], "5")).to eq result.player_results[:inquring_player_take_rank_message]
    end

    it 'returns a message when a given player asks for a rank that the other player doesn\'t have' do
      game = GoFishGame.new("Matt", "Damon")
      result = GameResult.new(game.players[0].name, game.players[1].name, "8")
      initialize_four_cards
      game.players[0].add_cards_to_hand(@card1, @card2)
      game.players[1].add_cards_to_hand(@card3, @card4)
      expect(game.inquire_for_card(game.players[0], game.players[1], "8")).to eq result.player_results[:inquired_player_no_rank_message]
    end

    # it 'tells a given player to go again because they fished what they asked for' do
    #   game = GoFishGame.new("Spain", "Meeker")
    #   result = GameResult.new(game.players[0], game.players[1], "8")
    #   initialize_four_cards
    #   game.players[0].add_cards_to_hand(card1, card2)
    #   game.players[1].add_cards_to_hand(card2, card3)
    #   game.inquire_for_card(game.players[0], game.players[1], "8")
    #   expect(game.go_fish()).to eq result.player_results[:inquiring_player_fished_rank]
    # end
  end
end