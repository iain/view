require 'spec_helper'

describe View::Configuration do

  it { should respond_to(:guessing_methods) }
  it { should respond_to(:file_methods) }
  it { should respond_to(:path_methods) }
  it { should respond_to(:default_formatter) }
  it { should respond_to(:default_list_formatter) }

end
