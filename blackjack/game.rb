# frozen_string_literal: true

class Interface
  puts 'Введите имя'
  name = gets.chomp
  Game.start unless !name.nil?
end

class Game
  def start
    user = User.new
    diller = Diller.new
    deck = Deck.new
    user.get_cards(deck.pop_two_cards)
    diller.get_cards(deck.pop_two_cards)
  end
end

class Player
  attr_reader :name, :bank

  def initialize(name)
    @name = name
    @hand = Hand.new
    @bank = 100
  end

  def get_cards(cards)
    @hand.take_cards(cards)
  end
end

class User < Player
end

class Diller < Player
end

class Hand
  def initialize
    @hand = []
  end

  def take_cards(cards)
    cards.each do |card|
      @hand << card
    end
  end

  def weight
    return 11 if card_value == 'A'

    if ('2'..'10').include?(card_value)
      card_value.to_i
    else
      10
    end
  end
end

class Card
  def initialize(symbol)
    @symbol = symbol
  end

  def card_value
    @symbol[0]
  end
end

class Deck
  DECK = %w[2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ 10♠ J♠ Q♠ K♠ A♠
            2♥ 3♥ 4♥ 5♥ 6♥ 7♥ 8♥ 9♥ 10♥ J♥ Q♥ K♥ A♥
            2♦ 3♦ 4♦ 5♦ 6♦ 7♦ 8♦ 9♦ 10♦ J♦ Q♦ K♦ A♦
            2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ 10♣ J♣ Q♣ K♣ A♣].freeze

  def initialize
    @deck = initialize_deck
  end

  def initialize_deck
    DECK.shuffle.map do |card_symbol|
      Card.new(card_symbol)
    end
  end

  def pop_card
    @deck.pop
  end

  def pop_two_cards
    [pop_card, pop_card]
  end
end
