require 'spec_helper'

describe "View::Formatter" do

  it "doesn't touch strings" do
    View.format("bar").should == "bar"
  end

  it "parses the block" do
    View.format("bar") { |val| val.upcase }.should == "BAR"
  end

end
