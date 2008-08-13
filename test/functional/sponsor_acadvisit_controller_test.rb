require 'salva_controller_test'
require 'sponsor_acadvisit_controller'

class SponsorAcadvisitController; def rescue_action(e) raise e end; end

class  SponsorAcadvisitControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :degrees, :careers, :institutioncareers,  :acadvisittypes, :acadvisits, :sponsor_acadvisits

  def initialize(*args)
   super
   @mycontroller =  SponsorAcadvisitController.new
   @myfixtures = { :amount => 180000, :institution_id => 57, :acadvisit_id => 2 }
   @mybadfixtures = {  :amount => nil, :institution_id => nil, :acadvisit_id => nil }
   @model = SponsorAcadvisit
  end
end
