class RecursivePascalsTriangle
  def self.generate n
    (0..n-1).map do |i|
      (0..i).map do |j|
        value(i, j)
      end
    end
  end

  def self.value row, column
    return 1 if column < 1 || column == row

    value(row-1, column-1) + value(row-1, column)
  end
end

if $0 == __FILE__
  if ARGV.first
    $LOAD_PATH << '.'
    require 'trianglizer'
    triangle = RecursivePascalsTriangle.generate Integer(ARGV.first)

    puts Trianglizer.trianglify triangle

    exit 0
  end

  require 'minitest/autorun'

  describe RecursivePascalsTriangle do
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

      assert_equal expected, RecursivePascalsTriangle.generate(8)
    end
  end
end
