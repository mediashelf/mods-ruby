require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "ModsNG" do
  
  before(:each) do
    @sample_mods = ModsNG.parse(fixture("SHPC_MODS.xml"))
  end
  
  it "should be a kind of Nokogiri XML Document with xpath method exposed" do
    @sample_mods.should be_kind_of Nokogiri::XML::Document  
    @sample_mods.should respond_to(:xpath) 
  end
  
  describe "#name" do
    it "should construct name nodes" do
      n1 = ModsNG.name("Beethoven, Ludwig van", :date=>"1770-1827")
      n1.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Beethoven, Ludwig van</namePart><namePart type="date">1770-1827</namePart></name>').to_xml
    
      n2 = ModsNG.name("Naxos Digital Services", :type=>"corporate")
      n2.to_xml.should == Nokogiri::XML.parse('<name type="corporate"><namePart>Naxos Digital Services</namePart></name>').to_xml
    
      n3 = ModsNG.name("Alterman, Eric", :role=>"creator")
      n3.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Alterman, Eric</namePart><role><roleTerm type="text">creator</roleTerm></role></name>').to_xml
    
      n4 = ModsNG.name("Tuell, Hiram.", :role=>{:value=>"creator", :authority=>"marcrelator"})
      n4.to_xml.should == Nokogiri::XML.parse('<name type="personal"><namePart>Tuell, Hiram.</namePart><role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role></name>').to_xml
    end
  end
  
  describe '#role' do
    it "should construct role nodes" do
      r1 = ModsNG.role("creator")
      r1.to_xml.should == Nokogiri::XML.parse('<role><roleTerm type="text">creator</roleTerm></role>').to_xml
    
      r2 = ModsNG.role("creator", :authority=>"marcrelator")
      r2.to_xml.should == Nokogiri::XML.parse('<role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role>').to_xml
    end
    it "should accept a root node to insert its results into" do
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.foo {
          xml.bar {
            ModsNG.role("creator", {:authority=>"marcrelator"}, xml.parent)
          }
        }
      end
      builder.to_xml.should == Nokogiri::XML.parse('<foo><bar><role><roleTerm type="text" authority="marcrelator">creator</roleTerm></role></bar></foo>').to_xml
      
    end
  end
  
  describe "names" do
    # mods=ModsNG.new
    # mods.names.create("Beethoven, Ludwig van", :date=>"1770-1827")
    # mods.names.create("Naxos Digital Services", :type=>"corporate")
    # mods.names.create("Alterman, Eric", :role=>"creator")
    # mods.names.create("Tuell, Hiram.", :role=>{:value=>"creator", :authority=>"marcrelator"})
    # 
    # foo = <<-END_MODS
    # <mods xmlns="...">
    # <name type="personal">
    # <namePart>Beethoven, Ludwig van</namePart>
    # <namePart type="date">1770-1827</namePart></name>
    # <name type="corporate">
    # <namePart>Naxos Digital Services</namePart></name>
    # <name type="personal">
    # <namePart>Alterman, Eric</namePart><role><roleTerm type="text">creator</roleTerm></role></name>
    # <name type="personal">
    # <namePart>Tuell, Hiram.</namePart><role><roleTerm authority="marcrelator" type="text">creator</roleTerm></role></name>
    # </mods>
    # END_MODS
    # 
    # mods.to_xml.should == foo
    
  end
  
end