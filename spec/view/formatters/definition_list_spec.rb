require 'spec_helper'

describe "Definition List formatter" do

  it "creates a definition list" do
    obj = Struct.new(:foo).new("bar")
    subject = helper.view obj, :as => :definition_list do |dl|
      dl.view :foo
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

  it "has a :fields option" do
    klass = Struct.new(:foo, :baz)
    obj = klass.new("bar", "bang")
    subject = helper.view obj, :as => :definition_list, :fields => [:foo]
    subject.should == %|<dl><dt class="foo">Foo</dt><dd class="foo">bar</dd></dl>|
  end

  it "formats the attributes themselves" do
    time = Time.now
    obj = Struct.new(:foo).new(time)
    subject = helper.view obj, :as => :definition_list do |dl|
      dl.view :foo, :as => :date
    end
    subject.should == %|<dl><dt class="foo">Foo</dt><dd class="foo">#{I18n.l(time.to_date)}</dd></dl>|
  end

  it "uses the options as options for the dl-tag" do
    obj = Struct.new(:foo).new("bar")
    subject = helper.view obj, :as => :definition_list, :id => "genesis" do |dl|
      dl.view :foo
    end
    subject.should == %|<dl id="genesis"><dt class="foo">Foo</dt><dd class="foo">bar</dd></dl>|
  end

  it "uses human_attribute_name on dt-tags when it can" do
    klass = Struct.new(:foo) do
      def self.human_attribute_name(key)
        key.to_s.upcase
      end
    end
    obj = klass.new("bar")
    subject = helper.view obj, :as => :definition_list, :fields => [:foo]
    subject.should == %|<dl><dt class="foo">FOO</dt><dd class="foo">bar</dd></dl>|
  end

end
