require 'salva_controller_test'
require 'mediatype_controller'

class MediatypeController; def rescue_action(e) raise e end; end

class  MediatypeControllerTest < SalvaControllerTest
   fixtures :mediatypes

  def initialize(*args)
   super
   @mycontroller =  MediatypeController.new
   @myfixtures = { :name => 'Impreso_test' }
   @mybadfixtures = {  :name => nil }
   @model = Mediatype
  end
end
