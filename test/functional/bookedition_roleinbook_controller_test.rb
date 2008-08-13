require 'salva_controller_test'
require 'bookedition_roleinbook_controller'

class BookeditionRoleinbookController; def rescue_action(e) raise e end; end

class  BookeditionRoleinbookControllerTest < SalvaControllerTest
   fixtures :countries, :booktypes, :books, :editions, :mediatypes, :editionstatuses, :bookeditions, :roleinbooks, :bookedition_roleinbooks

  def initialize(*args)
   super
   @mycontroller =  BookeditionRoleinbookController.new
   @myfixtures = { :roleinbook_id => 1, :bookedition_id => 1, :user_id => 1 }
   @mybadfixtures = {  :roleinbook_id => nil, :bookedition_id => nil, :user_id => nil }
   @model = BookeditionRoleinbook
   @quickposts = [ 'book' ]
  end
end
