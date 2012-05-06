class Yahtzee
  def initialize *dice
    @dice_roll = DiceRoll.new dice.flatten
  end

  def method_missing meth, *args, &blk
    if @dice_roll.respond_to? meth
      @dice_roll.send meth, *args, &blk
    else
      super
    end
  end

  class << self
    def [] *dice
      new *dice
    end
  end
end

class DiceRoll
  class ScoringError < StandardError; end

  def initialize *dice
    @dice = dice.flatten.sort

    @categories_to_num = {
      ones:   1,
      twos:   2,
      threes: 3,
      fours:  4,
      fives:  5,
      sixes:  6
    }

  end

  def score_numbered category
    number = @categories_to_num.fetch(category.to_sym)
    @dice.count(number) * number
  end

  def score_pair
    return 0 unless pair?
    pair_candidates = @dice.select { |num| @dice.count(num) >= 2 }.uniq
    candidate = pair_candidates.max
    2.times { @dice.delete candidate }
    candidate * 2
  end

  def score_pair!
    not_zero_or_exception { score_pair }
  end

  def score_two_pairs
    score_pair! + score_pair!
  rescue ScoringError
    0
  end

  def score_three_of_a_kind
    x_of_a_kind(3)
  end

  def score_three_of_a_kind
    x_of_a_kind(3)
  end

  def score_three_of_a_kind!
    not_zero_or_exception { score_three_of_a_kind }
  end

  def score_four_of_a_kind
    x_of_a_kind(4)
  end

  def score_small_straight
    score_straight(:small)
  end

  def score_large_straight
    score_straight(:large)
  end

  def score_full_house
    score_pair! + score_three_of_a_kind!
  rescue ScoringError
    0
  end

  def score_yahtzee
    return 0 unless @dice.uniq.size == 1
    50
  end

  def score_chance
    sum
  end

  def pair?
    sequence_of? 2
  end

  def straight?
    @dice.uniq.size == @dice.size
  end

  def min
    @dice.min
  end

  def max
    @dice.max
  end

  def sum
    @dice.inject(&:+)
  end

  private

  def not_zero_or_exception &blk
    result = yield
    result != 0 ? result : fail(ScoringError)
  end

  def score_straight(type)
    max = if type == :small then 5 else 6 end
    return 0 unless straight? && self.max == max
    ((max-4)..max).inject(&:+)
  end

  def x_of_a_kind(x)
    return 0 unless sequence_of? x
    candidate = @dice.find { |num| @dice.count(num) == x }
    x.times { @dice.delete candidate }
    candidate * x
  end

  def sequence_of? number
    @dice.any? { |num| @dice.count(num) == number }
  end
end

