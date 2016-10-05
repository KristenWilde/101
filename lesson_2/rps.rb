# rock paper scissors game

VALID_CHOICES = { r: 'rock', p: 'paper', s: 'scissors', l: 'lizard',
                  sp: 'spock' }

WINNERS = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissors)
}

def win?(first, second)
  WINNERS[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won!')
  else
    prompt("It's a tie!")
  end
end

def win_message(player_score, computer_score)
  if player_score >= 5
    if player_score > computer_score then "You are the master!"
    else "You're not giving up, are you?"
    end
  elsif computer_score >= 5 && computer_score > player_score
    "I am the master!"
  else
    "First one to 5 is the master."
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

player_score = 0
computer_score = 0
choice = ''

loop do
  loop do
    prompt("Choose one: #{VALID_CHOICES.values.join(', ')}.")
    prompt("You may type just the first letter of your choice (sp for spock).")
    answer = Kernel.gets().chomp().downcase

    if VALID_CHOICES.value?(answer)
      choice = answer
      break
    elsif VALID_CHOICES.key?(answer.to_sym)
      choice = VALID_CHOICES[answer.to_sym]
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.values.sample

  prompt("You chose #{choice}, computer chose #{computer_choice}.")

  display_result(choice, computer_choice)

  if win?(choice, computer_choice)
    player_score += 1
  elsif win?(computer_choice, choice)
    computer_score += 1
  end
  prompt("Your score: #{player_score}, Computer: #{computer_score}.")

  prompt(win_message(player_score, computer_score))

  prompt('Do you want to keep playing?')
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing!')
