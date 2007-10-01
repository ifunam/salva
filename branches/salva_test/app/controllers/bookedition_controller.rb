class BookeditionController < SalvaController

  def initialize
    super
    @model = Bookedition
    @per_pages = 10
    @children = { 
    	      'chapterinbook' => %w(title pages),
	      'bookedition_publisher' => %w(publisher_id), 
	      'bookedition_comment' => %w(comment)
	      }
  end

end
