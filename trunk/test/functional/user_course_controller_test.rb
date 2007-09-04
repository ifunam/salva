require 'salva_controller_test'
require 'user_course_controller'

class UserCourseController; def rescue_action(e) raise e end; end

class  UserCourseControllerTest < SalvaControllerTest
  fixtures :userstatuses, :users, :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,  :coursedurations, :modalities, :courses, :roleincourses, :user_courses

  def initialize(*args)
   super
   @mycontroller =  UserCourseController.new
   @myfixtures = {:user_id => 1, :course_id => 1, :roleincourse_id => 1}
   @mybadfixtures = { :user_id => 1, :course_id => nil, :roleincourse_id => nil  }
   @model = UserCourse
   @quickposts = ['course']
  end
end
