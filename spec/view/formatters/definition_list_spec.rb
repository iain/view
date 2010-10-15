require 'spec_helper'

describe "Definition List formatter" do

  it "creates a definition list" do
    obj = Struct.new(:foo).new("bar")
    subject = helper.view obj, :as => :definition_list do |dl|
      dl.show :foo
    end
    subject.should == %|<dl><dt class="foo">Foo</dt><dd class="foo">bar</dd></dl>|
  end

  it "shows all column names" do
    klass = Struct.new(:foo, :baz) do
      def self.column_names
        [ :foo ]
      end
    end
    obj = klass.new("bar", "bang")
    subject = helper.view obj, :as => :definition_list
    subject.should == %|<dl><dt class="foo">Foo</dt><dd class="foo">bar</dd></dl>|
  end

  it "formats the attributes themselves" do
    time = Time.now
    obj = Struct.new(:foo).new(time)
    subject = helper.view obj, :as => :definition_list do |dl|
      dl.show :foo, :as => :date
    end
    subject.should == %|<dl><dt class="foo">Foo</dt><dd class="foo">#{I18n.l(time.to_date)}</dd></dl>|
  end

  it "uses the options as options for the dl-tag" do
    obj = Struct.new(:foo).new("bar")
    subject = helper.view obj, :as => :definition_list, :id => "genesis" do |dl|
      dl.show :foo
    end
    subject.should == %|<dl id="genesis"><dt class="foo">Foo</dt><dd class="foo">bar</dd></dl>|
  end

end
