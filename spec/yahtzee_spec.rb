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

end
