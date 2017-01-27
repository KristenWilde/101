def one?(collection) #block
  found_one = false
  collection.each do |item|
    if yield(item) && !found_one
      found_one = true
      next
    elsif yield(item) then return false
    end
  end
  found_one 
end

