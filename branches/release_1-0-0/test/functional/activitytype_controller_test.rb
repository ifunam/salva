require 'salva_controller_test'
require 'activitytype_controller'

class ActivitytypeController; def rescue_action(e) raise e end; end

class  ActivitytypeControllerTest < SalvaControllerTest
   fixtures :activitygroups, :activitytypes

  def initialize(*args)
   super
   @mycontroller =  ActivitytypeController.new
   @myfixtures = { :name => 'Reportajes_test', :activitygroup_id => 1 }
   @mybadfixtures = {  :name => nil, :activitygroup_id => nil }
   @model = Activitytype
  end
end
