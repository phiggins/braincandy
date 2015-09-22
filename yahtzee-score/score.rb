scores = [
  ["Ones", ->(xs) { xs.count { |x| x == 1 } } ],
  ["Twos", ->(xs) { xs.count { |x| x == 2 } * 2 } ],
  ["Threes", ->(xs) { xs.count { |x| x == 3 } * 3 } ],
  ["Fours", ->(xs) { xs.count { |x| x == 4 } * 4 } ],
  ["Fives", ->(xs) { xs.count { |x| x == 5 } * 5 } ],
  ["Sixes", ->(xs) { xs.count { |x| x == 6 } * 6 } ],
  ["3-of-a-kind", ->(xs) { xs.any? {|x| xs.count(x) >= 3 } }, ->(xs) { xs.inject(:+) } ],
  ["4-of-a-kind", ->(xs) { xs.any? {|x| xs.count(x) >= 4 } }, ->(xs) { xs.inject(:+) } ],
  ["Full House", ->(xs) { xs.group_by(&:itself).map {|_,x| x.count }.sort == [2,3] }, proc { 25 } ],
  ["Small Straight", ->(xs) { xs.sort.each_cons(2).count {|x,y| x+1 == y } >= 3 }, proc { 30 } ],
  ["Large Straight", ->(xs) { xs.sort.each_cons(2).count {|x,y| x+1 == y } >= 4 }, proc { 40 } ],
  ["Yahtzee", ->(xs) { xs.detect {|x| xs.count(x) == 5 } }, proc { 50 } ],
  ["Chance", ->(xs) { xs.inject(:+) } ],
]

roll = Array.new(5) { rand(1..6) }

puts "Roll: #{roll.sort.join(", ")}"

name, score = scores.map {|x,y,z| [x, y, z || proc {false} ] }.
  map {|x,y,z| [x, (y.call(roll) && z.call(roll)) || y.call(roll) || 0] }.
  max_by(&:last)

puts "\"#{name}\": #{score}"
