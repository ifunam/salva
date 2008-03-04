require File.dirname(__FILE__) + '/../test_helper'
require 'roleinconference'

class RoleinconferenceTest < Test::Unit::TestCase
  fixtures :roleinconferences
  include UnitSimple

  def setup
    @roleinconferences = %w(coordinador_general asistente organizador)
    @myroleinconference = Roleinconference.new({:name => 'Comite tecnico'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinconferences, Roleinconference)
  end

  def test_validation
    validate_test(@roleinconferences, Roleinconference)
  end

  def test_collision
    collision_test(@roleinconferences, Roleinconference)
  end

  def test_create_with_empty_attributes
    @myroleinconference = Roleinconference.new
    assert !@myroleinconference.save
  end

  def test_check_uniqueness
    @myroleinconference = Roleinconference.new({:name => 'Asistente'})
    assert !@myroleinconference.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinconference = Roleinconference.new
    @myroleinconference.id = 'xx'
    assert !@myroleinconference.valid?

    # Negative number ID
    #@myroleinconference.id = -1
    #assert !@myroleinconference.valid?

    # Float number ID
    @myroleinconference.id = 1.3
    assert !@myroleinconference.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinconference = Roleinconference.new
    @myroleinconference.name = nil
    assert !@myroleinconference.valid?
  end
end
