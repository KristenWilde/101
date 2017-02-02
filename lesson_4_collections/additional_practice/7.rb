statement = "The Flintstones Rock"

hash = {}
statement.chars.sort.each { |char| hash[char] = statement.count(char) }

p hash

# There are a several ways the space characters could be removed.