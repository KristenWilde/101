class Board
  attr_accessor :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts <<BOARD
     |     |
  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}
     |     |
-----+-----+-----
     |     |
  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}
     |     |
-----+-----+-----
     |     |
  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}
     |     |
BOARD
  end
  # rubocop:enable Metrics/AbcSize

  def []=(num, mark)
    @squares[num].marker = mark
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
      markers = @squares.values_at(*line).map!(&:marker)
      if markers.count(markers.first) == 3
        return markers.first unless markers.first == Square::INITIAL_MARKER
      end
    end
    nil
    # return winning marker or nil
  end

  def winning_square(mark)
    square = nil
    WINNING_LINES.each do |line|
      # p @squares.values_at(*line).map!(&:marker).count(mark)
      next unless @squares.values_at(*line).map!(&:marker).count(mark) == 2
      line.each do |key|
        square = key if @squares[key].unmarked?
      end
    end
    square
  end  

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
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
end

class Player
  attr_reader :marker, :name
  attr_accessor :score
  def initialize
    @score = 0
  end
end

class Human < Player
  def move(board)
    puts "Choose a square (#{joinor(board.unmarked_keys)}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = marker
  end
  
  def joinor(array, separator=", ", final='or')
    new_string = array.pop.to_s
    if !array.empty?
      new_string.prepend array.join(separator) + " " + final + " "
    end
    new_string
  end
  
  def get_name
    name = ""
    loop do
      puts "Please enter your name."
      name = gets.chomp
      break unless name.empty? || name.match(/^ +$/)
    end
    @name = name
  end
  
  def get_marker
    mark = ""
    loop do 
      puts "Please enter one character to use as your marker."
      mark = gets.chomp
      break if mark.length == 1 && mark != " "
    end
    @marker = mark
  end
end

class Computer < Player
  def get_name
    name = ""
    loop do
      puts "Please enter a name for the computer."
      name = gets.chomp
      break name unless name.empty? || name.match(/^ +$/)
    end
    @name = name
  end

  def get_marker
    mark = ""
    loop do 
      puts "Please enter one character to use as #{name}'s marker."
      mark = gets.chomp
      break if mark.length == 1 && mark != " "
    end
    @marker = mark
  end


def choose_5(board)
  5 if board.unmarked_keys.include?(5)
end

def move(board, human_marker)
  square = board.winning_square(marker) || # offensive
           board.winning_square(human_marker) || # defensive
           choose_5(board) ||
           board.unmarked_keys.sample
  board[square] = self.marker
end

  
  # def move(board)
  #   board[board.unmarked_keys.sample] = marker
  # end
  
end

class TTTGame
  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @human_turn = true
  end

  def play
    clear
    display_welcome_message
    get_names_and_markers
    loop do
      clear_screen_and_display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn
      end
      display_result
      update_score
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer
  attr_accessor :human_turn

  def display_welcome_message
    puts
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system('clear') || system('cls')
  end

  def get_names_and_markers
    human.get_name
    human.get_marker
    computer.get_name
    computer.get_marker
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else puts "It's a tie!"
    end
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
    puts "Rounds won: #{human.name} #{human.score}, #{computer.name} #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again, #{human.name}? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y' # will be true or false as expected.
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    puts
    board.draw
    puts
  end

  def current_player_moves
    if human_turn
      human.move(@board)
    else
      computer.move(@board, human.marker)
    end
    @human_turn = !@human_turn
  end

  def reset
    board.reset
    clear
    @human_turn = true
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end
end
game = TTTGame.new
game.play
