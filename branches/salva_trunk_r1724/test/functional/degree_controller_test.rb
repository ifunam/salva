require 'salva_controller_test'
require 'degree_controller'

class DegreeController; def rescue_action(e) raise e end; end

class  DegreeControllerTest < SalvaControllerTest
   fixtures :degrees

  def initialize(*args)
   super
   @mycontroller =  DegreeController.new
   @myfixtures = { :name => 'Maestría_test' }
   @mybadfixtures = {  :name => nil }
   @model = Degree
  end
end
