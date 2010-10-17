# encoding: utf-8
require 'spec_helper'

describe "Size formatter" do

  it "calls number_to_human_size" do
    helper.view(1999, :as => :size).should == "1.95 KB"
  end

  it "allows no other options" do
    helper.should_receive(:number_to_currency).with(19.99, {})
    helper.view(19.99, :as => :currency, :foo => "bar")
  end

end
