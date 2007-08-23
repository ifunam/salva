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

  # ...
  def table_show(row, options = {})
    hidden = hidden_attributes(options[:hidden])
    body = []
    row.each { |column|
      attribute = column.name
      next if @edit.send(attribute) == nil or hidden.include?(attribute)
      text = attribute
      if is_id?(attribute) then
        model = get_model_from_idattribute(attribute)
        if @edit.class.reflect_on_association(model.to_sym) and (Inflector.camelize(model).constantize.column_names - %w(id name moduser_id created_on updated_on)).size > 0   and !%w(state country city).include?(model)
          logger.info  "Columnas "+(Inflector.camelize(model).constantize.column_names - %w(id name moduser_id created_on updated_on )).flatten.to_s
          if @edit.class.reflect_on_association(model.to_sym).macro.to_s == 'belongs_to'
            text =  link_to(attributeid_to_text(@edit, attribute), :controller => model, :action => 'show', :id => @edit.send(attribute))
          end
        else
          text = attributeid_to_text(@edit, attribute)
        end
      else
        text = attribute_to_text(@edit, attribute)
      end
      body << [ attribute, text ]
    }
    render(:partial => '/salva/show',  :locals => { :body => body })
  end

  def hidden_attributes(attrs=nil)
    default = %w(id dbtime moduser_id user_id created_on updated_on moduser)
    attrs = [ attrs ] unless attrs.is_a?Array
    attrs.each { |attr| default << attr } if attrs != nil
    return default
  end
end
