# encoding: utf-8
require 'spec_helper'

describe "Currency formatter" do

  before do
    helper.stub(:number_to_currency).and_return("called")
  end

  it "calls number_to_currency" do
    helper.view(19.99, :as => :currency).should == "called"
  end

  it "allowes no other options" do
    helper.should_receive(:number_to_currency).with(19.99, :unit => "£")
    helper.view(19.99, :as => :currency, :unit => "£", :foo => "bar")
  end

end
