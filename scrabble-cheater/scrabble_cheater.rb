input_chars = if ARGV.empty?
  7.times.map { ('a'..'z').to_a.sample }
else
  ARGV.first.each_char.to_a
end

words = File.readlines("/usr/share/dict/words").
  map(&:chomp).
  map(&:downcase)

map = Hash.new {|h,k| h[k] = [] }

words.each do |word|
  canonical = word.each_char.sort.join
  map[canonical] << word
end

subsets = (2..input_chars.size).
  flat_map {|i| input_chars.combination(i).to_a.map(&:sort).map(&:join) }

matching_words = subsets.flat_map {|subset| map[subset] }.uniq

p input_chars
p matching_words
