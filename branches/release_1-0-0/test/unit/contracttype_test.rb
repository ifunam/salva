require File.dirname(__FILE__) + '/../test_helper'
require 'contracttype'

class ContracttypeTest < Test::Unit::TestCase
  fixtures :contracttypes
  include UnitSimple
  def setup
    @contracttypes = %w(plaza_definitiva por_honorarios por_obra_determinada)
    @mycontracttype = Contracttype.new({:name => 'Artículo 51'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@contracttypes, Contracttype)
  end

  def test_validation
    validate_test(@contracttypes, Contracttype)
  end

  def test_collision
    collision_test(@contracttypes, Contracttype)
  end

  def test_uniqueness
    @contracttype = Contracttype.new({:name => 'Por honorarios'})
    assert !@contracttype.save
  end

  def test_empty_object
    @contracttype = Contracttype.new()
    assert !@contracttype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mycontracttype.id = 'xx'
    assert !@mycontracttype.valid?

    # Negative number ID
    #@mycontracttype.id = -1
    #assert !@mycontracttype.valid?

    # Float number ID
    @mycontracttype.id = 1.3
    assert !@mycontracttype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mycontracttype = Contracttype.new
    @mycontracttype.name = nil
    assert !@mycontracttype.valid?
  end
end
