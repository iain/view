require 'spec_helper'

describe "View::Formatter" do

  it "works" do
    View.format("bar").should == "bar"
  end

  it "parses the block" do
    View.format("bar") { |formatter| formatter.to_s.upcase }.should == "BAR"
  end

end
