require 'spec_helper'

describe "Boolean formatter" do

  it "formats true" do
    View.format(true).should == "Yes"
  end

  it "formats false" do
    View.format(false).should == "No"
  end

  it "formats boolean values" do
    View.format("h", :as => :boolean).should == "Yes"
    View.format(nil, :as => :boolean).should == "No"
  end

  it "localizes booleans" do
    with_translation :view => { :booleans => { :true => "yup" } } do
      View.format(true).should == "yup"
    end
    with_translation :view => { :booleans => { :false => "nope" } } do
      View.format(false).should == "nope"
    end
  end


end
