# Plays tic tac toe

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> " + msg
end

def joinor(array, separator=", ", final='or')
  new_string = ""
  if array.length == 2
    new_string = array[0].to_s + " " + final + " " + array[1].to_s
  elsif array.length > 2
    array.each_with_index do |item, index|
      new_string << item.to_s + separator
      break if index == array.length - 2
    end
    new_string << final + " " + array.last.to_s
  else # only one item 
    array[0].to_s
  end
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
  if cur_player == "player" then player_places_piece!(brd)
  else computer_places_piece!(brd)
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

def computer_places_piece!(brd)
  square = nil
  
  # offense
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 
       line.each { |key| brd[key] == INITIAL_MARKER ? square = key : nil } 
    end
  end
  
  # defense 
  if !square
    WINNING_LINES.each do |line|
      if brd.values_at(*line).count(PLAYER_MARKER) == 2 
         line.each { |key| brd[key] == INITIAL_MARKER ? square = key : nil } 
      end
    end
  end
  
  # choose square 5 if available, otherwise random.
  if !square
    if brd[5] == INITIAL_MARKER then square = 5 
    else square = empty_squares(brd).sample
    end
  end
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

loop do # play again loop
  board = initalize_board
  current_player = "player"

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
  if player_score == 5 || comp_score == 5
    puts ""
    puts " ~ ~ ~  First to 5, #{winner} won !!!  ~ ~ ~"
    puts ""
    comp_score = 0
    player_score = 0
    prompt "Both our scores are back to 0."
  elsif player_score < 5 && comp_score < 5
    prompt "First player to 5 is the winner!"
  end
  prompt "Keep playing?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts "Thanks for playing Tic Tac Toe! Goodbye!"
