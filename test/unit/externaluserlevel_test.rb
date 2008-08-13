require File.dirname(__FILE__) + '/../test_helper'
require 'externaluserlevel'

class ExternaluserlevelTest < Test::Unit::TestCase
  fixtures :externaluserlevels
  include UnitSimple
  def setup
    @externaluserlevels = %w(estudiante tecnico_academico investigador)
    @myexternaluserlevel = Externaluserlevel.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@externaluserlevels, Externaluserlevel)
  end

  def test_validation
    validate_test(@externaluserlevels, Externaluserlevel)
  end

  def test_collision
    collision_test(@externaluserlevels, Externaluserlevel)
  end

  def test_uniqueness
    @externaluserlevel = Externaluserlevel.new({:name => 'Técnico Académico'})
    assert !@externaluserlevel.save
  end

  def test_empty_object
    @externaluserlevel = Externaluserlevel.new()
    assert !@externaluserlevel.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myexternaluserlevel.id = 'xx'
    assert !@myexternaluserlevel.valid?

    # Negative number ID
    # @myexternaluserlevel.id = -1
    # assert !@myexternaluserlevel.valid?

    # Float number ID
    @myexternaluserlevel.id = 1.3
    assert !@myexternaluserlevel.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myexternaluserlevel = Externaluserlevel.new
    @myexternaluserlevel.name = nil
    assert !@myexternaluserlevel.valid?
  end
end
