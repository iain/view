require 'spec_helper'

describe "Human formatter" do

  it "uses number to human" do
    helper.view(10_000, :as => :human).should == "10 Thousand"
  end

end
