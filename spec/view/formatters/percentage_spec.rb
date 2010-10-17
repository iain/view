# encoding: utf-8
require 'spec_helper'

describe "Percentage formatter" do

  it "calls number_to_percentage" do
    helper.view(19.99, :as => :percentage).should == "19.990%"
  end

  it "allowes no other options" do
    helper.should_receive(:number_to_percentage).with(19.99, {})
    helper.view(19.99, :as => :percentage, :foo => "bar")
  end

end
