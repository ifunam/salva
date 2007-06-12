require File.dirname(__FILE__) + '/../test_helper'
require 'addresstype'

class AddresstypeTest < Test::Unit::TestCase
  fixtures :addresstypes
  include UnitSimple

  def setup
    @addresstypes = %w(domicilio_particular  domicilio_profesional  domicilio_temporal)
    @myaddresstypes = Addresstype.new({:name => 'DomicilioConocido',:id => 5})
  end

  # Right - CRUD
  def test_crud
      crud_test(@addresstypes, Addresstype)
  end

  def test_validation
     validate_test(@addresstypes, Addresstype)
  end

  def test_collision
     collision_test(@addresstypes, Addresstype)
  end

   def test_creating_with_empty_attributes
     @addresstype = Addresstype.new
     assert !@addresstype.save
   end

   def test_uniqueness
    @myaddresstypes = Addresstype.new({:name => 'Domicilio Particular', })
    @myaddresstypes.id = 1
     assert !@myaddresstypes.save
   end


   # Boundary

   def test_bad_values_for_id
     # Float number for ID
     @myaddresstypes.id = 1.6
     assert !@myaddresstypes.valid?

        # Negative numbers
       # @myaddresstypes.id = -1
      # assert !@myaddresstypes.valid?
    end

   def test_bad_values_for_name
     @myaddresstypes.name = nil
     assert !@myaddresstypes.valid?

     @myaddresstypes.name = 'A'
     assert !@myaddresstypes.valid?

     @myaddresstypes.name = 'AB' * 800
     assert !@myaddresstypes.valid?
   end
end
