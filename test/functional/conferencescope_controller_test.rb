require 'salva_controller_test'
require 'conferencescope_controller'

class ConferencescopeController; def rescue_action(e) raise e end; end

class  ConferencescopeControllerTest < SalvaControllerTest
   fixtures :conferencescopes

  def initialize(*args)
   super
   @mycontroller =  ConferencescopeController.new
   @myfixtures = { :name => 'Nacional_test' }
   @mybadfixtures = {  :name => nil }
   @model = Conferencescope
  end
end
