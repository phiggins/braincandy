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

subsets = (2..input_chars.size).
  flat_map {|i| input_chars.combination(i).to_a.map(&:sort).map(&:join) }

matching_words = subsets.flat_map {|subset| map[subset] }.compact.uniq

p input_chars
p matching_words