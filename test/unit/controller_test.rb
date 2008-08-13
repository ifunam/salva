require File.dirname(__FILE__) + '/../test_helper'
require 'controller'

class RcontrollerTest < Test::Unit::TestCase
  fixtures :controllers
  include UnitSimple

  def setup
    @controllers = %w(citizen address person)
  end

  # Right - CRUD
  def test_crud
    crud_test(@controllers, Controller)
  end

  def test_validation
    validate_test(@controllers, Controller)
  end

  def test_collision
    collision_test(@controllers, Controller)
  end

  def test_create_with_empty_attributes
    @mycontroller = Controller.new
    assert !@mycontroller.save
  end

  def test_check_uniqueness
    @mycontroller2 = Controller.new({:name => 'address'})
    assert !@mycontroller2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mycontroller = Controller.new
    @mycontroller.id = 'xx'
    assert !@mycontroller.valid?

    #Negative number ID
    @mycontroller = Controller.new
    @mycontroller.id = -1.0
    assert !@mycontroller.valid?

    # Float number ID
    @mycontroller.id = 1.3
    assert !@mycontroller.valid?

    # Nil number ID
    @mycontroller.id = nil
    assert !@mycontroller.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mycontroller = Controller.new
    @mycontroller.name = nil
    assert !@mycontroller.valid?
  end

end
