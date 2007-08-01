require 'salva_controller_test'
require 'publisher_controller'

class Publisher_controller_Test < SalvaControllerTest
    fixtures :publishers

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = PublisherController.new
    @myfixtures =  {
    :name => 'Publicaciones DC', :id =>1
    }
    @mybadfixtures =  {
    :name =>nil, :id =>nil }
    @class = Publisher
end
end
