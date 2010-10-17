require 'spec_helper'

describe "Delimited formatter" do

  it "calls number_with_delimiter" do
    helper.view(19_999.99, :as => :delimited).should == "19,999.99"
  end

  it "allows no other options" do
    helper.should_receive(:number_with_delimiter).with(19.99, :delimiter => ";")
    helper.view(19.99, :as => :delimited, :delimiter => ";", :foo => "bar")
  end

end
