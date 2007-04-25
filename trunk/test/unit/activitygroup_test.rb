require File.dirname(__FILE__) + '/../test_helper'
require 'activitygroup'

class ActivitygroupTest < Test::Unit::TestCase
  fixtures :activitygroups
  include UnitSimple
  
  def setup
   @activitygroup = %w(actividades_de_divulgacion actividades_de_docencia actividades_de_extension)
   @myactivitygroup = Activitygroup.new({:name => 'Otras actividades'})
  end

  #Right - CRUD
  def test_crud 
    crud_test(@activitygroup, Activitygroup)
  end
  
  def test_validation
    validate_test(@activitygroup, Activitygroup)
  end
  
  def test_collision
    collision_test(@activitygroup, Activitygroup)
  end
  
  def test_create_with_empty_attributes
     @activitygroup = Activitygroup.new
    assert !@activitygroup.save
  end
  
  def test_check_uniqueness
    @activitygroup = Activitygroup.new({:name => 'Actividades de divulgación'})
    @activitygroup.id= 2
    assert !@activitygroup.save
  end
  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @myactivitygroup.name = nil
    assert !@myactivitygroup.valid?
    
    @myactivitygroup.name = 'X'
    assert !@myactivitygroup.valid?

    @myactivitygroup.name = 'X' * 201
    assert !@myactivitygroup.valid?

    @myactivitygroup.name = '5' 
    assert !@myactivitygroup.valid?
  end
  
  # Checking constraints for ID
  def test_bad_values_for_id
    @myactivitygroup.id = 'xx'
    assert !@myactivitygroup.valid?
     
     @myactivitygroup.id = nil
    assert !@myactivitygroup.valid?
    
    @myactivitygroup.id = 3.1416
    assert !@myactivitygroup.valid?
    # @myactivitygroup.id = -1
    # assert !@myactivitygroup.valid?
  end
end
