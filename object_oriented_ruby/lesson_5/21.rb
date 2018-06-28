class Participant
  attr_accessor :cards

  def initialize
    @cards = []
    @total = 0
  end

  def show_hand
    print_cards
    puts "Total: #{total} #{busted_msg}"
  end

  def print_cards
    cards_lines = []
    cards[0].card_lines.length.times do |line_idx|
      single_line = []
      cards.length.times do |card_idx|
        single_line << "   #{cards[card_idx].card_lines[line_idx]}"
      end
      cards_lines << single_line.join
    end
    puts cards_lines
  end

  def busted?
    return false if total == '?' || total <= 21
    true
  end

  def busted_msg
    busted? ? "BUSTED" : ""
  end

  def total
    values = cards.map(&:value)
    points = 0
    values.each do |value|
      points += if value == 'A '
                  11
                elsif value.to_i.zero?
                  10
                else
                  value.to_i
                end
    end
    values.select { |value| value == 'A ' }.count.times do
      points -= 10 if points >= Game21::GOAL
    end
    @total = cards.any?(&:hidden) ? '?' : points
  end
end

class Deck
  attr_reader :cards

  SUITS = ['♥', '♦', '♣', '♠'].freeze
  VALUES = ['2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 ', '9 ', '10',
            'J ', 'Q ', 'K ', 'A '].freeze

  def initialize
    shuffled_data = SUITS.product(VALUES).shuffle
    @cards = shuffled_data.map do |suit, value|
      Card.new(suit, value)
    end
  end
end

class Card
  attr_reader :suit, :value
  attr_accessor :hidden

  def initialize(suit, value)
    @value = value
    @suit = suit
    @hidden = false
  end

  def card_lines
    if hidden
      [".-------.", "|       |", "|       |",
       "|   ?   |", "|       |", "|       |", "'-------'"]
    else
      [".-------.",
       "|#{suit}      |",
       "|       |",
       "|   #{value}  |",
       "|       |",
       "|      #{suit}|",
       "'-------'"]
    end
  end

  def to_s
    card_lines.join("\n")
  end
end

class Game21
  attr_reader :deck, :player, :dealer
  GOAL = 21
  DEALER_STAY_VAL = 17

  def initialize
    @deck = Deck.new
    @player = Participant.new
    @dealer = Participant.new
  end

  def start
    welcome
    loop do
      deal_cards
      display_game
      player_turn
      dealer_turn
      show_result
      break unless play_again?
      reset
    end
    puts "Thank you for playing 21!"
  end

  def welcome
    clear_screen
    puts "Let's play Twenty One!"
    puts "\nYour goal is to get as close to #{GOAL} as possible, without going"
    puts "over, by choosing to 'hit' (take another card) or 'stay'."
    puts "\nNumbers are worth their value. Jack, queen, and king are 10 points."
    puts "Ace is 11, unless your total cards are over #{GOAL} - then it's 1."
    puts "\nAfter you stay or bust (go over #{GOAL}), my turn. I'll also try"
    puts " to get as close as possible to #{GOAL}. If neither of us busts, the"
    puts "higher total wins."
    puts "\nPress enter to start!"
    gets
  end

  def deal_cards
    2.times do
      dealer.cards << deck.cards.pop
      player.cards << deck.cards.pop
    end
    dealer.cards[1].hidden = true
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_game
    clear_screen
    puts "----------------------------------------------------\nDealer has:"
    dealer.show_hand
    puts "----------------------------------------------------\nPlayer has:"
    player.show_hand
    puts "----------------------------------------------------\n"
  end

  def player_turn
    loop do
      break unless hit?
      player.cards << deck.cards.pop
      display_game
      puts "Player chose to hit\n"
      break if player.busted?
    end
  end

  def hit?
    puts "Player, would you like to (h)it or (s)tay?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer == 'h' || answer == 's'
      puts "Please enter 'h' or 's'."
    end
    answer == 'h' # returns true or false.
  end

  def dealer_turn
    dealer.cards[1].hidden = false
    display_game
    puts "Dealer's turn. Please press enter."
    gets
    dealer_play_loop unless player.busted?
  end

  def dealer_play_loop
    loop do
      break unless dealer.total < DEALER_STAY_VAL
      dealer.cards << deck.cards.pop
      display_game
      puts "Dealer chose to hit. Please press enter."
      gets
    end
  end

  def result
    if player.busted?
      "Player busted! Dealer wins!"
    elsif dealer.busted?
      "Dealer busted! Player wins!"
    elsif dealer.total > player.total
      "Dealer wins!"
    elsif player.total > dealer.total
      "Dealer chose to stay. Player wins!"
    else
      "It's a tie!"
    end
  end

  def show_result
    puts result
  end

  def play_again?
    puts "Would you like to play again? y/n"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please enter y or n."
    end
    answer == 'y'
  end

  def reset
    @deck = Deck.new
    player.cards = []
    dealer.cards = []
  end
end

Game21.new.start
