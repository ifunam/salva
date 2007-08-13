require 'salva_controller_test'
require 'booktype_controller'

class BooktypeController; def rescue_action(e) raise e end; end

class  BooktypeControllerTest < SalvaControllerTest
   fixtures :booktypes

  def initialize(*args)
   super
   @mycontroller =  BooktypeController.new
   @myfixtures = { :name => 'Arbitrado_test' }
   @mybadfixtures = {  :name => nil }
   @model = Booktype
   @quickposts = []
  end
end
