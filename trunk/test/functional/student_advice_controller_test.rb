require 'salva_controller_test'
require 'student_advice_controller'

class StudentAdviceController; def rescue_action(e) raise e end; end

class  StudentAdviceControllerTest < SalvaControllerTest
   fixtures :indivadvicetargets, :indivadvices

  def initialize(*args)
   super
   @mycontroller =  StudentAdviceController.new
   @myfixtures = { :startyear => 2006, :indivname => 'Miguel_test', :hours => 400, :user_id => 3, :indivadvicetarget_id => 1 }
   @mybadfixtures = {  :startyear => nil, :indivname => nil, :hours => nil, :user_id => nil, :indivadvicetarget_id => nil }
   @model = Indivadvice
  end
end
