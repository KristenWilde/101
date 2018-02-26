def spot(array) 
  puts "I saw " + yield(array).to_s
end

birds = %w(raven finch hawk eagle)

spot(birds){ |_, _, *birds_of_prey| birds_of_prey.join(" and ") }
