require 'spec_helper'

describe "Auto formatter" do

  it "guesses the to_label" do
    object = Struct.new(:to_label).new("some label")
    View.to_s(object).should == "some label"
  end

  it "guesses to_s" do
    object = Struct.new(:to_s).new("string")
    View.to_s(object).should == "string"
  end

  it "guesses a name" do
    object = Struct.new(:name).new("my name")
    View.to_s(object).should == "my name"
  end

  it "guesses a login" do
    object = Struct.new(:login).new("loginname")
    View.to_s(object).should == "loginname"
  end

end
