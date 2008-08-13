require 'salva_controller_test'
require 'course_controller'

class CourseController; def rescue_action(e) raise e end; end

class  CourseControllerTest < SalvaControllerTest
   fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,  :coursedurations, :modalities, :courses

  def initialize(*args)
   super
   @mycontroller =  CourseController.new
    @myfixtures = { :name => 'Matematicas_test', :startyear => 2007, :modality_id => 1, :country_id => 484, :courseduration_id => 1, :institution_id =>1 }
   @mybadfixtures = {  :name => nil, :startyear => nil, :modality_id => nil, :country_id => nil, :courseduration_id => nil }
   @model = Course
   @quickposts = [ 'coursegroup' ]
  end
end
