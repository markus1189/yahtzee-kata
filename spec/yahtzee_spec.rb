require 'yahtzee'
describe Yahtzee do

  context "scoring numbered categories" do

    it "should score the sum of the specified numbers" do
      Yahtzee['fours', [1,1,2,4,4] ].should == 8
      Yahtzee['ones',  [1,4,2,6,3] ].should == 1
      Yahtzee['fives', [5,5,5,5,5] ].should == 25
    end

  end

  context "scoring pairs" do
    it "should score the highest pair" do
      Yahtzee['pair', [3,3,3,4,4] ].should == 8
    end

    it "should score 0 if there is no pair" do
      Yahtzee['pair', [3,1,2,5,4] ].should == 0
    end
  end

  context "scoring two pairs" do
    it "should score both" do
      Yahtzee['two pair', [1,1,2,3,3] ].should == 8
    end

    it "should score 0 if there is only one pair" do
      Yahtzee['two pair', [5,5,1,2,3] ].should == 0
    end

    it "should score 0 if there is no pair" do
      Yahtzee['two pair', [6,1,4,5,3] ].should == 0
    end
  end

  context "scoring three of a kind" do
    it "should score the sum of the three numbers" do
      Yahtzee['three of a kind', [6,6,6,1,2] ].should == 18
    end

    it "should score 0 if there are no three of a kind" do
      Yahtzee['three of a kind', [1,6,6,1,2] ].should == 0
    end
  end

  context "scoring four of a kind" do
    it "should score 4 times the number" do
      Yahtzee['four of a kind', [1,4,4,4,4] ].should == 4*4
    end

    it "should score 0 if there is no 'four of a kind'" do
      Yahtzee['four of a kind', [1,4,4,2,4] ].should == 0
    end
  end

  context "scoring a small straight" do
    it "should score 15" do
      Yahtzee['small straight', [1,2,3,4,5] ].should == 15
    end

    it "should score 0 if the dice are not a small straight" do
      Yahtzee['small straight', [1,2,3,4,6] ].should == 0
    end
  end

  context "scoring a large straight" do
    it "should score 15" do
      Yahtzee['large straight', [2,3,4,5,6] ].should == 20
    end

    it "should score 0 if the dice are not a large straight" do
      Yahtzee['large straight', [1,2,3,4,5] ].should == 0
      Yahtzee['large straight', [6,2,3,4,6] ].should == 0
    end
  end

  context "scoring a full house" do
    it "should score the sum of the dice" do
      Yahtzee['full house', [1,1,1,6,6] ].should == 15
    end

    it "should score 0 if there is no full house" do
      Yahtzee['full house', [5,1,1,6,6] ].should == 0
      Yahtzee['full house', [3,3,3,3,3] ].should == 0
    end
  end

  context "scoring yahtzee" do
    it "should score 50" do
      Yahtzee['yahtzee', [4,4,4,4,4] ].should == 50
    end

    it "should score 0 if there is no yahtzee" do
      Yahtzee['yahtzee', [5,2,2,2,2] ].should == 0
    end
  end

  context "scoring change" do
    it "should score the sum of the dice" do
      Yahtzee['chance', [1,4,4,2,1] ].should == 12
    end
  end
end
