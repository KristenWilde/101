def none?(collection) #block
  collection.each do |item|
    return false if yield(item)
  end
  true
end