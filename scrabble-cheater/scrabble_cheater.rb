# Download from:
# https://raw.githubusercontent.com/jonbcard/scrabble-bot/master/src/dictionary.txt
DICT = 'dictionary.txt'
#DICT= '/usr/share/dict/words'

input_chars = if ARGV.empty?
  7.times.map { ('a'..'z').to_a.sample }
else
  ARGV.first.each_char.to_a
end

words = File.read(DICT).downcase.split("\n")

permutations = (1..input_chars.size).to_a.
  flat_map { |n| input_chars.permutation(n).to_a.map(&:join) }

matching_words = words & permutations

puts "Using input characters: #{input_chars.join(", ")}"
puts

if matching_words.any?
  puts "Found matching words:"
  puts matching_words.join("\n")
else
  puts "No matching words. :("
end
