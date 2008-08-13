require 'salva_controller_test'
require 'coursegrouptype_controller'

class CoursegrouptypeController; def rescue_action(e) raise e end; end

class  CoursegrouptypeControllerTest < SalvaControllerTest
   fixtures :coursegrouptypes

  def initialize(*args)
   super
   @mycontroller =  CoursegrouptypeController.new
   @myfixtures = { :name => 'Certificación_test' }
   @mybadfixtures = {  :name => nil }
   @model = Coursegrouptype
  end
end
