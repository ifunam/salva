require 'salva_controller_test'
require 'user_techproduct_controller'

class UserTechproductController; def rescue_action(e) raise e end; end

class  UserTechproductControllerTest < SalvaControllerTest
   fixtures :degrees, :careers, :techproducttypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :institutioncareers, :users, :techproductstatuses, :techproducts, :user_techproducts

  def initialize(*args)
   super
   @mycontroller =  UserTechproductController.new
   @myfixtures = { :techproduct_id => 1, :year => 1996, :user_id => 2 }
   @mybadfixtures = {  :techproduct_id => nil, :year => nil, :user_id => nil }
   @model = UserTechproduct
   @quickposts = [ 'techproduct' ]
  end
end
