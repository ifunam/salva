require File.dirname(__FILE__) + '/../test_helper'
require 'projecttype'

class MprojecttypeTest < Test::Unit::TestCase
  fixtures :projecttypes
  include UnitSimple

  def setup
    @projecttypes = %w(docencia difusion)
    @myprojecttype = Projecttype.new({:name => 'Investigación'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@projecttypes, Projecttype)
  end

  def test_validation
    validate_test(@projecttypes, Projecttype)
  end

  def test_collision
    collision_test(@projecttypes, Projecttype)
  end

  def test_create_with_empty_attributes
    @myprojecttype= Projecttype.new
    assert !@myprojecttype.save
  end

  def test_check_uniqueness
    @myprojecttype = Projecttype.new({:name => 'Docencia'})
    assert !@myprojecttype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myprojecttype = Projecttype.new
    @myprojecttype.id = 'xx'
    assert !@myprojecttype.valid?

    # Negative number ID
    #@myprojecttype.id = -1
    #assert !@myprojecttype.valid?

    # Float number ID
    @myprojecttype.id = 1.3
    assert !@myprojecttype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    @myprojecttype= Projecttype.new
    @myprojecttype.name = nil
    assert !@myprojecttype.valid?
  end

end
