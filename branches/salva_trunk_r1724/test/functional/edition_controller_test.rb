require 'salva_controller_test'
require 'edition_controller'

class EditionController; def rescue_action(e) raise e end; end

class  EditionControllerTest < SalvaControllerTest
   fixtures :editions

  def initialize(*args)
   super
   @mycontroller =  EditionController.new
   @myfixtures = { :name => 'Primera_test' }
   @mybadfixtures = {  :name => nil }
   @model = Edition
  end
end
