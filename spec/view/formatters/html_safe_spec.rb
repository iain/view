require 'spec_helper'

describe "HTML Safe Helper" do

  it "should make something safe" do
    value = "foo"
    value.should_not be_html_safe
    subject = View.format(value, :as => :html_safe)
    subject.should be_html_safe
    subject.should == value
  end

end
