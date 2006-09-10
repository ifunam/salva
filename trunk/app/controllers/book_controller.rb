class BookController < SalvaController
  def initialize
    @model = Book
    @sequence = [ Book, Bookedition, [BookeditionRoleinbook, BookeditionComment]]
    @per_pages = 10
    @order_by = 'title DESC'
  end
end
