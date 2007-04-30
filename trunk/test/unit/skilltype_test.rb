require File.dirname(__FILE__) + '/../test_helper'
require 'skilltype'


class SkilltypeTest < Test::Unit::TestCase
  fixtures :skilltypes
  include UnitSimple

  def setup
    @skilltypes = %w(tocar_piano comer_galletitas ir_al_trono)
    @myskilltype = Skilltype.new
  end
  
  # Right - CRUD  
   def test_crud 
     crud_test(@skilltypes, Skilltype)
   end

   def test_validation
     validate_test(@skilltypes, Skilltype)
   end

   def test_collision
     collision_test(@skilltypes, Skilltype)
   end

   def test_create_with_empty_attributes
     @myskilltype = Skilltype.new
     assert !@myskilltype.save
   end

   def test_check_uniqueness
     @myskilltype2 = Skilltype.new({:name => 'para ir al trono'})
     assert !@myskilltype2.save
   end

   # Boundaries
   def test_bad_values_for_id
    @myskilltype.id = 'xx'
    assert !@myskilltype.valid?

    # Negative number ID 
    @myskilltype.id = -1
    assert !@myskilltype.valid?
     
     # Float number ID 
    @myskilltype.id = 1.3
     assert !@myskilltype.valid?
     
     # Very large number for ID 
     @myskilltype.id = 10000
     assert !@myskilltype.valid?
     
     # Nil number ID 
     @myskilltype.id = nil
     assert !@myskilltype.valid?
  end
   
  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myskilltype.name = nil
    assert !@myskilltype.valid?
  end

 
end
