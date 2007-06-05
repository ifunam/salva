require File.dirname(__FILE__) + '/../test_helper'
require 'thesisstatus'

class ThesisstatusTest < Test::Unit::TestCase
  fixtures :thesisstatuses
  include UnitSimple
  
  def setup
    @thesisstatus = %w(aprobada publicada en_proceso)
    @mythesisstatus = Thesisstatus.new({:name => 'semiaprobada'})
  end

   #Right - CRUD
   def test_crud 
     crud_test(@thesisstatus, Thesisstatus)
   end

   def test_validation
     validate_test(@thesisstatus, Thesisstatus)
   end

   def test_collision
     collision_test(@thesisstatus, Thesisstatus)
   end

   def test_create_with_empty_attributes
     @thesisstatus = Thesisstatus.new
     assert !@thesisstatus.save
   end

   def test_check_uniqueness
     @thesisstatus = Thesisstatus.new({:name => 'Aprobada'})
     @thesisstatus.id= 1
     assert !@thesisstatus.save
   end
# boundary
# Checking constraints for name
  def test_bad_values_for_name
     @mythesisstatus.name = nil
     assert !@mythesisstatus.valid?

     @mythesisstatus.name = 'X'
     assert !@mythesisstatus.valid?

     @mythesisstatus.name = 'X' * 201
     assert !@mythesisstatus.valid?

     @mythesisstatus.name = '5' 
     assert !@mythesisstatus.valid?
  end
   
   # Checking constraints for ID
   def test_bad_values_for_id
     @mythesisstatus.id = 'xx'
     assert !@mythesisstatus.valid?

     @mythesisstatus.id = nil
     assert !@mythesisstatus.valid?

     @mythesisstatus.id = 3.1416
     assert !@mythesisstatus.valid?
  end

	end
