require File.dirname(__FILE__) + '/../test_helper'
require 'thesismodality'

class ThesismodalitylTest < Test::Unit::TestCase
  fixtures :thesismodalities
  include UnitSimple
  def setup
    @thesismodalities = %w(tesis tesina)
    @mythesismodality = Thesismodality.new({:name => 'Reporte'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@thesismodalities, Thesismodality)
  end

  def test_validation
    validate_test(@thesismodalities, Thesismodality)
  end

  def test_collision
    collision_test(@thesismodalities, Thesismodality)
  end

  def test_uniqueness
    @thesismodality = Thesismodality.new({:name => 'Tesina'})
    assert !@thesismodality.save
  end

  def test_empty_object
    @thesismodality = Thesismodality.new()
    assert !@thesismodality.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mythesismodality.id = 'xx'
    assert !@mythesismodality.valid?

    # Negative number ID
    #@mythesismodality.id = -1
    #assert !@mythesismodality.valid?

    # Float number ID
    @mythesismodality.id = 1.3
    assert !@mythesismodality.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mythesismodality = Thesismodality.new
    @mythesismodality.name = nil
    assert !@mythesismodality.valid?
  end
end
