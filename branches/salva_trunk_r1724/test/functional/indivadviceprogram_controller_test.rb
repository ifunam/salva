require 'salva_controller_test'
require 'indivadviceprogram_controller'

class IndivadviceprogramController; def rescue_action(e) raise e end; end

class  IndivadviceprogramControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :indivadviceprograms

  def initialize(*args)
   super
   @mycontroller =  IndivadviceprogramController.new
   @myfixtures = { :name => 'PIDI_test', :institution_id => 96 }
   @mybadfixtures = {  :name => nil, :institution_id => nil }
   @model = Indivadviceprogram
  end
end
