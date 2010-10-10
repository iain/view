require 'spec_helper'

describe "Self formatter" do

  it "doesn't format with formatter self" do
    time = Time.now
    View.format(time, :as => :self).should == time
  end

end
