
module TableHelper

  def table(collection, options = {} )
    options = options.stringify_keys
   
    @header = options["header"]
    @columns = options["columns"]
    @list = []
    collection.each { |item|
      body = ''
      if @columns.is_a?Array then
        @columns.each { |attr| body += item.send(attr).to_s+', ' if item.send(attr) != nil } 
      else
        item.attributes().each { |key, value| body << value.to_s+', ' if key != 'id' and value != nil } 
      end
      body.sub!(/, $/, '.')
      @list.push({'id' => item.id, 'body' => body })
    }
    render(:partial => "/salva/list")
  end
 
end
