#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'booktype_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class Booktype_ControllerTest < SalvaControllerTest
  fixtures :booktypes

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = BooktypeController.new
    @myfixtures =  {
      :name => "Arbitrados",
       :id => 1}
    @mybadfixtures =  {
      :name => nil,
      :id => nil}
   @class = Booktype

  end
end

