require File.dirname(__FILE__) + '/../test_helper'
require 'documenttype'

class DocumenttypeTest < Test::Unit::TestCase
  fixtures :documenttypes
  include UnitSimple
  def setup
    @documenttypes = %w(plan_anual_de_actividades curriculum informe_anual_de_actividades)
    @mydocumenttype = Documenttype.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@documenttypes, Documenttype)
  end

  def test_validation
    validate_test(@documenttypes, Documenttype)
  end

  def test_collision
    collision_test(@documenttypes, Documenttype)
  end

  def test_uniqueness
    @documenttype = Documenttype.new({:name => 'Plan anual de actividades'})
    assert !@documenttype.save
  end

  def test_empty_object
    @documenttype = Documenttype.new()
    assert !@documenttype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mydocumenttype.id = 'xx'
    assert !@mydocumenttype.valid?

    # Negative number ID
    #@mydocumenttype.id = -1
    #assert !@mydocumenttype.valid?

    # Float number ID
    @mydocumenttype.id = 1.3
    assert !@mydocumenttype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mydocumenttype = Documenttype.new
    @mydocumenttype.name = nil
    assert !@mydocumenttype.valid?
  end
end
