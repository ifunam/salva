require 'salva_controller_test'
require 'book_controller'

class BookController; def rescue_action(e) raise e end; end

class  BookControllerTest < SalvaControllerTest
   fixtures :countries, :booktypes, :books

  def initialize(*args)
   super
   @mycontroller =  BookController.new
   @myfixtures = { :title => 'Earthquakes Mexican Studies_test', :author => 'S. de la Cruz_test', :country_id => 484, :booktype_id => 2 }
   @mybadfixtures = {  :title => nil, :author => nil, :country_id => nil, :booktype_id => nil }
   @model = Book
   @quickposts = [ 'volume' ]
  end
end
