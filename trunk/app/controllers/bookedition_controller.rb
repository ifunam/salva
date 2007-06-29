class BookeditionController < SalvaController

  def initialize
    super
    @model = Bookedition
    @per_pages = 10
    # @children = { 'chapterinbook' => %w(title pages) }
  end

end
