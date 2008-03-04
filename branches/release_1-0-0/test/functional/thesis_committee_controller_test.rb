require 'salva_controller_test'
require 'thesis_committee_controller'

class ThesisCommitteeController; def rescue_action(e) raise e end; end

class  ThesisCommitteeControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  ThesisCommitteeController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = UserThesis
  end
end
