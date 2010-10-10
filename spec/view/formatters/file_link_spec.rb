require 'spec_helper'

describe "FileLink formatter" do

  let :object do
    Struct.new(:to_label, :url) {
      def file?
        true
      end
      def foo_bar
        "foo is bar"
      end
    }.new("label", "url")
  end

  it "calls link_to" do
    helper.should_receive(:link_to).with("label", "url", {:target => "_blank"}).and_return("called")
    helper.view(object, :as => :file_link).should == "called"
  end

  it "uses the file_link automatically for paperclip like objects" do
    helper.should_receive(:link_to).and_return("called")
    helper.view(object).should == "called"
  end

  it "uses the :text option for link text" do
    subject = helper.view(object, :as => :file_link, :text => "foo")
    subject.should == %|<a href="url" target="_blank">foo</a>|
  end

  it "uses the :text_method option for link text" do
    subject = helper.view(object, :as => :file_link, :text_method => :foo_bar)
    subject.should == %|<a href="url" target="_blank">foo is bar</a>|
  end

  it "guesses the name of the link" do
    subject = helper.view(object, :as => :file_link)
    subject.should == %|<a href="url" target="_blank">label</a>|
  end

end
