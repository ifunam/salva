class BookController < SalvaController
  helper :table

  def initialize
    super
    @model = Book
    @sequence = [ Bookedition ]
  end
  
  def per_pages
    10
  end
  
  def order_by
    'title DESC'
  end

end
