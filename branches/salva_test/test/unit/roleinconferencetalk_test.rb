require File.dirname(__FILE__) + '/../test_helper'
require 'roleinconferencetalk'

class RoleinconferencetalkTest < Test::Unit::TestCase
  fixtures :roleinconferencetalks
  include UnitSimple
  def setup
    @roleinconferencetalks = %w(coordinador_de_mesa ponente )
    @myroleinconferencetalk = Roleinconferencetalk.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinconferencetalks, Roleinconferencetalk)
  end

  def test_validation
    validate_test(@roleinconferencetalks, Roleinconferencetalk)
  end

  def test_collision
    collision_test(@roleinconferencetalks, Roleinconferencetalk)
  end

  def test_uniqueness
    @roleinconferencetalk = Roleinconferencetalk.new({:name => 'Coordinador de mesa'})
    assert !@roleinconferencetalk.save
  end

  def test_empty_object
    @roleinconferencetalk = Roleinconferencetalk.new()
    assert !@roleinconferencetalk.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinconferencetalk.id = 'xx'
    assert !@myroleinconferencetalk.valid?

    # Negative number ID
    #@myroleinconferencetalk.id = -1
    #assert !@myroleinconferencetalk.valid?

    # Float number ID
    @myroleinconferencetalk.id = 1.3
    assert !@myroleinconferencetalk.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinconferencetalk = Roleinconferencetalk.new
    @myroleinconferencetalk.name = nil
    assert !@myroleinconferencetalk.valid?
  end
end
