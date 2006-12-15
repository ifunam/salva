require File.dirname(__FILE__) + '/../test_helper'
require 'publisher'

class PublisherTest < Test::Unit::TestCase
  fixtures :publishers
  include UnitSimple

  def setup
    @publisher = %w(ak_peters noble)
  end

  def test_crud 
    crud_test(@publisher, Publisher)
  end

  def test_validation
    validate_test(@publisher, Publisher)
  end

  def test_collision
    collision_test(@publisher, Publisher)
  end
end
