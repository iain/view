# encoding: utf-8
require 'spec_helper'

describe "Precision formatter" do

  it "calls number_with_precision" do
    helper.view(19.99, :as => :precision).should == "19.990"
  end

  it "allowes no other options" do
    helper.should_receive(:number_with_precision).with(19.99, {})
    helper.view(19.99, :as => :precision, :foo => "bar")
  end

end
