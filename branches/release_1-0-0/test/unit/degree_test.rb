require File.dirname(__FILE__) + '/../test_helper'
require 'degree'

class DegreeTest < Test::Unit::TestCase
  fixtures :degrees
  include UnitSimple
  def setup
    @degrees = %w(maestria licenciatura)
    @mydegree = Degree.new({:name => 'PHD'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@degrees, Degree)
  end

  def test_validation
    validate_test(@degrees, Degree)
  end

  def test_collision
    collision_test(@degrees, Degree)
  end

  def test_creating_with_empty_attributes
    @degree = Degree.new
    assert !@degree.save
  end

  def test_uniqueness
    @degree = Degree.new({:name => 'Licenciatura'})
    assert !@degree.save
  end

  #Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mydegree.id = 1.6
    assert !@mydegree.valid?

    # Negative numbers
    #@mydegree.id = -1
    #assert !@mydegree.valid?

    @mydegree.id = 'mi_id_txt'
    assert !@mydegree.valid?
  end

  def test_bad_values_for_name
    @mydegree.name = nil
    assert !@mydegree.valid?
  end
end

