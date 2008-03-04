require 'list_helper'
module TableHelper
  include ListHelper
  def table_list(collection, options = {} )
    header = options[:header]
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/list',
           :locals => { :header => header, :list => list, :nolinks => options[:nolinks] })
  end

  def table_array(collection, options = {} )
    header = options[:header]
    list = list_collection_array(collection, options[:columns])
    render(:partial => '/salva/list',
           :locals => { :header => header, :list => list, :nolinks => options[:nolinks]  })
  end

  def table_simple_list(collection, options = {} )
    controller = options[:controller]
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/simple_list', :locals => { :header => options[:header], :list => list, :controller => controller})
  end

  def children_list(edit, children)
    s = ''
    children.each{ |child, columns|
      s += '<hr/>'
      s += table_simple_list(edit.send(child.pluralize), { :header => get_label(child), :columns => columns, :controller => child })
      s += link_to 'Agregar', :action => 'new', :controller => child, :id => edit.id
    }
    s
  end

  def table_show(record, hidden_opt=[])
    hidden_attributes  = default_hidden(hidden_opt)
    body = []
    (record.class.column_names - hidden_attributes).each do |attribute|
      next if !record.respond_to? attribute or record.send(attribute) == nil?
      if attribute =~/_id$/ and !record.send(attribute).nil? then
        model = modelize(attribute)
        if record.respond_to? model and (Inflector.camelize(model).constantize.column_names - (hidden_attributes << 'name')).size > 0 and !%w(state country city).include?(model)
          body << [attribute, link_to(attributeid_to_text(record, attribute), :controller => model, :action => 'show', :id => record.send(attribute))]
        else
          body << [ attribute, attributeid_to_text(record, attribute)]
        end
      else
        body << [attribute, attribute_to_text(record, attribute)]
      end
    end
    render(:partial => '/salva/table_show',  :locals => { :body => body })
  end

  def default_hidden(attributes=[])
    default = %w(id dbtime moduser_id user_id created_on updated_on moduser)
    default +=  attributes
  end

  def modelize(attribute)
    attribute.sub(/_id$/,'').sub(/^\w+_/,'')
  end
end
