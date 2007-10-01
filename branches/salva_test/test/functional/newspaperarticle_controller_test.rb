require 'salva_controller_test'
require 'newspaperarticle_controller'

class NewspaperarticleController; def rescue_action(e) raise e end; end

class  NewspaperarticleControllerTest < SalvaControllerTest
   fixtures :countries, :newspapers,  :newspaperarticles

  def initialize(*args)
   super
   @mycontroller =  NewspaperarticleController.new
   @myfixtures = { :newspaper_id => 2, :title => 'El viento solar causa tormentas geomagneticas en la ultima semana_test', :newsdate => '2004-08-03_test', :authors => 'Juan Jose Romero_test' }
   @mybadfixtures = {  :newspaper_id => nil, :title => nil, :newsdate => nil, :authors => nil }
   @model = Newspaperarticle
   @quickposts = [ 'newspaper' ]
  end
end
