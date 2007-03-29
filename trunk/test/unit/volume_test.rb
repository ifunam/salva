require File.dirname(__FILE__) + '/../test_helper'
require 'volume'

class VolumeTest < Test::Unit::TestCase
  fixtures :volumes
  include UnitSimple
  
  def setup
    @volumes = %w(i ii iii)
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
end
