require 'salva_controller_test'
require 'teaching_activity_controller'

class TeachingActivityController; def rescue_action(e) raise e end; end

class  TeachingActivityControllerTest < SalvaControllerTest
   fixtures :activitygroups, :activitytypes, :activities

  def initialize(*args)
   super
   @mycontroller =  TeachingActivityController.new
   @myfixtures = { :month => 4, :name => 'Conferencias_test', :activitytype_id => 2, :year => 1984, :user_id => 1 }
   @mybadfixtures = {  :month => nil, :name => nil, :activitytype_id => nil, :year => nil, :user_id => nil }
   @model = Activity
   @quickposts = [ 'activitytype' ]
  end
end
