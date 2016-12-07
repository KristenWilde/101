require 'pry'

class Move
  def to_s
    self.class.to_s
  end
end

class Rock < Move
  def >(other)
    other.class == Scissors || other.class == Lizard
  end
end

class Paper < Move
  def >(other)
    other.class == Rock || other.class == Spock
  end
end

class Scissors < Move
  def >(other)
    other.class == Paper || other.class == Lizard
  end
end

class Lizard < Move
  def >(other)
    other.class == Paper || other.class == Spock
  end
end

class Spock < Move
  def >(other)
    other.class == Scissors || other.class == Rock
  end
end

# human or computer
class Player
  attr_accessor :move, :name, :score
  MOVES = {r: Rock.new, p: Paper.new, s: Scissors.new, l: Lizard.new, sp: Spock.new}

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

  def choose_move
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock:" 
      choice = gets.chomp.downcase.to_sym
      break if MOVES.keys.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = MOVES[choice]
  end
end

# for the computer player
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose_move
    self.move = MOVES[[:r, :p, :s, :l, :sp].sample]
  end
end

# Game orchestration engine:
class RPSGame
  WIN = 4
  GAME_NAME = "Rock Paper Scissors Lizard Spock"
  attr_accessor :human, :computer

  def initialize
  end

  def play
    clear_screen
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    loop do
      puts
      human.choose_move
      computer.choose_move
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

RPSGame.new.play
