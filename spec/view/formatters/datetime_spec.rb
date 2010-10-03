require 'spec_helper'

describe "Datetime formatter" do

  it "formats" do
    time = Time.new(2010, 10, 10, 8, 45, 30, '+01:00')
    View.to_s(time).should == "Sun, 10 Oct 2010 08:45:30 +0100"
  end

  it "localizes" do
    time = Time.new(2010, 10, 10, 8, 45, 30, '+01:00')
    with_translation :time => { :formats => { :short => "%d-%m-%Y %H:%M" } } do
      View.to_s(time, :format => :short).should == "10-10-2010 08:45"
    end
  end

end
