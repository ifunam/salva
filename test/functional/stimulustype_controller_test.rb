require 'salva_controller_test'
require 'stimulustype_controller'

class StimulustypeController; def rescue_action(e) raise e end; end

class  StimulustypeControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :stimulustypes

  def initialize(*args)
   super
   @mycontroller =  StimulustypeController.new
   @myfixtures = { :name => 'PRIDE_test', :descr => 'Programa de Reconocimiento a la Investigación y Desarrollo Académico_test', :institution_id => 1 }
   @mybadfixtures = {  :name => nil, :descr => nil, :institution_id => nil }
   @model = Stimulustype
  end
end
