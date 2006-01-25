class BookController < SalvaController

  def initialize
    super
    @model = Book
    @sequence = [ Book, Bookedition, UserBookedition ]
    @per_pages = 10
    @order_by = 'title DESC'
  end


end
