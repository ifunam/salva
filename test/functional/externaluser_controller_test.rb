require 'salva_controller_test'
require 'externaluser_controller'

class ExternaluserController; def rescue_action(e) raise e end; end

class  ExternaluserControllerTest < SalvaControllerTest
   fixtures :externalusers

  def initialize(*args)
   super
   @mycontroller =  ExternaluserController.new
   @myfixtures = { :firstname => 'Israel_test', :lastname1 => 'Gomez_test' }
   @mybadfixtures = {  :firstname => nil, :lastname1 => nil }
   @model = Externaluser
  end
end
