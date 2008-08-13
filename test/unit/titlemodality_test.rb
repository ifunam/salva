require File.dirname(__FILE__) + '/../test_helper'
require 'titlemodality'

class TitlemodalityTest < Test::Unit::TestCase
  fixtures :titlemodalities
  include UnitSimple
  def setup
    @titlemodalities = %w(tesis ensayo tesina)
    @mytitlemodality = Titlemodality.new({:name => 'Reporte técnico'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@titlemodalities, Titlemodality)
  end

  def test_validation
    validate_test(@titlemodalities, Titlemodality)
  end

  def test_collision
    collision_test(@titlemodalities, Titlemodality)
  end

  def test_uniqueness
    @titlemodality = Titlemodality.new({:name => 'Ensayo'})
    assert !@titlemodality.save
  end

  def test_empty_object
    @titlemodality = Titlemodality.new()
    assert !@titlemodality.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mytitlemodality.id = 'xx'
    assert !@mytitlemodality.valid?

    # Negative number ID
    #@mytitlemodality.id = -1
    #assert !@mytitlemodality.valid?

    # Float number ID
    @mytitlemodality.id = 1.3
    assert !@mytitlemodality.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mytitlemodality = Titlemodality.new
    @mytitlemodality.name = nil
    assert !@mytitlemodality.valid?
  end
end
