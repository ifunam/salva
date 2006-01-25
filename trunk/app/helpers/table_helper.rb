
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
              belongs_to =  attr.sub!(/_id$/,'')
              body += item.send(belongs_to).name.to_s+', '
 #             belongs_to = get_belongs_to(attr)
 #             body += item.send(belongs_to['model']).send(belongs_to['attr'])
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

  def get_belongs_to(attr)
    belongs_to = { 'model' => attr.sub!(/_id$/,'') }
    if belongs_to['model'] =~ /citizen/ then
        belongs_to['attr'] = 'citizen'
    else 
      belongs_to['attr'] = 'name'
    end
  end
end
