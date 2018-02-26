module Displayable
  def display_welcome_message
    puts "Welcome to Tic Tac Toe, #{human.name}!"
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "#{human.name}'s marker is #{human.marker}. #{computer.name}'s " \
    "marker is #{computer.marker}."
    board.draw
    puts ""
  end

  def display_board_and_clear_screen
    clear_screen
    display_board
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_game_winner
    if win_history[human.marker] >= TTTGame::GAMES_NEEDED_TO_WIN
      puts "#{human.name} won the game!"
    elsif win_history[computer.marker] >= TTTGame::GAMES_NEEDED_TO_WIN
      puts "#{computer.name} won the game!"
    end
  end

  def display_history
    puts "#{human.name} has won #{win_history[human.marker]} rounds."
    puts "#{computer.name} has won #{win_history[computer.marker]} " \
    "rounds"
  end

  def display_round_winner
    case board.winning_marker
    when human.marker
      puts "#{human.name} won that round!"
    when computer.marker
      puts "#{computer.name} won that round!"
    else
      puts "It's a tie!"
    end
  end
end

class Board
  attr_accessor :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  MIDDLE_SQUARE = 5

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Human
  attr_accessor :name, :marker, :board

  def initialize(board)
    @name = set_name
    @marker = set_marker
    @board = board
  end

  def set_name
    name = nil
    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.strip.empty?
      puts "Sorry, that's not a valid name."
    end

    name
  end

  def set_marker
    marker = nil
    loop do
      puts "What letter, number, or symbol would you like to use " \
      "as your marker?"
      marker = gets.chomp
      break unless marker.strip.empty? || marker.length > 1
      puts "Sorry, marker can only be one character. Spaces aren't allowed."
    end

    marker
  end

  def move
    puts "Choose a square (#{joinor(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = marker
  end

  def joinor(array, delimiter = ', ', conjunction = 'or')
    case array.size
    when 0 then ''
    when 1 then array[0]
    when 2 then array.join(" #{conjunction} ")
    else
      array[0..-2].join(delimiter).to_s + delimiter + conjunction + " " +
        array[-1].to_s
    end
  end
end

class Computer
  attr_accessor :name, :marker, :board

  def initialize(board)
    @marker = "O"
    @name = %w(Watson Siri Cortana Alexa).sample
    @board = board
  end

  def move
    square = offensive_move || defensive_move || random_move
    board[square] = marker
  end

  def offensive_move
    Board::WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      if computer_two_in_a_row?(squares)
        empty_square = squares.index { |square| square.marker == " " }
        return line[empty_square]
      end
    end
    nil
  end

  def defensive_move
    Board::WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      if human_two_in_a_row?(squares)
        empty_square = squares.index { |square| square.marker == " " }
        return line[empty_square]
      end
    end
    nil
  end

  def random_move
    if board.squares[Board::MIDDLE_SQUARE].unmarked?
      return Board::MIDDLE_SQUARE
    else
      return board.unmarked_keys.sample
    end
  end

  def human_two_in_a_row?(squares)
    unmarked_squares = squares.count { |square| square.marker == " " }
    marked_squares = squares.count do |square|
      square.marker != marker && square.marker != " "
    end
    marked_squares == 2 && unmarked_squares == 1
  end

  def computer_two_in_a_row?(squares)
    unmarked_squares = squares.count { |square| square.marker == " " }
    marked_squares = squares.count { |square| square.marker == marker }
    marked_squares == 2 && unmarked_squares == 1
  end
end

class TTTGame
  include Displayable
  INITIAL_MARKER = " ".freeze
  GAMES_NEEDED_TO_WIN = 5

  attr_reader :board, :human, :computer
  attr_accessor :current_player, :win_history

  def initialize
    @board = Board.new
    @human = Human.new(@board)
    @computer = Computer.new(@board)
    @current_marker = INITIAL_MARKER
    reset_history
  end

  def play
    display_welcome_message
    loop do
      loop do
        reset_game_and_display_board
        take_turns_making_moves
        clear_screen
        update_history
        display_round_winner_and_history
        break if game_over?
      end
      display_game_winner
      break unless play_again?
      reset_history
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def reset_game_and_display_board
    reset_game
    display_board
  end

  def take_turns_making_moves
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      display_board_and_clear_screen if human_turn?
    end
  end

  def display_round_winner_and_history
    display_round_winner
    display_history
  end

  def update_history
    win_history[board.winning_marker] += 1 if board.someone_won?
  end

  def reset_history
    @win_history = { human.marker => 0, computer.marker => 0 }
  end

  def game_over?
    win_history[human.marker] == GAMES_NEEDED_TO_WIN || win_history[computer.marker] == GAMES_NEEDED_TO_WIN
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y or n)"
      answer = gets.chomp.downcase
      break if %(y n).include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def reset_game
    board.reset
    @current_marker = human.marker
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human.move
      @current_marker = computer.marker
    else
      computer.move
      @current_marker = human.marker
    end
  end
end

game = TTTGame.new
game.play