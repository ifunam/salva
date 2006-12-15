require File.dirname(__FILE__) + '/../test_helper'
require 'mediatype'

class MediatypeTest < Test::Unit::TestCase
  fixtures :mediatypes
  include UnitSimple

  def setup
    @mediatype = %w(printed electronic)
  end

  def test_crud 
    crud_test(@mediatype, Mediatype)
  end

  def test_validation
    validate_test(@mediatype, Mediatype)
  end

  def test_collision
    collision_test(@mediatype, Mediatype)
  end
end
