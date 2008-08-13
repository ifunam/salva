require 'salva_controller_test'
require 'professor_advice_controller'

class ProfessorAdviceController; def rescue_action(e) raise e end; end

class  ProfessorAdviceControllerTest < SalvaControllerTest
   fixtures :indivadvicetargets, :indivadvices

  def initialize(*args)
   super
   @mycontroller =  ProfessorAdviceController.new
   @myfixtures = { :startyear => 2006, :indivname => 'Miguel_test', :hours => 400, :user_id => 3, :indivadvicetarget_id => 1 }
   @mybadfixtures = {  :startyear => nil, :indivname => nil, :hours => nil, :user_id => nil, :indivadvicetarget_id => nil }
   @model = Indivadvice
   @quickposts = [ 'institution' ]
  end
end
