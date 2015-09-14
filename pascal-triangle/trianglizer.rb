class Trianglizer
  def self.trianglify triangle
    gap = triangle.flatten.map(&:to_s).max_by {|s| s.size }.size
    length = triangle.size * gap * 2

    triangle.map {|row| row.join(" " * gap).center(length) }.join("\n")
  end
end

if $0 == __FILE__
  require 'minitest/autorun'

  describe Triangulizer do
    it "does the thing" do
      input = [
        [1],
        [1, 1],
        [1, 2,  1],
        [1, 3,  3,  1],
        [1, 4,  6,  4,  1],
        [1, 5,  10, 10, 5,  1],
      ]

      expected = <<-TRIANGLE.strip
           1
          1  1
        1  2  1
       1  3  3  1
     1  4  6  4  1
   1  5  10  10  5  1
      TRIANGLE

      assert_equal expected, IterativePascalsTriangle.generate(8)
    end
  end
end
