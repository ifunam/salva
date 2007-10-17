require 'salva_controller_test'
require 'institutioncareer_controller'

class InstitutioncareerController; def rescue_action(e) raise e end; end

class  InstitutioncareerControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers

  def initialize(*args)
   super
   @mycontroller =  InstitutioncareerController.new
   @myfixtures = { :career_id => 1, :institution_id => 1 }
   @mybadfixtures = {  :career_id => nil, :institution_id => nil }
   @model = Institutioncareer
   @quickposts = [ 'career:degree_id' ]
  end
end
