require File.dirname(__FILE__) + '/../test_helper'
require 'academicprogramtype'

class AcademicprogramtypeTest < Test::Unit::TestCase
  fixtures :academicprogramtypes
  include UnitSimple

  def setup
    @academicprogramtypes = %w(escolarizado universidad_abierta universidad_abierta_y_escolarizado)
    @myacademicprogramtypes = Academicprogramtype.new({:name => 'semiaprobada'})
  end

  #Right - CRUD
  def test_crud
    crud_test(@academicprogramtypes, Academicprogramtype)
  end

  def test_validation
    validate_test(@academicprogramtypes, Academicprogramtype)
  end

  def test_collision
    collision_test(@academicprogramtypes, Academicprogramtype)
  end

  def test_create_with_empty_attributes
    @academicprogramtypes = Academicprogramtype.new
    assert !@academicprogramtypes.save
  end

  def test_check_uniqueness
    @academicprogramtype = Academicprogramtype.new({:name => 'Escolarizado'})
    assert !@academicprogramtype.save
  end
  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @myacademicprogramtypes.name = nil
    assert !@myacademicprogramtypes.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @myacademicprogramtypes.id = 'xx'
    assert !@myacademicprogramtypes.valid?

    @myacademicprogramtypes.id = 3.1416
    assert !@myacademicprogramtypes.valid?

    # @myacademicprogramtypes.id = -1
    #assert !@myacademicprogramtypes.valid?
  end

end
