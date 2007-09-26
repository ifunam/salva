require 'salva_controller_test'
require 'courseduration_controller'

class CoursedurationController; def rescue_action(e) raise e end; end

class  CoursedurationControllerTest < SalvaControllerTest
   fixtures :coursedurations

  def initialize(*args)
   super
   @mycontroller =  CoursedurationController.new
   @myfixtures = { :name => 'Semanal_test', :days => 5 }
   @mybadfixtures = {  :name => nil, :days => nil }
   @model = Courseduration
  end
end
