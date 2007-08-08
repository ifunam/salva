#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'course_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class Course_ControllerTest < SalvaControllerTest
  fixtures :coursedurations, :modalities, :states,:countries,:institutiontitles, :institutions, :courses

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = CourseController.new
    @myfixtures =  {
      :name => "Linux",
      :country_id => 484,  :courseduration_id => 1,  :modality_id => 3,  :startyear=> 2007,
       :institution_id=>1, :id => 1}
    @mybadfixtures = {
       :name => nil,
      :institution_id => 1, :country_id => nil,  :courseduration_id => 1,  :modality_id => 3,  :startyear=> 2007,
      :id=>1
    }
   @class = Course

  end
end

