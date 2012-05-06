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
      return 0 unless pair?
      @dice.partition { |num| @dice.count(num) >= 2 }.first.max * 2
    when /^two pair$/
      pairs = @dice.partition { |num| @dice.count(num) >= 2 }.first
      if pairs.size == 4 then pairs.inject(&:+) else 0 end
    when /^three of a kind$/
      return 0 unless three?
      @dice.max_by { |num| @dice.count num } * 3
    when /^four of a kind$/
      return 0 unless four?
      @dice.partition { |num| @dice.count(num) == 4 }.first.inject(:+)
    when /^small straight$/
      dice = @dice.sort
      return 0 unless dice.uniq.size == 5 && [dice.min, dice.max] == [1,5]
      15
    when /^large straight$/
      dice = @dice.sort
      return 0 unless dice.uniq.size == 5 && [dice.min, dice.max] == [2,6]
      20
    else
      fail "Unknown category: '#{category}'"
    end
  end

  def pair?
    sequence_of? 2
  end

  def three?
    sequence_of? 3
  end

  def four?
    sequence_of? 4
  end

  private

  def sequence_of? number
    @dice.any? { |num| @dice.count(num) == number }
  end
end

