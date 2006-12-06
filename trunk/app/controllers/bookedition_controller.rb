
class BookeditionController < SalvaController

  def initialize
    super
    @model = Bookedition
    @parent = 'book'
    @children = { 'chapterinbook' => %w(title pages) }
  end
  
end
