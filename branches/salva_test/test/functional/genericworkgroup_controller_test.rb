require 'salva_controller_test.rb'
require 'genericworkgroup_controller'

class Genericworkgroup_ControllerTest < SalvaControllerTest
  fixtures :genericworkgroups

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = GenericworkgroupController.new
    @fixtures =  {
       :name  => "Productos de dosencia", :id => 1
    }
    @badfixtures ={ :name => nil, :id => nil}
    # @quickposts s= { :new => %w(booktype volume language)}
    @class = Genericworkgroup
  end
end
