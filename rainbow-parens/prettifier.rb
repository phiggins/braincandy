require 'strscan'

COLORS = {
  :blank    => "\e[0m",
  :red      => "\e[31m",
  :green    => "\e[32m",
  :yellow   => "\e[33m",
  :blue     => "\e[34m",
  :magenta  => "\e[35m",
  :cyan     => "\e[36m",
}

class Prettifier
  OPEN_PARENS   = ['(', '[', '{']
  CLOSE_PARENS  = [')', ']', '}']
  STRING_DELIM  = %w[' "]
  TOKENS        = Regexp.union(*OPEN_PARENS, *CLOSE_PARENS, *STRING_DELIM)
  PAIRS         = OPEN_PARENS.zip(CLOSE_PARENS).to_h

  def self.prettify string, colorizer=nil
    default = [:blue, :green].cycle
    def default.call ; self.next ; end

    new.prettify string, colorizer || default
  end

  def prettify string, colorizer
    scanner = StringScanner.new string
    stack = []
    pretty = ""

    while match = scanner.scan_until(TOKENS) do
      match = match[0..-2]
      token = scanner.matched

      unless match.empty?
        pretty << COLORS[:blank]
        pretty << match
      end

      case token
      when *OPEN_PARENS
        color = COLORS[colorizer.call]
        stack.push [color, token]
        pretty << color
        pretty << token
      when *CLOSE_PARENS
        color, match_token = stack.pop
        raise InvalidInput unless PAIRS[match_token] == token
        pretty << color
        pretty << token
      when *STRING_DELIM
        pretty << COLORS[:blank]
        pretty << token
        pretty << scanner.scan_until(/#{token}/)
      end
    end

    raise UnbalancedParens unless stack.empty?

    pretty << COLORS[:blank]
    pretty
  end

  class InvalidInput < StandardError ; end
  class UnbalancedParens < StandardError ; end
end

if __FILE__ == $0
  if ARGV.first
    puts Prettifier.prettify ARGV.first
    exit 0
  end

  require 'minitest/autorun'
  require 'minitest/pride'

  describe Prettifier do
    it "prettifies strings" do
      string = "([{()}()])"
      pretty = "\e[34m(\e[32m[\e[34m{\e[32m(\e[32m)\e[34m}\e[34m(\e[34m)\e[32m]\e[34m)\e[0m"

      assert_equal pretty, Prettifier.prettify(string)
    end

    it "blows up with unbalanced parens" do
      assert_raises Prettifier::UnbalancedParens do
        Prettifier.prettify "([{"
      end
    end

    it "blows up with invalid paren order" do
      assert_raises Prettifier::InvalidInput do
        Prettifier.prettify "([{()}()}])"
      end
    end

    it "does not care about parens in strings" do
      string = %{(define smile ":)")}
      pretty = "\e[34m(\e[0mdefine smile \e[0m\":)\"\e[34m)\e[0m"

      assert_equal pretty, Prettifier.prettify(string)
    end
  end
end
