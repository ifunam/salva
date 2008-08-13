require 'salva_controller_test'
require 'projectbook_controller'

class ProjectbookController; def rescue_action(e) raise e end; end

class  ProjectbookControllerTest < SalvaControllerTest
  fixtures :countries, :booktypes, :books, :projecttypes,:projectstatuses,:projects, :projectbooks


  def initialize(*args)
   super
   @mycontroller =  ProjectbookController.new
   @myfixtures = {  :project_id => 1, :book_id => 1}
   @mybadfixtures = {:project_id => 2, :book_id =>nil   }
   @model = Projectbook
   @quickposts = ['book']
  end
end
