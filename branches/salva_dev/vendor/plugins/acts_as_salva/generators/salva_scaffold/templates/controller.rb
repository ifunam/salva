class <%= controller_class_name %>Controller < SalvaController
  def initialize
    super
    @model = <%= class_name %>
  end

  def per_pages
    10
  end
  
  def order_by
    'title DESC'
  end

end
