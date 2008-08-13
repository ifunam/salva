require File.dirname(__FILE__) + '/../test_helper'
require 'mediatype'

class MediatypeTest < Test::Unit::TestCase
  fixtures :mediatypes
  include UnitSimple

  def setup
    @mediatypes = %w(printed electronic)
    @mymediatype = Mediatype.new({:name => 'Video'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@mediatypes, Mediatype)
  end

  def test_validation
    validate_test(@mediatypes, Mediatype)
  end

  def test_collision
    collision_test(@mediatypes, Mediatype)
  end

  def test_create_with_empty_attributes
    @mymediatype= Mediatype.new
    assert !@mymediatype.save
  end

  def test_check_uniqueness
    @mymediatype = Mediatype.new({:name => 'Impreso'})
    assert !@mymediatype.save
  end

  # Boundaries
  def test_bad_values_for_id
    @mymediatype = Mediatype.new
    @mymediatype.id = 'xx'
    assert !@mymediatype.valid?

    # Negative number ID
    #@mymediatype.id = -1
    #assert !@mymediatype.valid?

    # Float number ID
    @mymediatype.id = 1.3
    assert !@mymediatype.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    @mymediatype= Mediatype.new
    @mymediatype.name = nil
    assert !@mymediatype.valid?
  end

end
