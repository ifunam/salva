class BookController < SalvaController
  skip_before_filter :rbac_required
  def initialize
    super
    @model = Book
    @sequence = [ Book, Bookedition, [BookeditionRoleinbook, BookeditionComment]]
    @per_pages = 10
    @order_by = 'title DESC'
  end
end
