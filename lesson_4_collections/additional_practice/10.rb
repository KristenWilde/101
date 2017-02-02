munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

#result = {}
munsters.each do |name, attributes|
  attributes["age_group"] = case attributes["age"]
                            when 0..17 then "kid"
                            when 18..64 then "adult"
                            when 65..Float::INFINITY then "senior"
                            end
  #result[name] = attributes
end

p munsters