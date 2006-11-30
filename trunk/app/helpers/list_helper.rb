module ListHelper
  def list_collection(collection, columns)
    list = []
    collection.each { |row|
      text = columns_content(row, columns).join(', ').to_s+'.'
      id = row.attributes_before_type_cast['id'] =~ /:/ ?  row.attributes_before_type_cast['id'] : row.id
      list.push([text, id])
    }
    return sorted_list(list)
  end
  
  def list_collection_array(collection, columns)
    list = []
    collection.each { |row|
      text = columns_content_array(row, columns).join(', ').to_s+'.'
      id = row.attributes_before_type_cast['id'] =~ /:/ ?  row.attributes_before_type_cast['id'] : row.id
      list.push([text, id])
    }
    return sorted_list(list)
  end

  def list_collection_text(collection, columns)
    list = []
    collection.each { |row|
      text = columns_content(row, columns).join(', ').to_s
      list << text
    }
    list
  end
  
  def sorted_find(model, attr='name', order='ASC')
    sorted_list(model.find(:all, :order => attr + ' ' + order).collect! { |p| 
                  [ p.send(attr), p.id ] if p.send(attr) != nil
                })
  end
  
  def list_from_collection(list)
    sorted_list(list.collect! { |p| [ p.name, p.id ] if p.name != nil })
  end
  
  def sorted_list(list,i=0)
    list.sort {|a, b| 
      latin1_to_utf8(a[i]).downcase <=> latin1_to_utf8(b[i]).downcase 
    }
  end
  
  def latin1_to_utf8(str)
    str.to_s.tr('·ÈÌÛ˙¡…Õ”⁄Ò—','aeiouAEIOUnN')
  end
  
  def columns_content(row, columns)
#    s = []
    if columns.is_a?Array or columns.is_a?Hash then
      s = columns_to_text(row, columns)
#    else
#      row.attributes().each { |key, value| 
#        s << value if key != 'id' and value != nil 
#      } 
    end
    return s
  end
  

  def columns_content_array(row, columns)
    if columns.is_a?Array or columns.is_a?Hash then
      s = columns_to_text_array(row, columns)
    end
    return s
  end

  def columns_to_text(row, columns)
    s = []
    if (columns.is_a? Array)
      columns.each { |attr| 
        next if row.send(attr) == nil 
        if is_id?(attr) then
          s << attributeid_to_text(row, attr)
        else
          s << attribute_to_text(row, attr)
       end
      }
    elsif (columns.is_a? Hash)
      columns.keys.each { |key| 
  #      next if row.send(key) == nil 
        model = key.sub(/_id$/,'')
        collection = [Inflector.camelize(model).constantize.find(row.send(key))]
        s << list_collection_text(collection, columns[key])
      } 
    end

    return s
  end
  
  def columns_to_text_array(row, columns)
    s = []
    if (columns.is_a? Array)
      columns.each { |attr|
        if attr.is_a? Array then
          prev = attr[0]
          model = prev.sub(/_id$/,'')
          id = row.send(prev)
          row2 = Inflector.camelize(model).constantize.find(id)
          s << columns_to_text_array(row2, attr[1..-1])
        else
          next if row.send(attr) == nil 
          if is_id?(attr) then
            s << attributeid_to_text(row, attr)
          else
            s << attribute_to_text(row, attr)
          end
        end
      }
      return s
    else
      nil
    end
  end
  
  def attribute_to_text(row, attr)
    if row.column_for_attribute(attr).type.to_s == 'boolean' then
      return get_boolean_tag(attr,row.send(attr))
    else
      return row.send(attr)
    end
  end
  
  def attributeid_to_text(row, attr)
    (model, field) = get_modelname(attr)
    if has_ancestors?(row,attr)
      return attribute_tree_path(row, field)
    elsif row.attributes_before_type_cast[attr].is_a? Array
      return ids_to_name(model, row.attributes_before_type_cast[attr])
    elsif has_associated_model?(row,attr,model) 
      return get_associated_attributes(row,attr,model,field)
    elsif row.send(model).has_attribute?(field)
      return row.send(model).send(field) 
    else 
      return columns_content(row.send(model), get_attributes(row.send(model))).join(', ')
    end
  end
  
  def has_ancestors?(row, attr)
    return true if attr.to_s == 'parent_id' and \
    row.public_methods.include? 'ancestors'
    return false
  end

  def attribute_tree_path(row, attr)
    s = []
    row.ancestors.reverse.each { | parent | s << parent.send(attr) }
    return s.join(',')
  end  
  
  def is_attribute_array?(row, attr)
    s = StringScanner.new(row.attributes_before_type_cast[attr])
    return true if s.match?(/^\{([0-9]+,*)+\}$/) != nil
    return false
  end
  
  def get_ids_fromarray(row, attr)
    return row.attributes_before_type_cast[attr].delete('{}').split(',') if row.send(attr) != nil
  end
  
  def ids_to_name(model, ids)
    s = []
    ids.each { |id| 
      row = Inflector.camelize(model).constantize.find(id)
      s << '['+columns_content(row, get_attributes(row)).join(', ')+']'
    }
    s.join(',')
  end
  
  def has_associated_model?(row,attr,model)
#   klass = row.class.name
#   return true if klass.constantize.reflect_on_association(model.to_sym).options[:include]
    return false
  end

  def get_associated_attributes(row,attr,model,field)
    klass = row.class.name
    amodel = klass.constantize.reflect_on_association(model.to_sym).options[:include]
    if row.send(model).send(amodel).has_attribute?(field)
      return row.send(model).send(amodel).send(field) 
    end
  end
  
  def get_attributes(row)
    attributes = []
    row.attribute_names().each { |name|
      next if %w(moduser_id created_on updated_on user_id).include? name 
      attributes << name if name =~/\w+_id$/ or name.to_s == 'name'
    }
    return attributes
  end
  
  def is_id?(name)
    if name =~/_id$/ then
      true
    end
  end
  
  def get_modelname(attr)
    belongs_to = [ attr.sub(/_id$/,''), 'name' ]
    case attr
    when /citizen_/
      belongs_to[1] = 'citizen'
    when /user_/
      belongs_to[1] = 'login'
    when /book_/
      belongs_to[1] = 'title'
    end
    belongs_to
  end
  
  def get_boolean_tag(attr,condition)
    case attr
    when /gender/
      condition == true ? 'Masculino' : 'Femenino' 
    when /is_studying_this/
      condition ? 'Grado en curso' : 'Grado terminado' 
    when /is_titleholder/
      condition ? 'Titulado' : 'Sin titulo' 
    when /has_group_right/
      condition ? 'Con privilegios de grupo' : 'Sin privilegios'
    when /ismainauthor/
      condition ? 'Autor principal' : 'Coautor'
    else
      condition ? 'SÌ' : 'No'
    end
  end  
end
