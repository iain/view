require 'spec_helper'

describe "Nil formatter" do

  it "formats nil" do
    View.to_s(nil).should == ""
  end

  it "uses i18n for nil" do
    with_translation :view => { :nil => "nothing" } do
      View.to_s(nil).should == "nothing"
    end
  end

end
