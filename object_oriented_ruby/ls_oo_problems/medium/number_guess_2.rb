class Guesser
  def initialize(low, high)
    @low = low
    @high = high
    @number_of_guesses = Math.log2(high - low).to_i + 1
  end

  def play
    secret_num = rand(@low..@high)
    guesses_remaining = @number_of_guesses

    until guesses_remaining == 0
      start_round(guesses_remaining)
      guess = gets.to_i

      case guess
      when secret_num then return win
      when (@low..secret_num) then puts "Your guess is too low."
      when (secret_num..@high) then puts "Your guess is too high."
      else puts "Invalid guess"
      end
      
      guesses_remaining -= 1
    end
    puts "You are out of guesses. You lose."
  end
  
  def start_round(guesses_remaining)
    puts ""
    if guesses_remaining == 1  then puts "You have 1 guess remaining."
    else puts "You have #{guesses_remaining} guesses remaining."
    end
    print "Enter a number between #{@low} and #{@high}: "
  end
  
  def win
    puts "You won!!"
  end
end

game = Guesser.new(1, 1000)
game.play
