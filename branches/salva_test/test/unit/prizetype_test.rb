require File.dirname(__FILE__) + '/../test_helper'
require 'prizetype'

class PrizetypeTest < Test::Unit::TestCase
  fixtures :prizetypes
  include UnitSimple

  def setup
    @prizetypes = %w(medalla diploma premio)
    @myprizetype = Prizetype.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@prizetypes, Prizetype)
  end

  def test_validation
    validate_test(@prizetypes, Prizetype)
  end

  def test_collision
    collision_test(@prizetypes, Prizetype)
  end

  def test_create_with_empty_attributes
    @myprizetype = Prizetype.new
    assert !@myprizetype.save
  end

  def test_check_uniqueness
    @myprizetype2 = Prizetype.new({:name => 'Diploma'})
    assert !@myprizetype2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myprizetype.id = 'xx'
    assert !@myprizetype.valid?

    # Negative number ID
    #@myprizetype.id = -1
    #assert !@myprizetype.valid?

    # Float number ID
    @myprizetype.id = 1.3
    assert !@myprizetype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myprizetype.name = nil
    assert !@myprizetype.valid?
  end

end
