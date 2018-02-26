class PingGame
  def play
    number = rand(1..100)
    guesses_remaining = 7

    until guesses_remaining == 0
      puts "\nYou have #{guesses_remaining} guesses remaining."
      print "Enter a number between 1 and 100: "
      guess = gets.to_i

      case guess
      when number 
        puts "You win!"
        return
      when (1..number) 
        puts "Your guess is too low."
      when (number..100)
        puts "Your guess is too high."
      else 
        puts "Invalid guess"
      end
      guesses_remaining -= 1
    end
    
    puts "You are out of guesses. You lose."
  end
end

game = PingGame.new
game.play

game.play
