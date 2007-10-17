require 'salva_controller_test'
require 'coursegroup_controller'

class CoursegroupController; def rescue_action(e) raise e end; end

class  CoursegroupControllerTest < SalvaControllerTest
   fixtures :coursegrouptypes,:coursegroups

  def initialize(*args)
   super
   @mycontroller =  CoursegroupController.new
   @myfixtures = { :name => 'Lentos_test', :startyear => 2007, :coursegrouptype_id => 1 }
   @mybadfixtures = {  :name => nil, :startyear => nil, :coursegrouptype_id => nil }
   @model = Coursegroup
   @quickposts = [ 'coursegrouptype' ]
  end
end
