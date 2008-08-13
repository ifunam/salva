require 'salva_controller_test'
require 'institutiontitle_controller'

class InstitutiontitleController; def rescue_action(e) raise e end; end

class  InstitutiontitleControllerTest < SalvaControllerTest
   fixtures :institutiontitles

  def initialize(*args)
   super
   @mycontroller =  InstitutiontitleController.new
   @myfixtures = { :name => 'Universidad_test' }
   @mybadfixtures = {  :name => nil }
   @model = Institutiontitle
  end
end
