require 'salva_controller_test'
require 'thesis_controller'

class ThesisController; def rescue_action(e) raise e end; end

class  ThesisControllerTest < SalvaControllerTest
   fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :thesismodalities, :thesisstatuses, :theses

  def initialize(*args)
   super
   @mycontroller =  ThesisController.new
   @myfixtures = { :startyear => 2006, :title => 'Estudio de eventos transitorios economico-sociales en Mexico_test', :institutioncareer_id => 1, :thesisstatus_id => 2, :thesismodality_id => 1, :authors => 'Arturo Mendiolea_test' }
   @mybadfixtures = {  :startyear => nil, :title => nil, :institutioncareer_id => nil, :thesisstatus_id => nil, :thesismodality_id => nil, :authors => nil }
   @model = Thesis
   @quickposts = [ 'institutioncareer' ]
  end
end
