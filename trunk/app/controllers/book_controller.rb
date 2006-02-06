class BookController < SalvaController

  def initialize
    super
    @model = Book
    @sequence = [ Book, Bookedition, BookeditionRoleinbook ]
    @per_pages = 10
    @order_by = 'title DESC'
  end


end
