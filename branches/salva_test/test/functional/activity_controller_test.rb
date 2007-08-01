#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'activity_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class Activity_ControllerTest < SalvaControllerTest
  fixtures :userstatuses, :users, :activitygroups, :activitytypes, :activities

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = ActivityController.new
    @myfixtures =  {
      :name => "Opiniones",
       :id => 2,  :activitytype_id => 1,  :year => 1984
     }
    @mybadfixtures =  {
      :name => nil,
       :id => nil,  :activitytype_id => 1,    :year => 1984
      }
   @class = Activity

  end
end

