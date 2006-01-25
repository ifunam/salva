
module TableHelper
  
  def table(collection, options = {} )
    options = options.stringify_keys
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
    render(:partial => "/salva/list")
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
end
