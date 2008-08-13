require File.dirname(__FILE__) + '/../test_helper'

class SeminarytypeTest < Test::Unit::TestCase
  fixtures :seminarytypes
  include UnitSimple

  def setup
    @seminarytypes = %w(seminario coloquio conferencia)
  end

  # Right - CRUD
  def test_crud
    crud_test(@seminarytypes, Seminarytype)
  end

  def test_validation
    validate_test(@seminarytypes, Seminarytype)
  end

  def test_collision
    collision_test(@seminarytypes,Seminarytype)
  end

  def test_create_with_empty_attributes
    @myseminarytype = Seminarytype.new
    assert !@myseminarytype.save
  end

  def test_check_uniqueness
    @myseminarytype2 = Seminarytype.new({:name => 'Seminario'})
    assert !@myseminarytype2.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myseminarytype = Seminarytype.new
    @myseminarytype.id = 'xx'
    assert !@myseminarytype.valid?

    # Negative number ID
    #@myseminarytype.id = -1
    #assert !@myseminarytype.valid?

    # Float number ID
    @myseminarytype.id = 1.3
    assert !@myseminarytype.valid?

    # Very large number for ID
    @myseminarytype.id = 10000
    assert !@myseminarytype.valid?

    # Nil number ID
    @myseminarytype.id = nil
    assert !@myseminarytype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myseminarytype = Seminarytype.new
    @myseminarytype.name = nil
    assert !@myseminarytype.valid?
  end

end
