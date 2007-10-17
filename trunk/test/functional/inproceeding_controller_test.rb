require 'salva_controller_test'
require 'inproceeding_controller'

class InproceedingController; def rescue_action(e) raise e end; end

class  InproceedingControllerTest < SalvaControllerTest
   fixtures :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings

  def initialize(*args)
   super
   @mycontroller =  InproceedingController.new
   @myfixtures = { :title => 'Recent developments in linear stochastic electrodynamics, Quantum Theory: Reconsideration of Foundations-3_test', :authors => 'De la pña L, Cetto A_test', :proceeding_id => 2 }
   @mybadfixtures = {  :title => nil, :authors => nil, :proceeding_id => nil }
   @model = Inproceeding
   @quickposts = [ 'proceeding' ]
  end
end
