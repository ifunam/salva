require File.dirname(__FILE__) + '/../test_helper'
require 'credential'


class CredentialTest < Test::Unit::TestCase
  fixtures :credentials
  include UnitSimple

  def setup
    @credentials = %w(pasante sr tec)
  end
  
  # Right - CRUD  
   def test_crud 
     crud_test(@credentials, Credential)
   end

   def test_validation
     validate_test(@credentials, Credential)
   end

   def test_collision
     collision_test(@credentials, Credential)
   end

   def test_create_with_empty_attributes
     @mycredential = Credential.new
     assert !@mycredential.save
   end

   def test_check_uniqueness
     @mycredential = Credential.new({:name => 'Pasante'})
     assert !@mycredential.save
   end

   # Boundaries
   def test_bad_values_for_id
    @mycredential = Credential.new
    @mycredential.id = 'xx'
    assert !@mycredential.valid?

    # Negative number ID 
    #@mycredential.id = -1
    #assert !@mycredential.valid?

    # Float number ID 
    @mycredential.id = 1.3
    assert !@mycredential.valid?

    # Very large number for ID 
    @mycredential.id = 10000
    assert !@mycredential.valid?

    # Nil number ID 
    @mycredential.id = nil
    assert !@mycredential.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @mycredential = Credential.new
    @mycredential.name = nil
    assert !@mycredential.valid?
  end

 
end
