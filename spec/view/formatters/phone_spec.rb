# encoding: utf-8
require 'spec_helper'

describe "Phone formatter" do

  it "calls number_to_phone" do
    helper.view(5551234, :as => :phone).should == "555-1234"
  end

  it "allows no other options" do
    helper.should_receive(:number_to_phone).with(5551234, {})
    helper.view(5551234, :as => :phone, :foo => "bar")
  end

end
