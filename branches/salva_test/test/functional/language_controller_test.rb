#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'language_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class Language_ControllerTest < SalvaControllerTest
  fixtures :languages

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = LanguageController.new
    @fixtures =  {
      :name => 'Ingles',
       :id => 1}
    @badfixtures = {
      :name => nil,
      :id=>1
    }
    @model = Language
  end
end

