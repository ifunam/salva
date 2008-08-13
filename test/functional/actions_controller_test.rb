require 'salva_controller_test'
require 'actions_controller'

class ActionsController; def rescue_action(e) raise e end; end

class  ActionsControllerTest < SalvaControllerTest
 fixtures :actions

  def initialize(*args)
   super
   @mycontroller =  ActionsController.new
   @myfixtures = {:name => 'news'}
   @mybadfixtures = { :name => nil  }
   @model = Action
  end
end
