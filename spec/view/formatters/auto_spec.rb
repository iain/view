require 'spec_helper'

describe "Auto formatter" do

  it "formats like a boolean automatically" do
    View.format(true).should == "Yes"
  end

  it "is configurable" do
    foo = Class.new(View::Formatter) do
      as :foo
      def format
        "!!!#{value}!!!"
      end
    end
    View::Auto.add :foo do
      value == "foobar"
    end
    View.format("foobar").should == "!!!foobar!!!"
  end

end
