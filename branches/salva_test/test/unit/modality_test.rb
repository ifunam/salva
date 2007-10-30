require File.dirname(__FILE__) + '/../test_helper'
require 'modality'

class RmodalityTest < Test::Unit::TestCase
  fixtures :modalities
  include UnitSimple

  def setup
    @modalities = %w(presencial_y_a_distancia a_distancia)
    @mymodality = Modality.new({:name => 'Presencial'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@modalities, Modality)
  end

  def test_validation
    validate_test(@modalities, Modality)
  end

  def test_collision
    collision_test(@modalities, Modality)
  end

  def test_create_with_empty_attributes
    @mymodality = Modality.new
    assert !@mymodality.save
  end

  def test_check_uniqueness
    @mymodality = Modality.new({:name => 'Presencial'})
    assert !@mymodality.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mymodality = Modality.new
    @mymodality.id = 'xx'
    assert !@mymodality.valid?

    # Negative number ID
    @mymodality.id = -1
    assert !@mymodality.valid?

    # Float number ID
    @mymodality.id = 1.3
    assert !@mymodality.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mymodality = Modality.new
    @mymodality.name = nil
    assert !@mymodality.valid?
  end

end
