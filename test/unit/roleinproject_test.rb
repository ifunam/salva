require File.dirname(__FILE__) + '/../test_helper'
require 'roleinproject'

class RoleinprojectTest < Test::Unit::TestCase
  fixtures :roleinprojects
  include UnitSimple

  def setup
    @roleinprojects = %w(participante responsable corresponsable)
    @myroleinproject = Roleinproject.new({:name => 'Becario'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinprojects, Roleinproject)
  end

  def test_validation
    validate_test(@roleinprojects, Roleinproject)
  end

  def test_collision
    collision_test(@roleinprojects, Roleinproject)
  end

  def test_create_with_empty_attributes
    @myroleinproject = Roleinproject.new
    assert !@myroleinproject.save
  end

  def test_check_uniqueness
    @myroleinproject = Roleinproject.new({:name => 'Responsable'})
    assert !@myroleinproject.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinproject = Roleinproject.new
    @myroleinproject.id = 'xx'
    assert !@myroleinproject.valid?

    # Negative number ID
    #@myroleinproject.id = -1
    #assert !@myroleinproject.valid?

    # Float number ID
    @myroleinproject.id = 1.3
    assert !@myroleinproject.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinproject = Roleinproject.new
    @myroleinproject.name = nil
    assert !@myroleinproject.valid?
  end
end
