require File.dirname(__FILE__) + '/../test_helper'
require 'roleinseminary'

class RoleinseminaryTest < Test::Unit::TestCase
  fixtures :roleinseminaries
  include UnitSimple
  def setup
    @roleinseminaries = %w(asistente organizador ponente)
    @myroleinseminary = Roleinseminary.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinseminaries, Roleinseminary)
  end

  def test_validation
    validate_test(@roleinseminaries, Roleinseminary)
  end

  def test_collision
    collision_test(@roleinseminaries, Roleinseminary)
  end

  def test_uniqueness
    @roleinseminary = Roleinseminary.new({:name => 'Organizador'})
    assert !@roleinseminary.save
  end

  def test_empty_object
    @roleinseminary = Roleinseminary.new()
    assert !@roleinseminary.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinseminary.id = 'xx'
    assert !@myroleinseminary.valid?

    # Negative number ID
    #@myroleinseminary.id = -1
    #assert !@myroleinseminary.valid?

    # Float number ID
    @myroleinseminary.id = 1.3
    assert !@myroleinseminary.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinseminary = Roleinseminary.new
    @myroleinseminary.name = nil
    assert !@myroleinseminary.valid?
  end
end
