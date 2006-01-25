
module TableHelper

  def table(collection, options = {} )
    options = options.stringify_keys
   
    @header = options["header"]
    @columns = options["columns"]
    @list = []
    collection.each { |item|
      body = ''
      if @columns.is_a?Array then
        @columns.each { |attr| 
          if item.send(attr) != nil then
             if is_id?(attr) then
               body += unidname(attr, item.send(attr)).to_s+', '
             else
               body += item.send(attr).to_s+', ' 
             end
          end
        } 
      else
        item.attributes().each { |key, value| body << value.to_s+', ' if key != 'id' and value != nil } 
      end
      body.sub!(/, $/, '.')
      @list.push({'id' => item.id, 'body' => body })
    }
    render(:partial => "/salva/list")
  end

  def is_id?(name)
   if name =~/_id$/ then
     true
   end
  end
  
  def unidname(name, id)
    name.sub!(/_id$/,'')
    name.sub!(/^\w+_/,'')     
    model = Inflector.camelize(name)
    obj = model.constantize.find(id)
    obj['name']
  end
 
end
