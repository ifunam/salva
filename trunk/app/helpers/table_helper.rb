require 'list_helper'
module TableHelper
  include ListHelper
  def table_list(collection, options = {} )
    header = options[:header] 
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/list', 
           :locals => { :header => header, :list => list })
  end

  def table_array(collection, options = {} )
    header = options[:header] 
    list = list_collection_array(collection, options[:columns])
    render(:partial => '/salva/list', 
           :locals => { :header => header, :list => list })
  end

  def table_simple_list(collection, options = {} )
    controller = options[:controller] 
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/simple_list', :locals => { :header => options[:header], :list => list, :controller => controller})
  end
  
  # ...
  def table_show(row, options = {})
    hidden = hidden_attributes(options[:hidden])
    body = []
    row.each { |column| 
      attribute = column.name
      next if @edit.send(attribute) == nil or hidden.include?(attribute)
      if is_id?(attribute) then
        body << [ attribute, attributeid_to_text(@edit, attribute)]
      else
        body << [ attribute, attribute_to_text(@edit, attribute)]
      end
      
    }
    render(:partial => '/salva/show', 
           :locals => { :body => body })
  end
  
  def hidden_attributes(attrs=nil)
    default = %w(id dbtime moduser_id user_id created_on updated_on moduser) 
    attrs = [ attrs ] unless attrs.is_a?Array
    attrs.each { |attr| default << attr } if attrs != nil
    return default
  end
end
