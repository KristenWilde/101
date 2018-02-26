def uuid
  [string(8), string(4), string(4), string(4), string(12)].join("-")
end

def string(n)
  chars = ("a".."f").to_a + ("0".."9").to_a
  chars.sample(n).join("")
end

p uuid
p uuid
p uuid