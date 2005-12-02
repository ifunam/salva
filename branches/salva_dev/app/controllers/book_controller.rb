class BookController < SalvaController

  def initialize
    super
    @model = Book
    @sequence = [ Book, Bookedition, UserBookedition ]
  end
  
  def per_pages
    10
  end
  
  def order_by
    'title DESC'
  end

end
