require 'yahtzee'
describe Yahtzee do

  context "scoring numbered categories" do

    it "should score the sum of the specified numbers" do
      Yahtzee[1,1,2,4,4].score_numbered('fours').should == 8
      Yahtzee[1,4,2,6,3].score_numbered('ones').should == 1
      Yahtzee[5,5,5,5,5].score_numbered('fives').should == 25
    end

  end

  context "scoring pairs" do
    it "should score the highest pair" do
      Yahtzee[3,3,3,4,4].score_pair.should == 8
    end

    it "should score 0 if there is no pair" do
      Yahtzee[3,1,2,5,4].score_pair.should == 0
    end
  end

  context "scoring two pairs" do
    it "should score both" do
      Yahtzee[1,1,2,3,3].score_two_pairs.should == 8
    end

    it "should score 0 if there is only one pair" do
      Yahtzee[5,5,1,2,3].score_two_pairs.should == 0
    end

    it "should score 0 if there is no pair" do
      Yahtzee[6,1,4,5,3].score_two_pairs.should == 0
    end
  end

  context "scoring three of a kind" do
    it "should score the sum of the three numbers" do
      Yahtzee[6,6,6,1,2].score_three_of_a_kind.should == 18
    end

    it "should score 0 if there are no three of a kind" do
      Yahtzee[1,6,6,1,2].score_three_of_a_kind.should == 0
    end
  end

  context "scoring four of a kind" do
    it "should score 4 times the number" do
      Yahtzee[1,4,4,4,4].score_four_of_a_kind.should == 4*4
    end

    it "should score 0 if there is no 'four of a kind'" do
      Yahtzee[1,4,4,2,4].score_four_of_a_kind.should == 0
    end
  end

  context "scoring a small straight" do
    it "should score 15" do
      Yahtzee[1,2,3,4,5].score_small_straight.should == 15
    end

    it "should score 0 if the dice are not a small straight" do
      Yahtzee[1,2,3,4,6].score_small_straight.should == 0
    end
  end

  context "scoring a large straight" do
    it "should score 15" do
      Yahtzee[2,3,4,5,6].score_large_straight.should == 20
    end

    it "should score 0 if the dice are not a large straight" do
      Yahtzee[1,2,3,4,5].score_large_straight.should == 0
      Yahtzee[6,2,3,4,6].score_large_straight.should == 0
    end
  end

  context "scoring a full house" do
    it "should score the sum of the dice" do
      Yahtzee[1,1,1,6,6].score_full_house.should == 15
    end

    it "should score 0 if there is no full house" do
      Yahtzee[5,1,1,6,6].score_full_house.should == 0
      Yahtzee[3,3,3,3,3].score_full_house.should == 0
    end
  end

  context "scoring yahtzee" do
    it "should score 50" do
      Yahtzee[4,4,4,4,4].score_yahtzee.should == 50
    end

    it "should score 0 if there is no yahtzee" do
      Yahtzee[5,2,2,2,2].score_yahtzee.should == 0
    end
  end

  context "scoring change" do
    it "should score the sum of the dice" do
      Yahtzee[1,4,4,2,1].score_chance.should == 12
    end
  end
end
