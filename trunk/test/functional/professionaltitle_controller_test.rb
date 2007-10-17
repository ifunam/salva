require 'salva_controller_test'
require 'professionaltitle_controller'

class ProfessionaltitleController; def rescue_action(e) raise e end; end

class  ProfessionaltitleControllerTest < SalvaControllerTest
   fixtures   :countries, :states, :cities, :institutiontitles,:institutiontypes, :degrees, :careers, :institutions, :schoolarships, :careers, :institutioncareers, :schoolings, :titlemodalities, :professionaltitles

  def initialize(*args)
   super
   @mycontroller =  ProfessionaltitleController.new
   @myfixtures = { :schooling_id => 1, :titlemodality_id => 1 }
   @mybadfixtures = {  :schooling_id => nil, :titlemodality_id => nil }
   @model = Professionaltitle
  end
end
