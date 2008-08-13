require 'salva_controller_test'
require 'academicprogram_controller'

class AcademicprogramController; def rescue_action(e) raise e end; end

class  AcademicprogramControllerTest < SalvaControllerTest
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :academicprogramtypes, :academicprograms

  def initialize(*args)
   super
   @mycontroller =  AcademicprogramController.new
   @myfixtures = {  :institutioncareer_id => 2, :academicprogramtype_id => 2,  :year => 2007}
   @mybadfixtures = { :institutioncareer_id => nil, :academicprogramtype_id => 2,  :year =>nil  }
   @model = Academicprogram
   @quickposts = ['institutioncareer']
  end
end
