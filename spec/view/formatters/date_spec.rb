require 'spec_helper'

describe "Date formatter" do

  it "localizes dates" do
    date = Date.new(2010, 10, 11)
    with_translation :date => { :formats => { :foo => "%A" }, :day_names => [ "zondag", "maandag" ] } do
      View.to_s(date, :format => :foo).should == "maandag"
    end
  end

  it "formats dates" do
    date = Date.new(2010, 10, 10)
    View.to_s(date).should == "2010-10-10"
  end

  it "forces datetimes to date" do
    time = Time.new(2010, 10, 10, 8, 45, 30, '+01:00')
    View.to_s(time, :as => :date).should == "2010-10-10"
  end

end
