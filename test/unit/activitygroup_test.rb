require File.dirname(__FILE__) + '/../test_helper'
require 'activitygroup'

class ActivitygroupTest < Test::Unit::TestCase
  fixtures :activitygroups
  include UnitSimple

  def setup
    @groups = %w(actividades_de_divulgacion actividades_de_docencia actividades_de_extension)
    @myactivitygroup = Activitygroup.new({:name => 'Otras actividades'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@groups, Activitygroup)
  end

  def test_validation
    validate_test(@groups, Activitygroup)
  end

  def test_collision
    collision_test(@groups, Activitygroup)
  end

  def test_create_with_empty_attributes
    @group = Activitygroup.new
    assert !@group.save
  end

  def test_check_uniqueness
    @group = Activitygroup.new({:name => 'Actividades de divulgación'})
    assert !@group.valid?

    @group = Activitygroup.find(1)
    @group.id = 2
    assert !@group.valid?
  end

  # Boundary tests
  # Checking constraints for name
  def test_bad_values_for_name
    @myactivitygroup.name = nil
    assert !@myactivitygroup.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @myactivitygroup.id = 'xx'
    assert !@myactivitygroup.valid?

    @myactivitygroup.id = 3.1416
    assert !@myactivitygroup.valid?

    @myactivitygroup.id = -3.0
    assert !@myactivitygroup.valid?
  end
end
