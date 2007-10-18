require File.dirname(__FILE__) + '/../test_helper'
require 'conferencetype'

class ConferencetypeTest < Test::Unit::TestCase
  fixtures :conferencetypes
  include UnitSimple

  def setup
    @conferencetypes = %w(congreso coloquio)
    @myconferencetype = Conferencetype.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@conferencetypes, Conferencetype)
  end

  def test_validation
    validate_test(@conferencetypes, Conferencetype)
  end

  def test_collision
    collision_test(@conferencetypes, Conferencetype)
  end

  def test_create_with_empty_attributes
    @conferencetype = Conferencetype.new
    assert !@conferencetype.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myconferencetype.id = 1.6
    assert !@myconferencetype.valid?

    @myconferencetype.id = 'xx'
    assert !@myconferencetype.valid?

    #@myconferencetype.id = -1.0
    #assert !@myconferencetype.valid?
  end

  def test_bad_values_for_name
    @myconferencetype.name = nil
    assert !@myconferencetype.valid?
  end
end

