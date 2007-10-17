require 'salva_controller_test'
require 'volume_controller'

class VolumeController; def rescue_action(e) raise e end; end

class  VolumeControllerTest < SalvaControllerTest
   fixtures :volumes

  def initialize(*args)
   super
   @mycontroller =  VolumeController.new
   @myfixtures = { :name => 'II_test' }
   @mybadfixtures = {  :name => nil }
   @model = Volume
  end
end
