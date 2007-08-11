require File.dirname(__FILE__) + '/../test_helper'
require 'idtype'

class IdtypeTest < Test::Unit::TestCase
  fixtures :idtypes
  include UnitSimple
  def setup
    @idtypes = %w(rfc curp pasaporte)
    @myidtype = Idtype.new({:name => 'VISA'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@idtypes, Idtype)
  end

  def test_validation
    validate_test(@idtypes, Idtype)
  end

  def test_collision
    collision_test(@idtypes, Idtype)
  end

  def test_uniqueness
    @idtype = Idtype.new({:name => 'CURP'})
    assert !@idtype.save
  end

  def test_empty_object
    @idtype = Idtype.new()
    assert !@idtype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myidtype.id = 'xx'
    assert !@myidtype.valid?

    # Negative number ID
    # @myidtype.id = -1
    # assert !@myidtype.valid?

    # Float number ID
    @myidtype.id = 1.3
    assert !@myidtype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myidtype = Idtype.new
    @myidtype.name = nil
    assert !@myidtype.valid?
  end
end
