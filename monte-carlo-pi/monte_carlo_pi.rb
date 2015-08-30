class Pi
  def self.estimate rounds=100
    4 * rounds.times.count { rand**2 + rand**2 < 1 }.fdiv(rounds)
  end
end

if __FILE__ == $0
  if ARGV.first
    puts Pi.estimate(Integer(ARGV.first))
    exit
  end

  require 'minitest/autorun'

  describe Pi do
    it "estimates π with Good Enough precision" do
      assert_in_delta Math::PI, Pi.estimate(10_000), 0.1
    end
  end
end
