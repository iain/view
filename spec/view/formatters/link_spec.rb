require 'spec_helper'

describe "Link formatter" do

  it "links" do
    helper.view("foo", :as => :link, :to => "bar.com").should == %|<a href="bar.com">foo</a>|
  end

  it "links objects" do
    post = Struct.new(:to_label).new("post")
    helper.should_receive(:polymorphic_path).with([:edit, post]).and_return("/posts/2/edit")
    helper.view(post, :as => :link, :path => :edit).should == %|<a href="/posts/2/edit">post</a>|
  end

  it "has option :text" do
    subject = helper.view("foo", :as => :link, :to => "bar.com", :text => "bang")
    subject.should == %|<a href="bar.com">bang</a>|
  end

end
