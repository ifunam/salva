class BookController < SalvaController
  def initialize
    @model = Book
    @per_pages = 10
    @order_by = 'title DESC'
  end
end
