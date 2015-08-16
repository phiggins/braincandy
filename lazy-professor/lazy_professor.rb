class LazyProfessor
  def self.answer_key_from_answers(answers)
    answers.
      split("\n").
      map(&:chars).
      transpose.
      map {|a| a.max_by {|b| a.count(b) } }.
      join
  end
end

if __FILE__ == $0
  if ARGV.first
    puts LazyProfessor.answer_key_from_answers(File.read(ARGV.first))
    exit 0
  end

  require 'minitest/autorun'
  require 'minitest/pride'

  describe LazyProfessor do
    it "generates the answer key from sample answers" do
      sample_answers = <<-ANSWERS.delete(" ")
        ABCCADCB
        DDDCAACB
        ABDDABCB
        AADCAACC
        BBDDAACB
        ABDCCABB
        ABDDCACB
      ANSWERS

      expected = "ABDCAACB"
      actual = LazyProfessor.answer_key_from_answers(sample_answers)

      assert_equal expected, actual
    end
  end
end
