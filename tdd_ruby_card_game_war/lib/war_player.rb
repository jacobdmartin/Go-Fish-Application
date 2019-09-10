 class WarPlayer
  attr_reader :name, :players_hand

  def initialize(name)
    @name = name
    @players_hand = []
  end 

  def add_cards_to_hand(*cards)
    cards.each do |card|
      @players_hand.push(card)
    end
  end

  def draw_card
    @players_hand.shift
  end

  def any_cards_left?
    @players_hand.count > 0
  end

  def initialize_two_cards
    @card1 = PlayingCard.new("Jack", "Hearts")
    @card2 = PlayingCard.new("Ace", "Diamonds")
  end
 end
