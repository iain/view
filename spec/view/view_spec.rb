require 'spec_helper'

describe "View" do

  it "doesn't touch strings" do
    View.to_s("bar").should == "bar"
  end

  it "parses the block" do
    View.to_s("bar") { |val| val.upcase }.should == "BAR"
  end

end
