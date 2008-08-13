require 'salva_controller_test'
require 'user_specialcourse_controller'

class UserSpecialcourseController; def rescue_action(e) raise e end; end

class  UserSpecialcourseControllerTest < SalvaControllerTest
   fixtures :roleincourses, :countries, :states, :cities, :modalities, :coursedurations, :courses, :user_courses

  def initialize(*args)
   super
   @mycontroller =  UserSpecialcourseController.new
   @myfixtures = { :user_id => 3, :roleincourse_id => 3, :course_id => 2 }
   @mybadfixtures = {  :user_id => nil, :roleincourse_id => nil, :course_id => nil }
   @model = UserCourse
   @quickposts = [ 'course' ]
  end
end
