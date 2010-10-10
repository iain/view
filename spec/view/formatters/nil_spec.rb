require 'spec_helper'

describe "Nil formatter" do

  it "formats nil" do
    View.format(nil).should == ""
  end

  it "uses i18n for nil" do
    with_translation :view => { :nil => "nothing" } do
      View.format(nil).should == "nothing"
    end
  end

end
