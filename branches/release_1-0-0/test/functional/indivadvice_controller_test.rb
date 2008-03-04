require 'salva_controller_test'
require 'indivadvice_controller'

class IndivadviceController; def rescue_action(e) raise e end; end

class  IndivadviceControllerTest < SalvaControllerTest
   fixtures :indivadvicetargets, :indivadvices

  def initialize(*args)
   super
   @mycontroller =  IndivadviceController.new
   @myfixtures = { :startyear => 2006, :indivname => 'Miguel_test', :hours => 400, :user_id => 3, :indivadvicetarget_id => 1 }
   @mybadfixtures = {  :startyear => nil, :indivname => nil, :hours => nil, :user_id => nil, :indivadvicetarget_id => nil }
   @model = Indivadvice
  end
end
