require 'nokogiri'
require 'mods-ruby'
require 'mods-ruby/mods_helpers'

module ModsRuby
  class ModsNG < Nokogiri::XML::Document
  
    include ModsRuby::ModsHelpers
  
  end
end
