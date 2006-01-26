
module TableHelper
  
  def table_list(collection, options = {} )
    options = options.stringify_keys

    options['partial'] = '/salva/list' if options['partial'] == nil
    @header = options['header']
    @columns = options['columns']
    
    @list = []
    collection.each { |item|
      
      cell = []
      if @columns.is_a?Array then
        @columns.each { |attr| 
          if item.send(attr) != nil then
            if is_id?(attr) then
              belongs_to = set_belongs_to(attr)
              cell << item.send(belongs_to['model']).send(belongs_to['attr'])
            else
              cell << item.send(attr)
            end
          end
        } 
      else
        item.attributes().each { |key, value| cell << value if key != 'id' and value != nil } 
      end
      
      cell_content = cell.join(', ').to_s+'.'
      @list.push({'id' => item.id, 'cell_content' => cell_content })
      
    }
    render(:partial => options['partial'])
  end
  
  def table_show(collection, options = {})
    options = options.stringify_keys
    options['partial'] = '/salva/show' if options['partial'] == nil
    
    belongs_to = options['belongs_to']
    
    default_hidden = %w(dbtime moduser_id user_id) 
    hidden = options['hidden']    
    if hidden != nil then
      if hidden.is_a?Array then
        hidden.map { |attr| default_hidden << attr }
      else 
        default_hidden << hidden
      end
    end
    hidden_attr = default_hidden.join('|')
    
    body = []
    collection.each { |column| 
      attr = column.name
      if !attr.match(/#{hidden_attr}/) then 
        if is_id?(attr) then
          belongs_to = set_belongs_to(attr)
          body << [ attr.to_s+"_id", @edit.send(belongs_to['model']).send(belongs_to['attr']) ]
        else
          case attr 
          when 'sex' 
            body << [ attr, sex(@edit.send(column.name))]
          else
            body << [ attr, @edit.send(attr) ]
          end
        end
      end
    }
    @body = body 
    
    render(:partial => options['partial'])
  end
  
  def is_id?(name)
    if name =~/_id$/ then
      true
    end
  end
    
  def set_belongs_to(attr)
    belongs_to = { 'model' => attr.sub!(/_id$/,''), 'attr' => 'name' }
    case attr
    when /citizen/
      belongs_to['attr'] = 'citizen'
    end
    belongs_to
  end

  def sex(condition)
    condition ? 'Masculino' : 'Femenino'
  end
end
