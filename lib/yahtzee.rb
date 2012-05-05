class Yahtzee
  class << self
    def [] category, dice
      DiceRoll.new(dice).score(category)
    end
  end
end

class DiceRoll

  def initialize(*dice)
    @dice = dice.flatten.sort

    @categories = {
      ones:   1,
      twos:   2,
      threes: 3,
      fours:  4,
      fives:  5,
      sixes:  6
    }

  end

  def score category
    case category
    when /^ones$/, /^twos$/, /^threes$/, /^fours$/, /^fives$/, /^sixes$/
      number = @categories.fetch(category.to_sym)
      @dice.count(number) * number
    when /^pair$/
      ( @dice.partition { |num| @dice.count(num) >= 2 }.first.max || 0 ) * 2
    else
      fail "Unknown category: '#{category}'"
    end
  end
end

