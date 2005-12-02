
class BookeditionController < SalvaController

  def initialize
    super
    @model = Bookedition
    @sequence = [ Bookedition, UserBookedition ]
  end
  
  def per_pages
    10
  end
  
  def order_by
#    'title DESC'
  end

end
