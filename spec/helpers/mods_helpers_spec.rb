require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "mods-ruby"
require 'mods-ruby/mods_helpers.rb'

include ModsRuby

describe "ModsHelpers" do
  
  # before(:all) do
  #   class SpecClassWithModsHelpers
  #     include ModsHelpers
  #   end
  # end
  # 
  # after(:all) do
  #   Object.send(:remove_const, :SpecClassWithModsHelpers)
  # end
  
  describe "#name" do
    it "should construct name nodes" do
      n1 = ModsHelpers.name_("Beethoven, Ludwig van", :date=>"1770-1827")
      n1.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Beethoven, Ludwig van</namePart><namePart type="date">1770-1827</namePart></name>').to_xml
    
      n2 = ModsHelpers.name_("Naxos Digital Services", :type=>"corporate")
      n2.to_xml.should == Nokogiri::XML.parse('<name type="corporate"><namePart>Naxos Digital Services</namePart></name>').to_xml
    
      n3 = ModsHelpers.name_("Alterman, Eric", :role=>"creator")
      n3.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Alterman, Eric</namePart><role><roleTerm type="text">creator</roleTerm></role></name>').to_xml
    
      n4 = ModsHelpers.name_("Tuell, Hiram.", :role=>{:value=>"creator", :authority=>"marcrelator"})
      n4.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Tuell, Hiram.</namePart><role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role></name>').to_xml
    end
  end
  
  describe '#role' do
    it "should construct role nodes" do
      r1 = ModsHelpers.role("creator")
      r1.to_xml.should == Nokogiri::XML.parse('<role><roleTerm type="text">creator</roleTerm></role>').to_xml
    
      r2 = ModsHelpers.role("creator", :authority=>"marcrelator")
      r2.to_xml.should == Nokogiri::XML.parse('<role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role>').to_xml
    end
    it "should accept a root node to insert its results into" do
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.foo {
          xml.bar {
            ModsHelpers.role("creator", {:authority=>"marcrelator"}, xml.parent)
          }
        }
      end
      builder.to_xml.should == Nokogiri::XML.parse('<foo><bar><role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role></bar></foo>').to_xml
      
    end
  end
  
end