# Plays tic tac toe

require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
FIRST_PLAYER = 'choose'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals
WIN_SCORE = 5

def prompt(msg)
  puts "=> " + msg
end

def joinor(array, separator=", ", final='or')
  new_string = array.pop.to_s
  if !array.empty?
    new_string.prepend array.join(separator) + " " + final + " "
  end
  new_string
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}, Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initalize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
  # returns an array of the empty squares
end

def place_piece!(brd, cur_player)
  if cur_player == "player"
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def complete_a_line(brd, marker)
  square = nil
  WINNING_LINES.each do |line|
    next unless brd.values_at(*line).count(marker) == 2
    line.each { |key| break square = key if brd[key] == INITIAL_MARKER }
  end
  square
end

def choose_5(brd)
  5 if brd[5] == INITIAL_MARKER
end

def computer_places_piece!(brd)
  square = complete_a_line(brd, COMPUTER_MARKER) || # offensive
           complete_a_line(brd, PLAYER_MARKER) || # defensive
           choose_5(brd) ||
           empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'You'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def alternate_player(current_player)
  current_player == "player" ? "computer" : "player"
end

player_score = 0
comp_score = 0
current_player = ''

loop do
  board = initalize_board
  system 'clear'
  prompt "Let's play Tic Tac Toe!"

  case FIRST_PLAYER
  when 'choose'
    prompt "Who should go first? (P for player--you-- or C for computer)"
    loop do
      answer = gets.chomp.downcase
      if answer.start_with? "p"
        current_player = "player"
        break
      elsif answer.start_with? 'c'
        current_player = "computer"
        break
      else
        prompt "Please enter p or c."
      end
    end
    prompt "#{current_player.capitalize} will go first. Press enter to start!"
    gets
  when 'player' then current_player = 'player'
  when 'computer' then current_player = 'computer'
  end

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    prompt "#{winner} won!"
    winner == 'You' ? player_score += 1 : comp_score += 1
  else
    prompt "It's a tie!"
  end

  prompt "That makes #{player_score} wins for you, and #{comp_score} for me."
  if player_score == WIN_SCORE || comp_score == WIN_SCORE
    puts ""
    puts " ~ ~ ~  First to #{WIN_SCORE}, #{winner} won !!!  ~ ~ ~"
    puts ""
    comp_score = 0
    player_score = 0
    prompt "Both our scores are back to 0."
  elsif player_score < WIN_SCORE && comp_score < WIN_SCORE
    prompt "First player to #{WIN_SCORE} is the winner!"
  end
  prompt "Keep playing? (y to continue, any other character to quit)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts "Thanks for playing Tic Tac Toe! Goodbye!"
