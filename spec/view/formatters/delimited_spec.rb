require 'spec_helper'

describe "Delimited formatter" do

  before do
    helper.stub(:number_with_delimiter).and_return("called")
  end

  it "calls number_with_delimiter" do
    helper.view(19.99, :as => :delimited).should == "called"
  end

  it "allowes no other options" do
    helper.should_receive(:number_with_delimiter).with(19.99, :delimiter => ";")
    helper.view(19.99, :as => :delimited, :delimiter => ";", :foo => "bar")
  end

end
