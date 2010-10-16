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

end
