require 'pry'

# stores and compares the values rock, paper, and scissors for each player
class Move
  VALUES = %w(rock paper scissors lizard spock).freeze
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def scissors?
    value == 'scissors'
  end

  def paper?
    value == 'paper'
  end

  def rock?
    value == 'rock'
  end

  def lizard?
    value == 'lizard'
  end
  
  def spock?
    value == 'spock'
  end

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?) ||
      (rock? && other.lizard?) ||
      (paper? && other.spock?) ||
      (scissors? && other.lizard?) ||
      (lizard? && other.paper?) ||
      (lizard? && other.spock?) ||
      (spock? && other.scissors?) ||
      (spock? && other.rock?)
  end

  def to_s
    value
  end
end


# human or computer
class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

# for the human player
class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "#{name}, choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

# for the computer player
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game orchestration engine:
class RPSGame
  WIN = 4
  GAME_NAME = "Rock Paper Scissors Lizard Spock"
  attr_accessor :human, :computer

  def initialize
    clear_screen
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    play
  end

  def play
    loop do
      puts
      human.choose
      computer.choose
      puts
      display_moves
      display_winner
      puts
      comment_on_points
      break unless play_again?
      clear_screen
      display_welcome_message
      display_score
    end
    display_goodbye_message
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to #{GAME_NAME}!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      human.score += 1
      puts "#{human.name} won!"
    elsif computer.move > human.move
      computer.score += 1
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name}: #{human.score}              " +
         "#{computer.name}: #{computer.score}"
  end

  def comment_on_points
    if (human.score < WIN) && (computer.score < WIN)
      puts "First one to #{WIN} points wins."
    elsif (human.score == WIN) && (computer.score < WIN)
      celebrate
      reset_scores
    elsif (human.score < WIN) && (computer.score == WIN)
      puts "#{computer.name} is the first player to #{WIN} points!!"
      reset_scores
    end
  end

  def celebrate
    puts "Please press Enter."
    gets
    clear_screen
    puts "Congratulations #{human.name}, you beat #{computer.name} at " +
         "#{GAME_NAME}!"
    puts <<'FISTBUMP'
          .--.___.----.___.--._
         /|  |   |    |   |  | `--.
        /                          `.
       |                             |
       |  `    |  `     |    ` |     |
       |    `  |      ` |      |   ` |
      '|  `    | ` ` `  |  ` ` |  `  |
      ||  `    |  `     | `    |  `  |
      ||    `  |   ` `  |    ` | `  `|
      || `     | `      | ` `  |  `  |
      ||  ___  |  ____  |  __  |  _  |
      | \_____/ \______/ \____/ \___/
      |         .--.\
      |        '     |
      `.      |  _.-'
        `.|__.-'  
FISTBUMP
    puts "Please press Enter."
    gets
    clear_screen
  end

  def reset_scores
    human.score = 0
    computer.score = 0
    puts "Scores have been reset to 0."
  end
  
  def play_again?
    loop do
      puts 'Play again? (y/n)'
      answer = gets.chomp.downcase
      break true if answer == 'y'
      break false if answer == 'n'
      puts 'Sorry, must be y or n.'
    end
  end

  def display_goodbye_message
    puts "Thanks for playing #{GAME_NAME}!"
  end
end

RPSGame.new
