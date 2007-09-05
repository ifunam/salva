require 'salva_controller_test'
require 'user_regularcourse_controller'

class UserRegularcourseController; def rescue_action(e) raise e end; end

class  UserRegularcourseControllerTest < SalvaControllerTest
  fixtures :userstatuses, :users, :modalities, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :academicprogramtypes,  :academicprograms, :regularcourses, :roleinregularcourses, :periods, :user_regularcourses

  def initialize(*args)
   super
   @mycontroller =  UserRegularcourseController.new
   @myfixtures = {  :user_id => 2, :regularcourse_id => 1, :period_id => 2, :roleinregularcourse_id => 1}
   @mybadfixtures = {   :user_id => 2, :regularcourse_id => nil, :period_id => nil, :roleinregularcourse_id => 1 }
   @model = UserRegularcourse
   @quickposts = ['regularcourse', 'period', 'academicprogram']
  end
end
