require 'spec_helper'

describe "Blank formatter" do

  it "formats nil" do
    View.format(nil).should == ""
  end

  it "formats empty strings" do
    View.format("  ").should == ""
  end

  it "formats empty arrays" do
    View.format([]).should == ""
  end

  it "uses i18n for nil" do
    with_translation :view => { :blank => "nothing" } do
      View.format(nil).should == "nothing"
    end
  end

end
