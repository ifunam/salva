require File.dirname(__FILE__) + '/../test_helper'
require 'groupmodality'

class GroupmodalityTest < Test::Unit::TestCase
  fixtures :groupmodalities
  include UnitSimple

  def setup
    @groupmodalities = %w(administrativa academica)
    @mygroupmodality = Groupmodality.new({:name => 'Otro' })
  end

  # Right - CRUD
  def test_crud
    crud_test(@groupmodalities, Groupmodality)
  end

  def test_validation
    validate_test(@groupmodalities, Groupmodality)
  end

  def test_collision
    collision_test(@groupmodalities, Groupmodality)
  end

  def test_creating_with_empty_attributes
    @groupmodality = Groupmodality.new
    assert !@groupmodality.save
  end

  def test_uniqueness
    @groupmodality = Groupmodality.new({:name => 'Administrativa'})
    assert !@groupmodality.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mygroupmodality.id = 1.6
    assert !@mygroupmodality.valid?

    # Negative numbers
    #@mygroupmodality.id = -1
    #assert !@mygroupmodality.valid?

    @mygroupmodality.id = 'xx'
    assert !@mygroupmodality.valid?
  end

  def test_bad_values_for_name
    @mygroupmodality.name = nil
    assert !@mygroupmodality.valid?
  end
end
