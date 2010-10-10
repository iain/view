require 'spec_helper'

describe "Sentence formatter" do

  it "constructs a sentence" do
    object = [ 1, 2, 3 ]
    View.format(object).should == "1, 2, and 3"
  end

  it "has options for each element" do
    object = [ Date.today ]
    subject = View.format(object, :each => { :format => :short })
    subject.should == I18n.l(Date.today, :format => :short)
  end

  it "makes the sentence html safe if all elements are" do
    object = [ "safe".html_safe ]
    View.format(object).should be_html_safe
  end

  it "doesn't make the sentence html safe if not all elements are safe" do
    object = [ "safe".html_safe, "unsafe" ]
    View.format(object).should_not be_html_safe
  end

end
