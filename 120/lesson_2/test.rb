class Move
  VALID_CHOICES = {
    'r'  => 'rock',
    'p'  => 'paper',
    'sc' => 'scissors',
    'l'  => 'lizard',
    'sp' => 'spock'
  }.freeze

  WINNING_RULES = {
    'rock'      => %w(scissors lizard),
    'paper'     => %w(rock spock),
    'scissors'  => %w(paper lizard),
    'lizard'    => %w(paper spock),
    'spock'     => %w(rock scissors)
  }.freeze

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_RULES[value].include?(other_move.value)
  end

  def <(other_move)
    WINNING_RULES.each do |winner, loser_array|
      return true if loser_array.include?(value) &&
                     (winner == other_move.value)
    end
    false
  end

  def !=(other_move)
    value != other_move.to_s
  end

  def to_s
    value
  end

  protected

  attr_reader :value
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    input_name = ""
    loop do
      puts "what's your name?"
      input_name = gets.chomp.strip
      break unless input_name.empty?
      puts "Sorry, must enter a value."
      puts
    end
    self.name = input_name
  end

  def display_choices
    puts "Please choose from following choices:"
    Move::VALID_CHOICES.each do |short, full|
      puts "#{short.ljust(2)} for #{full}"
    end
  end

  def choose
    choice = nil
    loop do
      display_choices
      choice = gets.chomp.downcase
      break if Move::VALID_CHOICES[choice]
      puts "Sorry, invalid choice."
      puts
    end
    self.move = Move.new(Move::VALID_CHOICES[choice])
  end
end

class Computer < Player
  COMPUTER_PLAYERS = ['R2D2', 'Hal', 'Dumbo', 'Learner'].freeze

  #
  # Computer personalities
  #
  #   R2D2, Hal : Make moves as described in Bonus problem point 6
  #               R2D2 always chooses rock.
  #               Hal has high tendency to choose scissors, rarely rock,
  #               never paper.
  #
  #   Dumbo     : Chooses a move exactly twice in a row, cycles through
  #               all choices in the order rock, paper, scissors, lizard,
  #               spock, starting at rock at the beginning of a game.
  #
  #   Learner   : Adjusts choice based on history (as described in
  #               Bonus problem point 5)
  #

  PERSONALITY_WEIGHTS = {
    'R2D2' => { 'rock' => 100, 'paper' => 0, 'scissors' => 0 },
    'Hal'  => { 'rock' => 10,  'paper' => 0, 'scissors' => 90 }
  }.freeze

  #
  # outcome     : is from computer viewpoint (:lost or :won)
  #
  # comparison  : how to compare calculate percentage to outcome_pct
  #               (:lesser or :greater)
  #
  # action      : action to be performed if rule is determined to be
  #               applicable based on history analysis
  #               increment (:incr) or decrement (:decr)
  #

  LEARNER_RULES = [{ outcome: :lost, outcome_pct: 60, comparison: :greater,
                     computer_choice: 'rock', action: :decr,
                     weight_change_pct_points: 5 },
                   { outcome: :lost, outcome_pct: 50, comparison: :greater,
                     computer_choice: 'paper', action: :decr,
                     weight_change_pct_points: 20 }].freeze

  # rubocop:disable Style/ConditionalAssignment
  def initialize
    super

    if PERSONALITY_WEIGHTS[name].nil?
      self.weight = Weight.new
    else
      self.weight = Weight.new(PERSONALITY_WEIGHTS[name])
    end
  end
  # rubocop:enable Style/ConditionalAssignment

  def set_name
    self.name = COMPUTER_PLAYERS.sample
  end

  def choose(history)
    case name
    when 'Learner'  then learner_choose_move(history)
    when 'Dumbo'    then dumbo_choose_move(history)
    else
      self.move = Move.new(select_weighted_random)
    end
  end

  def learner_choose_move(history)
    analysis_result = history.analyze(LEARNER_RULES)
    weight.adjust(LEARNER_RULES, analysis_result)
    self.move = Move.new(select_weighted_random)
  end

  def select_weighted_random
    sum_of_all_weights = 100.0
    random_num = rand(sum_of_all_weights)
    weight.value.each do |move_str, move_weight|
      return move_str if random_num < move_weight
      random_num -= move_weight
    end
  end

  # rubocop:disable Metrics/AbcSize
  def dumbo_choose_move(history)
    moves_list = Move::VALID_CHOICES.values

    if history.value.empty?
      move_str = moves_list.first
    elsif history.value.size.odd?
      move_str = history.value.last[:computer].to_s
    elsif history.value.size.even?
      next_index = moves_list.index(history.value.last[:computer].to_s)
      next_index += 1
      next_index = 0 if next_index >= moves_list.size
      move_str = moves_list[next_index]
    end

    self.move = Move.new(move_str)
  end
  # rubocop:enable Metrics/AbcSize

  private

  attr_accessor :weight
end

class Weight
  attr_accessor :value

  def initialize(weight_hash=nil)
    @value = weight_hash
    return unless @value.nil?
    initialize_equal_weights
  end

  def display
    value.each do |choice, weight|
      puts "#{choice} = #{weight}"
    end
  end

  def adjust(rules, analysis_result)
    #
    # New weight is calculated based on a given rule's action (whether
    # increase or decrease). The amount of increase/descrease is
    # based on rule's :weight_change_pct_points value.
    #
    # After calculating new weight for a particular move, the remaining
    # weight is distributed equally among rest of the possible moves for
    # a total of 100 percentage points.
    #

    analysis_result.each_with_index do |rule_applicable, idx|
      next unless rule_applicable

      # Start with initial values of equal weight
      initialize

      choice = rules[idx][:computer_choice]
      new_weight = calculate_new_weight(rules, idx, choice)
      value[choice] = new_weight
      calculate_remaining_weight(choice, new_weight)
    end
  end

  private

  def initialize_equal_weights
    self.value = {}
    Move::VALID_CHOICES.values.each do |item|
      value[item] = 100.to_f / Move::VALID_CHOICES.size
    end
  end

  def calculate_new_weight(rules, idx, choice)
    curr_weight = value[choice]

    case rules[idx][:action]
    when :decr
      new_weight = curr_weight - rules[idx][:weight_change_pct_points]
      new_weight = 0 if new_weight < 0.0
    when :incr
      new_weight = curr_weight + rules[idx][:weight_change_pct_points]
      new_weight = 100 if new_weight > 100.0
    end

    new_weight
  end

  def calculate_remaining_weight(choice, new_weight)
    remaining_weight = 100.0 - new_weight
    remaining_items = value.size - 1

    value.each do |item_choice, _|
      next if item_choice == choice
      value[item_choice] = remaining_weight / remaining_items
    end
  end
end

class History
  attr_reader :value

  def initialize
    @value = []
  end

  def add(human_move, computer_move)
    value << { human: human_move, computer: computer_move }
  end

  def display
    puts "--------------------"
    puts "History of moves:"
    puts
    value.each do |item|
      puts "Human: #{item[:human].to_s.ljust(8)}; " \
           "computer: #{item[:computer]}"
    end
    puts "--------------------"
    puts
    puts
  end

  def analyze(rules)
    result = []

    rules.each do |rule|
      result << analyze_rule(rule)
    end

    result
  end

  private

  def analyze_rule(rule)
    choice_count, won_count = calc_choice_and_won_count(rule[:computer_choice])
    calculated_pct = calculate_won_pct(choice_count, won_count)
    if rule[:outcome] == :lost && choice_count.nonzero?
      calculated_pct = 100.0 - calculated_pct
    end
    compare_pct(rule[:comparison], calculated_pct, rule[:outcome_pct])
  end

  def calc_choice_and_won_count(computer_choice)
    choice_count = 0
    won_count = 0

    value.each do |hist_item|
      next unless hist_item[:computer].to_s == computer_choice

      choice_count += 1 if hist_item[:computer] != hist_item[:human]
      won_count += 1 if hist_item[:computer] > hist_item[:human]
    end

    [choice_count, won_count]
  end

  def calculate_won_pct(choice_count, won_count)
    won_pct = 0
    if choice_count.nonzero?
      won_pct = won_count.to_f * 100 / choice_count
    end
    won_pct
  end

  def compare_pct(comparison, calculated_pct, outcome_pct)
    if comparison == :greater
      calculated_pct >= outcome_pct
    else
      calculated_pct <= outcome_pct
    end
  end
end

class RPSGame
  attr_accessor :human, :computer

  WINNING_SCORE = 5

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
    @moves_history = History.new
  end

  def display_welcome_message
    welcome_message = Move::VALID_CHOICES.values.map(&:capitalize).join(', ')
    puts "Welcome to #{welcome_message}!"
    puts "Player winning #{WINNING_SCORE} plays wins the game."
    puts
  end

  def display_goodbye_message
    game_name = Move::VALID_CHOICES.values.map(&:capitalize).join(', ')
    puts "Thanks for playing #{game_name}. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  # rubocop:disable Metrics/AbcSize
  def display_winner_play
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    puts "\n\n"
  end
  # rubocop:enable Metrics/AbcSize

  def update_score
    if human.move > computer.move
      self.human_score = human_score + 1
    elsif human.move < computer.move
      self.computer_score = computer_score + 1
    end
  end

  def display_score
    puts "Score: #{human.name} = #{human_score}; " \
         "#{computer.name} = #{computer_score}"
  end

  def display_winner_game
    return if (human_score < WINNING_SCORE) &&
              (computer_score < WINNING_SCORE)

    if human_score == WINNING_SCORE
      puts "#{human.name} won the game!"
    elsif computer_score == WINNING_SCORE
      puts "#{computer.name} won the game!"
    end

    puts "\n\nResetting score."
    self.human_score = 0
    self.computer_score = 0
    display_score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include? answer
      puts "Sorry, must be y or n."
    end

    ['y', 'yes'].include? answer
  end

  # rubocop:disable Metrics/AbcSize
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose(@moves_history)
      display_moves
      display_winner_play
      update_score
      display_score
      display_winner_game
      @moves_history.add(human.move, computer.move)
      break unless play_again?
    end
    @moves_history.display
    display_goodbye_message
  end
  # rubocop:enable Metrics/AbcSize

  private

  attr_accessor :human_score, :computer_score
end

RPSGame.new.play