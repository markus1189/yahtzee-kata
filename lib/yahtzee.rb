class Yahtzee
  class << self
    def [] category, dice
      DiceRoll.new(dice).score(category)
    end
  end
end

class DiceRoll

  def initialize(*dice)
    @dice = dice.flatten
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
    number = @categories[category.to_sym]
    @dice.count(number) * number
  end
end
