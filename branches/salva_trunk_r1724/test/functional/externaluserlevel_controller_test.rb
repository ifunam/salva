require 'salva_controller_test'
require 'externaluserlevel_controller'

class ExternaluserlevelController; def rescue_action(e) raise e end; end

class  ExternaluserlevelControllerTest < SalvaControllerTest
fixtures :externaluserlevels

  def initialize(*args)
   super
   @mycontroller =  ExternaluserlevelController.new
   @myfixtures = {:name => 'Estudiante vecado'}
   @mybadfixtures = { :name => nil  }
   @model = Externaluserlevel
  end
end
