require 'pry'

class Participant
  attr_accessor :cards
  attr_reader :total
  
  def initialize
    @cards = [] 
    @total = 0
  end

  def show_cards
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
  
  def hit
    
  end
  
  def stay
    
  end
  
  def busted?
    if total == '?' then false
    elsif total <= 21 then false
    else true      
    end
  end
  
  def busted_msg
    if busted? then "BUSTED"
    else ""
    end
  end
  
  def total
    if cards.any? { |card| card.hidden } then @total = '?'
    else 
      points = 0
      values = cards.map { |card| card.value }
      
      values.each do |value|
        if value == 'A '
          points += 11
        elsif value.to_i.zero?
          points += 10
        else
          points += value.to_i
        end
      end
  
      values.select { |value| value == 'A ' }.count.times do
        points -= 10 if points >= Game21::GOAL
      end
      @total = points
    end
  end

end

class Player < Participant


end

class Dealer < Participant

  STAY_VAL = 17
end

class Deck
  attr_reader :cards
  
  SUITS = ['♥', '♦', '♣', '♠'].freeze
  VALUES = ['2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 ', '9 ', '10',
          'J ', 'Q ', 'K ', 'A '].freeze
  
  def initialize
    shuffled_data = SUITS.product(VALUES).shuffle
    @cards = shuffled_data.map do |(suit, value)|
      Card.new(suit, value)
    end
  end
  
  def to_s
    @cards.each {|card| card.to_s }
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
      [".-------.", 
       "|       |", 
       "|   ?   |", 
       "|       |",
       "|   ?   |", 
       "|       |", 
       "'-------'"]
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
  
  def initialize
    @deck = Deck.new
    @player = Participant.new
    @dealer = Participant.new
  end

  
  def start
    # show_instructions
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
    puts "----------------------------------------------------"
    puts "Dealer has:"
    dealer.show_cards
    puts "Dealer total: #{dealer.total} #{dealer.busted_msg}"
    puts "----------------------------------------------------"
    puts "Player has:"
    player.show_cards
    puts "Player total: #{player.total} #{player.busted_msg}"
    puts "----------------------------------------------------"
    puts
  end
  

  
  def player_turn
    loop do
      puts "Player, would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if answer == 'h' || answer == 's'
        puts "Please enter 'h' or 's'."
      end
      break if answer == 's' # otherwise answer was 'h' so continue.
      player.cards << deck.cards.pop
      display_game
      puts "Player chose to hit.\n"
      break if player.busted?
    end
  end
 
  def dealer_turn
    dealer.cards[1].hidden = false
    display_game
    puts "Press enter for dealer's turn."
    gets
    unless player.busted?
      loop do 
        if dealer.total < Dealer::STAY_VAL # dealer hits
          dealer.cards << deck.cards.pop
          display_game
          puts "Dealer chose to hit. Please press enter."
          gets
        elsif !dealer.busted?
          puts "Dealer stays. Please press enter."
          gets
          break
        else break
        end
      end
    end 
  end 
  
  def show_result
    if player.busted? 
      puts "Player busted! Dealer wins!"
    elsif dealer.busted?
      puts "Dealer busted! Player wins!"
    elsif dealer.total > player.total
      puts "Dealer wins!"
    elsif player.total > dealer.total
      puts "Player wins!"
    else puts "It's a tie!"
    end
  end
  
  def play_again?
    puts "Would you like to play again? y/n"
    answer = nil
    loop do 
      answer = gets.chomp.downcase
      break if %w(y n).include?answer
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


playing = Game21.new
playing.start
