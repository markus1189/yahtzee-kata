require 'yahtzee'
describe Yahtzee do
  it "should score numbered categories" do
    Yahtzee['fours', [1,1,2,4,4] ].should == 8
    Yahtzee['ones',  [1,4,2,6,3] ].should == 1
    Yahtzee['fives', [5,5,5,5,5] ].should == 25
  end
end
