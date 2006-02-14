class BookController < SalvaController

  def initialize
    super
    @model = Book
    @sequence = [ Book, [Bookedition, BookeditionRoleinbook, BookeditionComment, 
        [Chapterinbook, ChapterinbookRoleinbook, ChapterinbookComment ]] ]
    @per_pages = 10
    @order_by = 'title DESC'
  end
end
