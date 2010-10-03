require 'spec_helper'

describe "Boolean formatter" do

  it "formats true" do
    View.to_s(true).should == "Yes"
  end

  it "formats false" do
    View.to_s(false).should == "No"
  end

  it "formats boolean values" do
    View.to_s("h", :as => :boolean).should == "Yes"
    View.to_s(nil, :as => :boolean).should == "No"
  end

  it "localizes booleans" do
    with_translation :view => { :booleans => { :true => "yup" } } do
      View.to_s(true).should == "yup"
    end
    with_translation :view => { :booleans => { :false => "nope" } } do
      View.to_s(false).should == "nope"
    end
  end


end
