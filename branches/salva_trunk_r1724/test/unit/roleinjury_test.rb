require File.dirname(__FILE__) + '/../test_helper'
require 'roleinjury'

class RoleinjuryTest < Test::Unit::TestCase
  fixtures :roleinjuries
  include UnitSimple

  def setup
    @roleinjuries = %w(presidente secretario(a) vocal)
    @myroleinjury = Roleinjury.new({:name => 'Vocal'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinjuries, Roleinjury)
  end

  def test_validation
    validate_test(@roleinjuries, Roleinjury)
  end

  def test_collision
    collision_test(@roleinjuries, Roleinjury)
  end

  def test_create_with_empty_attributes
    @myroleinjury = Roleinjury.new
    assert !@myroleinjury.save
  end

  def test_check_uniqueness
    @myroleinjury = Roleinjury.new({:name => 'Presidente'})
    assert !@myroleinjury.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinjury = Roleinjury.new
    @myroleinjury.id = 'xx'
    assert !@myroleinjury.valid?

    # Negative number ID
    #@myroleinjury.id = -1
    #assert !@myroleinjury.valid?

    # Float number ID
    @myroleinjury.id = 1.3
    assert !@myroleinjury.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinjury = Roleinjury.new
    @myroleinjury.name = nil
    assert !@myroleinjury.valid?
  end

end
