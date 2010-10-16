# encoding: utf-8
require 'spec_helper'

describe "Currency formatter" do

  it "calls number_to_currency" do
    helper.view(19.99, :as => :currency).should == "$19.99"
  end

  it "allowes no other options" do
    helper.should_receive(:number_to_currency).with(19.99, :unit => "£")
    helper.view(19.99, :as => :currency, :unit => "£", :foo => "bar")
  end

end
