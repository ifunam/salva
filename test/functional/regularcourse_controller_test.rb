require 'salva_controller_test'
require 'regularcourse_controller'

class RegularcourseController; def rescue_action(e) raise e end; end

class  RegularcourseControllerTest < SalvaControllerTest
  fixtures :modalities, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :academicprogramtypes,  :academicprograms, :regularcourses

  def initialize(*args)
   super
   @mycontroller =  RegularcourseController.new
   @myfixtures = {:title =>  'Fisica General' , :academicprogram_id => 2, :modality_id => 1}
   @mybadfixtures = {:title =>  nil , :academicprogram_id => 2, :modality_id => nil }
   @model = Regularcourse
   @quickposts = ['academicprogram']
  end
end
