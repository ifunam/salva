require File.dirname(__FILE__) + '/../test_helper'
require 'researcharea'

class ResearchareaTest < Test::Unit::TestCase
  fixtures :researchareas
  include UnitSimple

  def setup
    @researchareas = %w(fisica_del_clima aerobiologia transferencia_de_Radiacion)
    @myresearcharea = Researcharea.new({:name => 'Citogenética Ambiental'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@researchareas, Researcharea)
  end

  def test_validation
    validate_test(@researchareas, Researcharea)
  end

  def test_collision
    collision_test(@researchareas, Researcharea)
  end

  def test_create_with_empty_attributes
    @researcharea = Researcharea.new
    assert !@researcharea.save
  end

  def test_check_uniqueness
    @researcharea = Researcharea.new({:name => 'Aerobiología'})
    @researcharea.id = 2
    assert !@researcharea.save
  end

  # boundary
  # Checking constraints for name
  def test_bad_values_for_name
    @myresearcharea.name = nil
    assert !@myresearcharea.valid?
  end

  # Checking constraints for ID
  def test_bad_values_for_id
    @myresearcharea.id = 'xx'
    assert !@myresearcharea.valid?

    @myresearcharea.id = 3.1416
    assert !@myresearcharea.valid?

    @myresearcharea.id = -1.0
    assert !@myresearcharea.valid?
  end
end
