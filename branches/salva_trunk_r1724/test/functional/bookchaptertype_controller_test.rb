require 'salva_controller_test'
require 'bookchaptertype_controller'

class BookchaptertypeController; def rescue_action(e) raise e end; end

class  BookchaptertypeControllerTest < SalvaControllerTest
   fixtures :bookchaptertypes

  def initialize(*args)
   super
   @mycontroller =  BookchaptertypeController.new
   @myfixtures = { :name => 'Prefacio_test' }
   @mybadfixtures = {  :name => nil }
   @model = Bookchaptertype
  end
end
