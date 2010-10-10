require 'spec_helper'

describe "Sentence formatter" do

  it "constructs a sentence" do
    object = [ 1, 2, 3 ]
    View.format(object).should == "1, 2, and 3"
  end

end
