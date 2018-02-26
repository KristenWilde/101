flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.index { |name| name.match(/^Be/) }