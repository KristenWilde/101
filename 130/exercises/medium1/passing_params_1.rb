food = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items, message) 
  puts message
  yield(items)
  puts message
end

gather(food, "Let's start gathering food.") do |items|
  puts "#{items.join(', ')}"
end