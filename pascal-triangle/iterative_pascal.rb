class IterativePascalsTriangle
  def self.generate n
    triangle = [[1]]

    (1...n).each do |i|
      row = [1]
      previous = triangle.last

      (1...i).each do |j|
        left, right = previous.values_at(j-1, j)

        row.push(left + right)
      end

      row.push 1
      triangle.push row
    end

    triangle
  end
end

if $0 == __FILE__
  if ARGV.first
    $LOAD_PATH << '.'
    require 'trianglizer'
    triangle = IterativePascalsTriangle.generate Integer(ARGV.first)

    puts Trianglizer.trianglify triangle

    exit 0
  end

  require 'minitest/autorun'

  describe IterativePascalsTriangle do
    it "does the thing" do
      expected = [
        [1],
        [1, 1],
        [1, 2,  1],
        [1, 3,  3,  1],
        [1, 4,  6,  4,  1],
        [1, 5,  10, 10, 5,  1],
        [1, 6,  15, 20, 15, 6,  1],
        [1, 7,  21, 35, 35, 21, 7,  1],
      ]

      assert_equal expected, IterativePascalsTriangle.generate(8)
    end
  end
end
