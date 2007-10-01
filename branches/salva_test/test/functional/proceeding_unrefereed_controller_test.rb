require 'salva_controller_test'
require 'proceeding_unrefereed_controller'

class ProceedingUnrefereedController; def rescue_action(e) raise e end; end

class  ProceedingUnrefereedControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings

  def initialize(*args)
   super
   @mycontroller =  ProceedingUnrefereedController.new
   @myfixtures = { :title => 'Coloquio de Artes Manuales y otras habilidades_test', :isrefereed => 'false_test', :conference_id => 2 }
   @mybadfixtures = {  :title => nil, :isrefereed => nil, :conference_id => nil }
   @model = Proceeding
   @quickposts = [ 'conference' ]
  end
end
