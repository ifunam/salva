require 'salva_controller_test'
require 'techactivity_controller'

class TechactivityController; def rescue_action(e) raise e end; end

class  TechactivityControllerTest < SalvaControllerTest
   fixtures :activitygroups, :activitytypes, :activities

  def initialize(*args)
   super
   @mycontroller =  TechactivityController.new
   @myfixtures = { :month => 4, :name => 'Conferencias_test', :activitytype_id => 2, :year => 1984, :user_id => 2 }
   @mybadfixtures = {  :month => nil, :name => nil, :activitytype_id => nil, :year => nil, :user_id => nil }
   @model = Activity
   @quickposts = [ 'activitytype:activitygroup_id' ]
  end
end
