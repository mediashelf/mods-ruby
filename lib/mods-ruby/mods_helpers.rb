module ModsRuby
module ModsHelpers
  
  def self.name_ text, opts={}
    opts = {:type=>"personal"}.merge opts
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.name(:type=>opts[:type]) {
        xml.namePart text
        if opts[:date] 
          xml.namePart(opts[:date], :type=>"date")  
        end
        
        # Adds role, accepting either :role=>"value" or :role=>{:value=>"value", :opt1=>"opt"}
        if opts[:role] 
          if opts[:role].kind_of? Hash
            self.role(opts[:role].delete(:value), opts[:role], xml.parent)
          else
            self.role(opts[:role], {}, xml.parent)
          end
        end
        
      }
    end
    return builder.doc
  end
  
  def self.role text, opts={}, root_node=nil
    opts = {:type=>"text"}.merge! opts
    if root_node
      builder = Nokogiri::XML::Builder.with(root_node) do |xml|
        xml.role {
          xml.roleTerm(text, opts) 
        }
      end
    else
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.role {
          xml.roleTerm(text, opts) 
        }
      end
    end
  end
  
end
end