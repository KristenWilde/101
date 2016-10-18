# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

def prompt(msg)
  puts ">> " + msg
end

def initialize_deck(deck)
  ['Hearts', 'Diamonds', 'Clubs', 'Spades'].each do |suit|
    faces = ['Jack', 'Queen', 'King', 'Ace']
    until faces.empty?
      deck.push([suit, faces.pop])
    end
    (2..10).each do |num|
      deck.push([suit, num.to_s])
    end
  end
  deck.shuffle!
end

def display_cards(cards)
  phrases = cards.map { |card| card[1] + ' of ' + card[0] }
  phrases.join(", ")
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
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(total)
  total > 21
end

def stay?(total, opponent_total)
  total > opponent_total
end

def calculate_win(player_total, dealer_total)
  if player_total > 21
    'dealer'
  elsif dealer_total > 21
    'player'
  elsif dealer_total > player_total
    'dealer'
  elsif player_total > dealer_total
    'player'
  else
    'tie'
  end
end

def display_result(winner)
  case winner
  when 'player'
    prompt "Player won!!!"
  when 'dealer'
    prompt "Dealer won!!!"
  when 'tie'
    prompt "It was a tie!"
  else
    prompt "Neither of us won."
  end
end

# Game play:
system 'clear'
prompt "Let's play Twenty One!"
prompt "I'll deal first. Two cards for you, face up, and two for me (one
       face up, one face down. Your goal is to get as close to 21 as
       possible, without going over, by choosing to 'hit' (take another
       card) or 'stay'.  Numbers are worth their value. Jack, queen,
       and king are each worth 10. Ace is worth 11, unless your total cards
       are over 21 - then it's worth 1."
prompt 'Press enter to start!'
gets

deck = []
initialize_deck(deck)
player_total = 0
dealer_total = 0

system 'clear'
player_cards = deck.pop(2)
dealer_cards = deck.pop(2)
puts
prompt "Dealer cards: #{dealer_cards[0][1]} of #{dealer_cards[0][0]}, ?"
loop do
  prompt "Player cards: #{display_cards(player_cards)}"
  player_total = total(player_cards)
  prompt "Your total is: #{player_total}"
  puts
  break if busted?(player_total)
  prompt "Do you want to hit (h) or stay (s)?"
  answer = gets.chomp.downcase
  break if answer == 's'
  player_cards << deck.pop
end

if busted?(player_total)
  prompt "You busted! I win."
else
  prompt "You chose to stay!"
end

# Dealer turn
loop do
  dealer_total = total(dealer_cards)
  prompt "I have: #{display_cards(dealer_cards)}."
  prompt "My total: #{dealer_total}"
  prompt "Please press enter."
  gets
  if busted?(dealer_total)
    prompt "Busted."
    break
  elsif stay?(dealer_total, player_total)
    prompt "I choose to stay."
    break
  elsif dealer_total >= 17
    prompt "Dealer has to stay if total is over 17."
    break
  end
  dealer_cards << deck.pop
  prompt "I chose to hit."
end

# Compare and win
winner = calculate_win(player_total, dealer_total)
display_result(winner)
