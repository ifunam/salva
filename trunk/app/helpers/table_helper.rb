require 'list_helper'
module TableHelper
  include ListHelper
  def table_list(collection, options = {} )
    header = options[:header] 
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/list', 
           :locals => { :header => header, :list => list })
  end
  
  # ...
  def table_show(row, options = {})
    hidden = hidden_attributes(options[:hidden])
    body = []
    row.each { |column| 
      attr = column.name
      next if @edit.send(attr) == nil or hidden.include?(attr)
      if is_id?(attr) then
        body << [ attr, attributeid_totext(@edit, attr)]
      else
        body << [ attr, attribute_totext(@edit, attr)]
      end
      
    }
    render(:partial => '/salva/show', 
           :locals => { :body => sorted_list(body,1)})
  end
  
  def hidden_attributes(attrs=nil)
    default = %w(id dbtime moduser_id user_id created_on updated_on) 
    attrs = [ attrs ] unless attrs.is_a?Array
    attrs.each { |attr| default << attr } if attrs != nil
    return default
  end
end
