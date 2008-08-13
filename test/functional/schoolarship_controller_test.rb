require 'salva_controller_test'
require 'schoolarship_controller'

class SchoolarshipController; def rescue_action(e) raise e end; end

class  SchoolarshipControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes, :institutions, :schoolarships

  def initialize(*args)
   super
   @mycontroller =  SchoolarshipController.new
   @myfixtures = { :name => 'Dirección General de Asuntos del Personal Académico_test', :institution_id => 1 }
   @mybadfixtures = {  :name => nil, :institution_id => nil }
   @model = Schoolarship
   @quickposts = [ 'institution' ]
  end
end
