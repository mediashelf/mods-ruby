require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "ModsHelpers" do
  
  before(:all) do
    class SpecClassWithModsHelpers
      include ModsHelpers
    end
  end
  
  after(:all) do
    Object.send(:remove_const, :SpecClassWithModsHelpers)
  end
  
  describe "names" do
  end
  
end