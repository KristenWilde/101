# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
          'Jack', 'Queen', 'King', 'Ace'].freeze
GOAL = 21
DEALER_STAY_VAL = 17
PLAY_TO = 5

def prompt(msg)
  puts ">> " + msg
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def display_cards(cards)
  phrases = cards.map { |card| card[1] + ' of ' + card[0] }
  phrases.join(", ").rjust(56)
end

def display_dealer_card(cards)
  phrase = '  ?  , ' + cards[1][1] + ' of ' + cards[1][0]
  phrase.rjust(56)
end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'Ace'
      sum += 11
    elsif value.to_i.zero?
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == 'Ace' }.count.times do
    sum -= 10 if sum > GOAL
  end

  sum
end

def busted?(total)
  total > GOAL
end

def stay?(total, opponent_total)
  total > opponent_total || total >= DEALER_STAY_VAL
end

def compare(player_cards, player_total, dealer_cards, dealer_total)
  puts "  =============="
  prompt "Dealer has #{display_cards(dealer_cards)}, totalling #{dealer_total}"
  prompt "Player has #{display_cards(player_cards)}, totalling #{player_total}"
  puts "  =============="
end

def calculate_win(player_total, dealer_total)
  if player_total > GOAL
    :dealer
  elsif dealer_total > GOAL
    :player
  elsif dealer_total > player_total
    :dealer
  elsif player_total > dealer_total
    :player
  else
    :tie
  end
end

def display_result(winner, player_wins, dealer_wins)
  case winner
  when :player
    prompt "Player won!"
  when :dealer
    prompt "Dealer won!"
  when :tie
    prompt "It's a tie!"
  end
  prompt "I've won #{dealer_wins} rounds so far, you've won #{player_wins}."
end

def play_again?
  loop do
    prompt "Keep playing? (y or n)"
    answer = gets.chomp
    break true if answer.downcase.start_with?('y')
    break false if answer.downcase.start_with?('n')
    prompt "Please answer y or n"
  end
end

# Game play:
system 'clear'
prompt "Let's play #{GOAL}!"
puts
prompt "I'll deal. Two cards for you, face up, and two for me (one
   face up, one face down. Your goal is to get as close to #{GOAL} as
   possible, without going over, by choosing to 'hit' (take another
   card) or 'stay'.
   Numbers are worth their value. Jack, queen, and king are each worth 10.
   Ace is worth 11, unless your total cards are over #{GOAL} - then it's
   worth 1.
   After you stay, it's the dealer's turn. I'll also try to get as close
   as possible to #{GOAL}. If neither of us busts, the higher total wins.
   Whoever wins #{PLAY_TO} rounds first is the champion!"
puts
prompt 'Press enter to start!'
gets

player_wins = 0
dealer_wins = 0

loop do
  deck = initialize_deck
  player_total = 0
  dealer_total = 0

  system 'clear'
  player_cards = deck.pop(2)
  dealer_cards = deck.pop(2)
  prompt "Dealer cards: #{display_dealer_card(dealer_cards)}"
  loop do
    prompt "Player cards: #{display_cards(player_cards)}"
    player_total = total(player_cards)
    prompt "Your total is: #{player_total}"
    break if busted?(player_total)
    prompt "Do you want to hit (h) or stay (s)?"
    answer = gets.chomp.downcase
    break if answer == 's'
    player_cards << deck.pop
  end

  if busted?(player_total)
    dealer_total = total(dealer_cards)
    compare(player_cards, player_total, dealer_cards, dealer_total)
    winner = :dealer
    dealer_wins += 1
    display_result(winner, player_wins, dealer_wins)
    dealer_wins += 1
    play_again? ? next : break
  else
    prompt "You chose to stay!"
  end

  # Dealer turn
  loop do
    dealer_total = total(dealer_cards)
    prompt "Dealer cards: #{display_cards(dealer_cards)}."
    prompt "Dealer total: total: #{dealer_total}"
    prompt "Please press enter."
    gets
    if busted?(dealer_total)
      break
    elsif stay?(dealer_total, player_total)
      prompt "Dealer stays."
      break
    end
    dealer_cards << deck.pop
    prompt "Dealer hits."
  end

  # Compare and win
  compare(player_cards, player_total, dealer_cards, dealer_total)
  winner = calculate_win(player_total, dealer_total)
  if winner == :dealer
    dealer_wins += 1
  elsif winner == :player
    player_wins += 1
  end
  display_result(winner, player_wins, dealer_wins)
  if dealer_wins == PLAY_TO
    prompt "Dealer has won #{PLAY_TO} rounds! I am the champion."
    break
  elsif player_wins == PLAY_TO
    prompt "Player has won #{PLAY_TO} rounds! You are the champion."
    break
  end
  break unless play_again?
end

prompt "Thanks for playing #{GOAL}!!!"
