require File.dirname(__FILE__) + '/../test_helper'
require 'citizenmodality'

class CitizenmodalityTest < Test::Unit::TestCase
  fixtures :citizenmodalities
  include UnitSimple
  def setup
    @citizenmodalities = %w(por_naturalizacion por_nacimiento)
    @mycitizenmodality = Citizenmodality.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@citizenmodalities, Citizenmodality)
  end

  def test_validation
    validate_test(@citizenmodalities, Citizenmodality)
  end

  def test_collision
    collision_test(@citizenmodalities, Citizenmodality)
  end

  def test_uniqueness
    @citizenmodality = Citizenmodality.new({:name => 'Por naturalización'})
    assert !@citizenmodality.save
  end

  def test_empty_object
    @citizenmodality = Citizenmodality.new()
    assert !@citizenmodality.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mycitizenmodality.id = 'xx'
    assert !@mycitizenmodality.valid?

    # Negative number ID
    @mycitizenmodality.id = -1.0
    assert !@mycitizenmodality.valid?

    # Float number ID
    @mycitizenmodality.id = 1.3
    assert !@mycitizenmodality.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mycitizenmodality = Citizenmodality.new
    @mycitizenmodality.name = nil
    assert !@mycitizenmodality.valid?
  end
end
