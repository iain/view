require 'spec_helper'

describe "Table formatter" do

  it "renders a table" do
    time = Time.now
    obj = Struct.new(:foo, :bar).new("baz", time)
    collection = [ obj ] * 2
    html = helper.view collection, :as => :table do |tb|
      tb.view :foo
      tb.view :bar, :as => :date
    end
    bar = I18n.l(time.to_date)
    html.squish.should == <<-HTML.squish
      <table>
        <thead>
          <tr>
            <th class="foo">Foo</th>
            <th class="bar">Bar</th>
          </tr>
        </thead>
        <tbody>
          <tr class="odd">
            <td class="foo">baz</td>
            <td class="bar">#{bar}</td>
          </tr>
          <tr class="even">
            <td class="foo">baz</td>
            <td class="bar">#{bar}</td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  it "renders links when the link option is used" do
    helper.instance_eval do
      def polymorphic_path(opts)
        "link"
      end
    end
    collection = [ Struct.new(:foo).new("Fooz") ]
    html = helper.view collection, :as => :table do |tb|
      tb.view :foo, :as => :link
    end
    html.squish.should == <<-HTML.squish
      <table>
        <thead>
          <tr>
            <th class="foo">Foo</th>
          </tr>
        </thead>
        <tbody>
          <tr class="odd">
            <td class="foo"><a href="link">Fooz</a></td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  it "renders links when the path option is used" do
    helper.instance_eval do
      def polymorphic_path(opts)
        "link"
      end
    end
    collection = [ Struct.new(:foo).new("Fooz") ]
    html = helper.view collection, :as => :table do |tb|
      tb.view :foo, :path => :edit
    end
    html.squish.should == <<-HTML.squish
      <table>
        <thead>
          <tr>
            <th class="foo">Foo</th>
          </tr>
        </thead>
        <tbody>
          <tr class="odd">
            <td class="foo"><a href="link">Fooz</a></td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  it "renders fields" do
    collection = [ Struct.new(:foo).new("Fooz") ]
    html = helper.view collection, :as => :table, :fields => [ :foo ]
    html.squish.should == <<-HTML.squish
      <table>
        <thead>
          <tr>
            <th class="foo">Foo</th>
          </tr>
        </thead>
        <tbody>
          <tr class="odd">
            <td class="foo">Fooz</td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  it "renders a link on a field" do
    helper.instance_eval do
      def polymorphic_path(opts)
        "link"
      end
    end
    collection = [ Struct.new(:foo).new("Fooz") ]
    html = helper.view collection, :as => :table, :fields => [ :foo ], :link => "foo"
    html.squish.should == <<-HTML.squish
      <table>
        <thead>
          <tr>
            <th class="foo">Foo</th>
          </tr>
        </thead>
        <tbody>
          <tr class="odd">
            <td class="foo"><a href="link">Fooz</a></td>
          </tr>
        </tbody>
      </table>
    HTML
  end

end
