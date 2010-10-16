require 'spec_helper'

describe "View::Helper" do

  it "views" do
    View.should_receive(:format).with('x', {:foo => 'bar'}, helper)
    helper.view('x', :foo => 'bar')
  end

  it "renders a table" do
    View.should_receive(:format).with('x', {:as => :table}, helper)
    helper.table_for('x')
  end

  it "renders a definition list" do
    View.should_receive(:format).with('x', {:as => :definition_list}, helper)
    helper.definition_list_for('x')
  end

  it "renders a definition list for a resource" do
    helper.should_receive(:resource).and_return('x')
    View.should_receive(:format).with('x', {:as => :definition_list}, helper)
    helper.definition_list
  end

  it "renders a definition list for a resource" do
    helper.should_receive(:collection).and_return(['x'])
    helper.should_receive(:resource_class).and_return(String)
    View.should_receive(:format).with(['x'], {:as => :table, :class => String}, helper)
    helper.table
  end

end
