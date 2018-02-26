flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

new_hash = {}

flintstones.each_with_index.with_object({}) do |name, index|
  new_hash[index] = name
end

p new_hash
