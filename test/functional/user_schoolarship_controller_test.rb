require 'salva_controller_test'
require 'user_schoolarship_controller'

class UserSchoolarshipController; def rescue_action(e) raise e end; end

class  UserSchoolarshipControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes, :institutions, :schoolarships, :user_schoolarships

  def initialize(*args)
   super
   @mycontroller =  UserSchoolarshipController.new
   @myfixtures = { :startyear => 2006, :schoolarship_id => 3, :user_id => 3 }
   @mybadfixtures = {  :startyear => nil, :schoolarship_id => nil, :user_id => nil }
   @model = UserSchoolarship
   @quickposts = [ 'schoolarship' ]
  end
end
