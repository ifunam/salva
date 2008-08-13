require 'salva_controller_test'
require 'activity_controller'

class ActivityController; def rescue_action(e) raise e end; end

class  ActivityControllerTest < SalvaControllerTest
   fixtures :activitygroups, :activitytypes, :activities

  def initialize(*args)
   super
   @mycontroller =  ActivityController.new
   @myfixtures = { :name => 'Conferencias_test', :month => 4, :activitytype_id => 2, :year => 1984, :user_id => 1 }
   @mybadfixtures = {  :name => nil, :month => nil, :activitytype_id => nil, :year => nil, :user_id => nil }
   @model = Activity
  end
end
