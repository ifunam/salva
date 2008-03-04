require File.dirname(__FILE__) + '/../test_helper'
require 'researchgroup'

class ResearchgroupTest < Test::Unit::TestCase
  fixtures :researchgroups
  include UnitSimple

  def setup
    @researchgroups = %w(propiedades_opticas_de_defectos_en_solidos biocomplejidad_y_redes)
    @myresearchgroup = Researchgroup.new({:name => 'Otro'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@researchgroups, Researchgroup)
  end

  def test_validation
    validate_test(@researchgroups, Researchgroup)
  end

  def test_collision
    collision_test(@researchgroups, Researchgroup)
  end

  def test_creating_with_empty_attributes
    @researchgroup = Researchgroup.new
    assert !@researchgroup.save
  end

  def test_uniqueness
    @researchgroup = Researchgroup.new({:name => 'Biocomplejidad y Redes'})
    assert !@researchgroup.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myresearchgroup.id = 1.6
    assert !@myresearchgroup.valid?

    # Negative numbers
    #@myresearchgroup.id = -1
    #assert !@myresearchgroup.valid?

    @myresearchgroup.id = 'xx'
    assert !@myresearchgroup.valid?
  end

  def test_bad_values_for_name
    @myresearchgroup.name = nil
    assert !@myresearchgroup.valid?
  end
end
