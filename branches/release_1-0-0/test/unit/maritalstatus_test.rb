require File.dirname(__FILE__) + '/../test_helper'
require 'maritalstatus'

class MaritalstatusTest < Test::Unit::TestCase
  fixtures :maritalstatuses
  include UnitSimple
  def setup
    @maritalstatuses = %w(divorciado casado soltero)
    @myaction = Maritalstatus.new({:name => 'Viudo(a)'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@maritalstatuses, Maritalstatus)
  end

  def test_validation
    validate_test(@maritalstatuses, Maritalstatus)
  end

  def test_collision
    collision_test(@maritalstatuses, Maritalstatus)
  end

  def test_uniqueness
    @maritalstatus = Maritalstatus.new({:name => 'Casado(a)'})
    assert !@maritalstatus.save
  end

  def test_empty_object
    @maritalstatus = Maritalstatus.new()
    assert !@maritalstatus.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myaction.id = 'xx'
    assert !@myaction.valid?

    # Negative number ID
    #@myaction.id = -1
    #assert !@myaction.valid?

    # Float number ID
    @myaction.id = 1.3
    assert !@myaction.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myaction = Maritalstatus.new
    @myaction.name = nil
    assert !@myaction.valid?
  end
end
