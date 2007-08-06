require File.dirname(__FILE__) + '/../test_helper'
require 'volume'

class VolumeTest < Test::Unit::TestCase
  fixtures :volumes
  include UnitSimple

  def setup
    @volumes = %w(i ii iii)
    @myvolume = Volume.new({:name => 'III'})
  end

  # Right - CRUD
  def test_crud
    crud_test(@volumes, Volume)
  end

  def test_validation
    validate_test(@volumes, Volume)
  end

  def test_collision
    collision_test(@volumes, Volume)
  end

  def test_create_with_empty_attributes
    @volume = Volume.new
    assert !@volume.save
  end

  def test_check_uniqueness
    @volume = Volume.new({:name => 'IV'})
    assert @volume.save
    @volume2 = Volume.new({:name => 'IV'  })
    assert !@volume2.save
  end
  # Boundaries
  def test_bad_values_for_id
    @myvolume.id = 'xx'
    assert !@myvolume.valid?

    # Negative number ID
    #@myvolume.id = -1
    #assert !@myvolume.valid?

    # Float number ID
    @myvolume.id = 1.3
    assert !@myvolume.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myvolume = Volume.new
    @myvolume.name = nil
    assert !@myvolume.valid?
  end
end
