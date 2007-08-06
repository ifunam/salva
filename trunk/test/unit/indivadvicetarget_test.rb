require File.dirname(__FILE__) + '/../test_helper'
require 'indivadvicetarget'

class IndivadvicetargetTest < Test::Unit::TestCase
  fixtures :indivadvicetargets
  include UnitSimple

  def setup
    @indivadvicetargets = %w(estudiante_asociado servicio_social becario)
    @myindivadvicetarget = Indivadvicetarget.new({:name => 'Otro', :id => 5})
  end

  # Right - CRUD
  def test_crud
    crud_test(@indivadvicetargets, Indivadvicetarget)
  end

  def test_validation
    validate_test(@indivadvicetargets, Indivadvicetarget)
  end

  def test_collision
    collision_test(@indivadvicetargets, Indivadvicetarget)
  end

  def test_creating_with_empty_attributes
    @indivadvicetarget = Indivadvicetarget.new
    assert !@indivadvicetarget.save
  end

  def test_uniqueness
    @indivadvicetarget = Indivadvicetarget.new({:name => 'Becario'})
    assert !@indivadvicetarget.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myindivadvicetarget.id = 1.6
    assert !@myindivadvicetarget.valid?

    @myindivadvicetarget.id = 'xx'
    assert !@myindivadvicetarget.valid?

    # Negative numbers
    #@myindivadvicetarget.id = -1
    #assert !@myindivadvicetarget.valid?
  end

  def test_bad_values_for_name
    @myindivadvicetarget.name = nil
    assert !@myindivadvicetarget.valid?
  end
end
