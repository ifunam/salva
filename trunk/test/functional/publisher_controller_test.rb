require 'salva_controller_test'
require 'publisher_controller'

class PublisherController; def rescue_action(e) raise e end; end

class  PublisherControllerTest < SalvaControllerTest
   fixtures :publishers

  def initialize(*args)
   super
   @mycontroller =  PublisherController.new
   @myfixtures = { :name => 'A K Peters Ltd._test', :descr => 'specialized publishing for the oil and gas industry. scientific technical publisher whose publishing program focuses on computer science (graphics, geometric design, robotics, CHI) and mathematics._test', :url => 'http://www.akpeters.com/_test' }
   @mybadfixtures = {  :name => nil, :descr => nil, :url => nil }
   @model = Publisher
  end
end
