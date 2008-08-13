require 'salva_controller_test'
require 'proceeding_controller'

class ProceedingController; def rescue_action(e) raise e end; end

class  ProceedingControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings

  def initialize(*args)
   super
   @mycontroller =  ProceedingController.new
   @myfixtures = { :conference_id => 1, :title => 'Characterización of position-sensitive photomultiplier tubesfor microPET, detection moduless_tesr', :isrefereed => false
}
   @mybadfixtures = { :conference_id => nil, :title => nil, :isrefereed => false  }
   @model = Proceeding
    @quickposts = ['conference','publisher']
  end
end
