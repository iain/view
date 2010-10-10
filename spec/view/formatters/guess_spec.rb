require 'spec_helper'

describe "Guess formatter" do

  it "guesses the to_label" do
    object = Struct.new(:to_label).new("some label")
    View.format(object).should == "some label"
  end

  it "guesses to_s" do
    object = Struct.new(:to_s).new("string")
    View.format(object).should == "string"
  end

  it "guesses a name" do
    object = Struct.new(:name).new("my name")
    View.format(object).should == "my name"
  end

  it "guesses a login" do
    object = Struct.new(:login).new("loginname")
    View.format(object).should == "loginname"
  end

end
