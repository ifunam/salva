require File.dirname(__FILE__) + '/../test_helper'
require 'sector'

class SectorTest < Test::Unit::TestCase
  fixtures :sectors
  include UnitSimple

  def setup
    @sectors = %w(investigacion_cientifica investigacion_humanistica docencia)
  end

  # Right - CRUD
  def test_crud
    crud_test(@sectors, Sector)
  end

  def test_validation
    validate_test(@sectors, Sector)
  end

  def test_collision
    collision_test(@sectors, Sector)
  end

  def test_create_with_empty_attributes
    @mysector = Sector.new
    assert !@mysector.save
  end

  def test_check_uniqueness
    @mysector = Sector.new({:name => 'Docencia'})
    assert !@mysector.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mysector = Sector.new
    @mysector.id = 'xx'
    assert !@mysector.valid?

    # Negative number ID
    #@mysector.id = -1
    #assert !@mysector.valid?

    # Float number ID
    @mysector.id = 1.3
    assert !@mysector.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mysector= Sector.new
    @mysector.name = nil
    assert !@mysector.valid?
  end
end
