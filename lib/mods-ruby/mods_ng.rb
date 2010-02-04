require 'nokogiri'

class ModsNG < Nokogiri::XML::Document
  
  def names
  end
  
  def self.name text, opts={}
    opts = {:type=>"personal"}.merge opts
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.name(:type=>opts[:type]) {
        xml.namePart text
        if opts[:date] 
          xml.namePart(opts[:date], :type=>"date")  
        end
        
        # Adds role, accepting either :role=>"value" or :role=>{:value=>"value", :opt1=>"opt"}
        if opts[:role] 
          xml.role {
            if opts[:role].kind_of? Hash
              role_opts = {:type=>"text"}.merge! opts[:role]
              xml.roleTerm(role_opts.delete(:value), role_opts) 
            else
              xml.roleTerm(opts[:role], :type=>"text")
            end
          }
        end
        
      }
    end
    return builder.doc
  end
  
end
