require 'salva_controller_test'
require 'proceeding_refereed_controller'

class ProceedingRefereedController; def rescue_action(e) raise e end; end

class  ProceedingRefereedControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings

  def initialize(*args)
   super
   @mycontroller =  ProceedingRefereedController.new
   @myfixtures = { :title => 'Coloquio de Artes Manuales y otras habilidades_test', :isrefereed => 'false_test', :conference_id => 2 }
   @mybadfixtures = {  :title => nil, :isrefereed => nil, :conference_id => nil }
   @model = Proceeding
   @quickposts = [ 'conference' ]
  end
end
