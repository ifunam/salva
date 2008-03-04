require File.dirname(__FILE__) + '/../test_helper'
require 'addresstype'

class AddresstypeTest < Test::Unit::TestCase
  fixtures :addresstypes
  include UnitSimple
  def setup
    @addresstypes = %w(domicilio_profesional domicilio_particular domicilio_temporal)
    @myaddresstype = Addresstype.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@addresstypes, Addresstype)
  end

  def test_validation
    validate_test(@addresstypes, Addresstype)
  end

  def test_collision
    collision_test(@addresstypes, Addresstype)
  end

  def test_uniqueness
    @addresstype = Addresstype.new({:name => 'Domicilio temporal'})
    assert !@addresstype.save
  end

  def test_empty_object
    @addresstype = Addresstype.new()
    assert !@addresstype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myaddresstype.id = 'xx'
    assert !@myaddresstype.valid?

    # Float number ID
    @myaddresstype.id = 1.3
    assert !@myaddresstype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myaddresstype = Addresstype.new
    @myaddresstype.name = nil
    assert !@myaddresstype.valid?
  end
end
