require File.dirname(__FILE__) + '/../test_helper'
require 'roleinjobposition'

class RoleinjobpositionTest < Test::Unit::TestCase
  fixtures :roleinjobpositions
  include UnitSimple
  def setup
    @roleinjobpositions = %w(ayudante_de_investigador tecnico_academico investigador)
    @myroleinjobposition = Roleinjobposition.new({:name => 'Profesor de asignatura'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@roleinjobpositions, Roleinjobposition)
  end

  def test_validation
    validate_test(@roleinjobpositions, Roleinjobposition)
  end

  def test_collision
    collision_test(@roleinjobpositions, Roleinjobposition)
  end

  def test_uniqueness
    @roleinjobposition = Roleinjobposition.new({:name => 'Técnico académico'})
    assert !@roleinjobposition.save
  end

  def test_empty_object
    @roleinjobposition = Roleinjobposition.new()
    assert !@roleinjobposition.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinjobposition.id = 'xx'
    assert !@myroleinjobposition.valid?

    # Negative number ID
    #@myroleinjobposition.id = -1
    #assert !@myroleinjobposition.valid?

    # Float number ID
    @myroleinjobposition.id = 1.3
    assert !@myroleinjobposition.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinjobposition = Roleinjobposition.new
    @myroleinjobposition.name = nil
    assert !@myroleinjobposition.valid?
  end
end
