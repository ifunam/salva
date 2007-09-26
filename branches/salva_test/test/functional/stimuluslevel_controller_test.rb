require 'salva_controller_test'
require 'stimuluslevel_controller'

class StimuluslevelController; def rescue_action(e) raise e end; end

class  StimuluslevelControllerTest < SalvaControllerTest
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :stimulustypes, :stimuluslevels

  def initialize(*args)
   super
   @mycontroller =  StimuluslevelController.new
   @myfixtures = { :name => 'A_test', :stimulustype_id => 1 }
   @mybadfixtures = {  :name => nil, :stimulustype_id => nil }
   @model = Stimuluslevel
   @quickposts = [ 'stimulustype' ]
  end
end
