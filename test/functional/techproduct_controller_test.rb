require 'salva_controller_test'
require 'techproduct_controller'

class TechproductController; def rescue_action(e) raise e end; end

class  TechproductControllerTest < SalvaControllerTest
   fixtures :degrees, :careers, :techproducttypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :institutioncareers, :techproductstatuses, :techproducts

  def initialize(*args)
   super
   @mycontroller =  TechproductController.new
   @myfixtures = { :techproducttype_id => 2, :descr => 'Estudia la síntesis y caracterización de partículas esféricas con el fin de construir cristales fotécnicos._test', :title => 'Van Gogh had turbulence down to a fine art_test', :institution_id => 5588, :techproductstatus_id => 1, :authors => 'José Luis Aragón_test' }
   @mybadfixtures = {  :techproducttype_id => nil, :descr => nil, :title => nil, :institution_id => nil, :techproductstatus_id => nil, :authors => nil, :other => nil }
   @model = Techproduct
   @quickposts = [ 'techproducttype' ]
  end
end
