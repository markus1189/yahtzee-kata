class Yahtzee
  def initialize dice_roll
    @dice_roll = dice_roll
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
      new DiceRoll.new(dice.flatten)
    end
  end
end

class DiceRoll

  def initialize *dice
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

  def score_numbered category
    number = @categories.fetch(category.to_sym)
    @dice.count(number) * number
  end

  def score_pair
    return 0 unless pair?
    pair_candidates = @dice.select { |num| @dice.count(num) >= 2 }.uniq
    candidate = pair_candidates.max
    2.times { @dice.delete candidate }
    candidate * 2
  end

  def score_two_pairs
    first  = score_pair
    second = score_pair
    if second == 0 then 0 else first + second end
  end

  def score_three_of_a_kind
    x_of_a_kind(3)
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
    return 0 unless full_house?
    @dice.inject(&:+)
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

  def three?
    sequence_of? 3
  end

  def four?
    sequence_of? 4
  end

  def straight?
    @dice.uniq.size == @dice.size
  end

  def full_house?
    three_of_a_kind = @dice.any? { |x| @dice.count(x) == 3 }
    pair            = @dice.any? { |x| @dice.count(x) == 2 }
    three_of_a_kind && pair
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

