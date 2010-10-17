require 'spec_helper'

describe "Image formatter" do

  let :image do
    Struct.new(:url) {
      def file?
        true
      end
    }.new("/images/foo.jpg")
  end

  before do
    helper.stub(:path_to_image).and_return("/images/foo.jpg")
  end

  it "shows an img" do
    helper.view(image, :as => :image).should == %|<img alt="Foo" src="/images/foo.jpg" />|
  end

  it "doesn't show an image when it's not here" do
    image.stub(:file?).and_return(false)
    helper.view(image, :as => :image).should == nil
  end

  it "shows an thumbnail" do
    image.should_receive(:url).with(:thumbnail)
    helper.view(image, :as => :image, :style => :thumbnail)
  end

  it "passes html options to image tag" do
    subject =helper.view(image, :as => :image, :html => { :size => "20x20" })
    subject.should == %|<img alt="Foo" height="20" src="/images/foo.jpg" width="20" />|
  end

end
