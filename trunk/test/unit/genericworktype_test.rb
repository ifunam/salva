require File.dirname(__FILE__) + '/../test_helper'
require 'genericworkgroup'
require 'genericworktype'

class GenericworktypeTest < Test::Unit::TestCase
  fixtures :genericworkgroups, :genericworktypes

  def setup
    @genericworktypes = %w(cuadernos catalogos impresos)
    @mygenericworktype = Genericworktype.new({:name => 'Antología', :genericworkgroup_id => 4})
  end
  
  # Right - CRUD
  def test_creating_genericworktypes_from_yaml
    @genericworktypes.each { | genericworktype|
      @genericworktype = Genericworktype.find(genericworktypes(genericworktype.to_sym).id)
      assert_kind_of Genericworktype, @genericworktype
      assert_equal genericworktypes(genericworktype.to_sym).id, @genericworktype.id
      assert_equal genericworktypes(genericworktype.to_sym).name, @genericworktype.name
      assert_equal genericworktypes(genericworktype.to_sym).genericworkgroup_id, @genericworktype.genericworkgroup_id
    }
  end
  
  def test_updating_genericworktypes_name
    @genericworktypes.each { |genericworktype|
      @genericworktype = Genericworktype.find(genericworktypes(genericworktype.to_sym).id)
      assert_equal genericworktypes(genericworktype.to_sym).name, @genericworktype.name
      @genericworktype.name = @genericworktype.name.chars.reverse 
      assert @genericworktype.update
      assert_not_equal genericworktypes(genericworktype.to_sym).name, @genericworktype.name
    }
  end  

  def test_deleting_genericworktypes
    @genericworktypes.each { |genericworktype|
      @genericworktype = Genericworktype.find(genericworktypes(genericworktype.to_sym).id)
      @genericworktype.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Genericworktype.find(genericworktypes(genericworktype.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @genericworktype = Genericworktype.new
     assert !@genericworktype.save
   end

   def test_creating_duplicated_genericworktype
     @genericworktype = Genericworktype.new({:name => 'Catálogos', :genericworkgroup_id => 4})
     @genericworktype.id = 1
     assert !@genericworktype.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @mygenericworktype.id = 1.6
     assert !@mygenericworktype.valid?
   end

   def test_bad_values_for_name
     @mygenericworktype.name = nil
     assert !@mygenericworktype.valid?

     @mygenericworktype.name = 'AB' 
     assert !@mygenericworktype.valid?

     @mygenericworktype.name = 'AB' * 800
     assert !@mygenericworktype.valid?
   end

   def test_bad_values_for_genericworkgroup_id
     # Checking constraints for name
     # Nil name
     @mygenericworktype.genericworkgroup_id = nil
     assert !@mygenericworktype.valid?

     @mygenericworktype.genericworkgroup_id = 3.1416
     assert !@mygenericworktype.valid?
   end
   #Cross-Checking test
 
 def test_cross_checking_for_genericworkgroup_id
   @genericworktypes.each { | genericworktype|
      @genericworktype = Genericworktype.find(genericworktypes(genericworktype.to_sym).id)
      assert_kind_of Genericworktype, @genericworktype
      assert_equal @genericworktype.genericworkgroup_id, Genericworkgroup.find(@genericworktype.genericworkgroup_id).id 
    }
 end 


 def catch_exception_when_update_invalid_key(record)
   begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
end

 def test_cross_checking_with_bad_values_for_genericworkgroup_id
   @genericworktypes.each { | genericworktype|
     @genericworktype = Genericworktype.find(genericworktypes(genericworktype.to_sym).id)
     assert_kind_of Genericworktype, @genericworktype
     @genericworktype.genericworkgroup_id = 10
     begin 
            return true if @genericworktype.update
     rescue StandardError => x
            return false
     end
   }
 end
end
