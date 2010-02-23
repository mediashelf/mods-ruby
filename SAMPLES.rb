###
### Defining the datastreams in your model
###

class Foo < ActiveFedora::Base

  # Opt 1: just tell it what Module to mix into the Nokogiri object
  has_metadata "mods_opt1" :mixin=>ModsRuby::ModsHelpers

  # Opt 2: Use a MODS-specific Datastream class (which probably just subclasses NokogiriDatastream and mixes in ModsRuby::ModsHelpers)
  has_metadata "mods_opt2" :type=>ActiveFedora::ModsDatastream 
  
end

###
### Interacting with the Datasttreams ###
###

mods_ds = Foo.datastreams["mods"]

# all Nokogiri datastreams will expose Nokogiri interface
mods_ds.xpath("/name") do |x|
  puts x.inspect
end

# what we want -- .each_name is mixed into Nokogiri::XML::NodeSet.  It returns something other than Nokogiri::XML::Node instances.  
# This way, Nokogiri's .each method will remain untouched and .each_name will be available on any NodeSet regardless of whether 
# you retrieve it with a regular xpath or a convenience wrapper like .names
<name type="personal">
  <namePart>Beethoven, Ludwig van</namePart>
  <namePart type="date">1770-1827</namePart>
</name>

mods_ds.names("Beethoven, L V") do |n|
  n.value = "Beethoven, Ludwig Van"
  n.date = "1770-1827"
end

mods_ds.xpath("//role").each_role do |r|
  puts r.authority
  puts r.value
end


###
### Use class methods (or module methods) to generate mods xml 
###

ModsHelpers.name_("Beethoven, Ludwig van", :date=>"1770-1827")
ModsHelpers.name_("Naxos Digital Services", :type=>"corporate")
ModsHelpers.name_("Alterman, Eric", :role=>"creator")
ModsHelpers.name_("Tuell, Hiram.", :role=>{:value=>"creator", :authority=>"marcrelator"})
ModsHelpers.role("creator")
ModsHelpers.role("creator", :authority=>"marcrelator")


