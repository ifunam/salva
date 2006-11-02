
class BookeditionController < SalvaController

  def initialize
    super
    @model = Bookedition
#    @sequence = [ Book, Bookedition ]
  end
  
  def per_pages
    10
  end
  
  def order_by
#    'title DESC'
  end

end
