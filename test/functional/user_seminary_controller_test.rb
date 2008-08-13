require 'salva_controller_test'
require 'user_seminary_controller'

class UserSeminaryController; def rescue_action(e) raise e end; end

class  UserSeminaryControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :roleinseminaries, :seminaries, :user_seminaries

  def initialize(*args)
   super
   @mycontroller =  UserSeminaryController.new
   @myfixtures = { :seminary_id => 3, :roleinseminary_id => 1, :user_id => 1 }
   @mybadfixtures = {  :seminary_id => nil, :roleinseminary_id => nil, :user_id => nil }
   @model = UserSeminary
   @quickposts = [ 'seminary' ]
  end
end
