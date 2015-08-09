# Download from:
# https://raw.githubusercontent.com/jonbcard/scrabble-bot/master/src/dictionary.txt
DICT = 'dictionary.txt'
#DICT= '/usr/share/dict/words'

input_chars = if ARGV.empty?
  7.times.map { ('a'..'z').to_a.sample }
else
  ARGV.first.each_char.to_a
end

map = File.readlines(DICT).
  map(&:chomp).
  map(&:downcase).
  group_by {|word| word.each_char.sort.join }

subsets = (1..input_chars.size).to_a.
  flat_map { |n| input_chars.combination(n).to_a }.
  map(&:sort).
  map(&:join).
  uniq

matching_words = subsets.flat_map {|subset| map[subset] }.compact

puts "Using input characters: #{input_chars.join(", ")}"
puts

if matching_words.any?
  puts "Found matching words:"
  puts matching_words.join("\n")
else
  puts "No matching words. :("
end
