require File.dirname(__FILE__) + '/../test_helper'
require 'documenttype'

class DocumenttypeTest < Test::Unit::TestCase
  fixtures :documenttypes
  include UnitSimple

  def setup
    @skilltypes = %w(plan_anual_de_actividades informe_anual_de_actividades)
    @myskilltype = Documenttype.new
  end

  # Right - CRUD
  def test_crud
    crud_test(@skilltypes, Documenttype)
  end

  def test_validation
    validate_test(@skilltypes, Documenttype)
  end

  def test_collision
    collision_test(@skilltypes, Documenttype)
  end

  def test_create_with_empty_attributes
    @myskilltype = Documenttype.new
    assert !@myskilltype.save
  end

  def test_check_uniqueness
    @myskilltype = Documenttype.new({:name => 'Informe anual de actividades'})
    assert !@myskilltype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myskilltype.id = 'xx'
    assert !@myskilltype.valid?

    # Negative number ID
    #@myskilltype.id = -1
    #assert !@myskilltype.valid?

    # Float number ID
    @myskilltype.id = 1.3
    assert !@myskilltype.valid?

    # Nil number ID
    @myskilltype.id = nil
    assert !@myskilltype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myskilltype.name = nil
    assert !@myskilltype.valid?
  end
end
