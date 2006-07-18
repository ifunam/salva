module TableHelper

  def table_list(collection, options = {} )
    header = options[:header] 
    list = list_collection(collection, options[:columns])
    render(:partial => '/salva/list', 
           :locals => { :header => header, :list => list })
  end
  
  def list_collection(collection, columns)
    list = []
    collection.each { |row|
      cell_content = cell_content(row, columns).join(', ').to_s+'.'
      list.push([cell_content, row.id])
    }
    list
  end
  
  def cell_content(row, columns)
    cell = []
    if columns.is_a?Array then
      cell = attr_content(row, columns)
    else
      row.attributes().each { |key, value| 
        cell << value if key != 'id' and value != nil 
      } 
    end
    return cell
  end
  
  def attr_content(row, columns)
    cell = []
    columns.each { |attr| 
      if row.send(attr) != nil then
        if is_id?(attr) then
          cell << attr_complex(row, attr)
        else
          cell << attr_simple(row, attr)
        end
      end
    } 
    return cell
  end
  
  def attr_simple(row, attr)
    return false unless row.send(attr) 
    if row.column_for_attribute(attr).type.to_s == 'boolean' then
      return setbool_tag(attr,row.send(attr))
    else
      return row.send(attr) 
    end
  end

  def attr_complex(row, attr)
    if attr.to_s == 'parent_id' and row.public_methods.include? 'ancestors'
      return attr_tree_path(row, 'name')
    else 
      (model, field) = set_belongs_to(attr)
      associated_model = reflect_on_association_model(row,attr,model)
      if associated_model != nil 
        return associated_attr(row,model,associated_model,field)
      elsif row.send(model).has_attribute?(field)
        return row.send(model).send(field) 
      else 
        attributes = get_row_attr(row,model)
        return attr_content( row.send(model), attributes).join(', ')
      end
    end
  end
  
  def attr_tree_path(row, attr)
    cell = []
    row.ancestors.reverse.each { | parent |
      cell << parent.send(attr)
    }
    return cell
  end
  
  def reflect_on_association_model(row,attr,model)
    myclass = row.class.name
    return myclass.constantize.reflect_on_association(model.to_sym).options[:include]
  end
  
  def associated_attr(row,model,associated_model,field)
    if row.send(model).send(associated_model).has_attribute?(field)
      return row.send(model).send(associated_model).send(field) 
    end
  end
  
  def get_row_attr(row,model)
    attributes = []
    row.send(model).attribute_names().each { |name|
      s = StringScanner.new(name)
      s.match?(/\w+_id/)
      attributes << name if s.matched?
    }
    return attributes
  end
  
  def is_id?(name)
    if name =~/_id$/ then
      true
    end
  end
  
  def set_belongs_to(attr)
    belongs_to = [ attr.sub(/_id$/,''), 'name' ]
    case attr
    when /citizen_/
      belongs_to[1] = 'citizen'
    end
    belongs_to
  end
  
  def setbool_tag(attr,condition)
    case attr
    when /gender/
      condition ? 'Masculino' : 'Femenino' 
    when /has_group_right/
      condition ? 'Con privilegios de grupo' : 'Sin privilegios'
    else
      condition ? 'Sí' : 'No'
    end
  end  
  
  #   def group_list(collection, options)
  #     columns = options[:columns]
  #     group = options[:group]
#     ungroup = columns - group
#     grouped = Hash.new
    
#     collection.each { |row|
#       a = []
#       group.each { |attr|
#         (model, field) = set_belongs_to(attr)        
#         a << row.send(model).send(field)
#       }      
#       key = a.join('_')      
#       if grouped[key] == nil then
#          grouped[key] = []
#       end
#       ungroup.each { |attr|
#         (model, field) = set_belongs_to(attr)        
#         grouped[key] << row.send(model).send(field)

#       }
#     }    

#     grouped.each { |key, content|
#       cell_content = key + content.join(' ')
#       list.push([cell_content, row.id])
#     }
#     list
#   end

  def table_show(collection, options = {})
    default_hidden = %w(id dbtime moduser_id user_id created_on updated_on) 
    hidden = options[:hidden]    
    hidden = [ hidden ] unless hidden.is_a?Array
    hidden.each { |attr| default_hidden << attr } if hidden != nil
    
    body = []
    collection.each { |column| 
      attr = column.name
      if !default_hidden.include?(attr) then
        if is_id?(attr) then
          (model, field) = set_belongs_to(attr)
          body << [ attr, @edit.send(model).send(field) ] unless
            @edit.send(model) == nil 
        else
          next if @edit.send(attr) == nil
          if @edit.column_for_attribute(attr).type.to_s == 'boolean' then
            body << [ attr, setbool_tag(attr,@edit.send(attr))] 
          else
            body << [ attr, @edit.send(attr) ] 
          end
        end
      end
    }
    render(:partial => '/salva/show', :locals => { :body => body})
  end
end
