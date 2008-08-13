require 'salva_controller_test'
require 'instadvicetarget_controller'

class InstadvicetargetController; def rescue_action(e) raise e end; end

class  InstadvicetargetControllerTest < SalvaControllerTest
   fixtures :instadvicetargets

  def initialize(*args)
   super
   @mycontroller =  InstadvicetargetController.new
   @myfixtures = { :name => 'Material didáctico_test' }
   @mybadfixtures = {  :name => nil }
   @model = Instadvicetarget
  end
end
