require File.dirname(__FILE__) + '/../test_helper'
require 'languagelevel'

class LanguagelevelTest < Test::Unit::TestCase
  fixtures :languagelevels
  include UnitSimple
  
  def setup
    @languagelevels = %w(basico intermedio avanzado)
  end

  # Right - CRUD
   def test_crud 
     crud_test(@languagelevels, Languagelevel)
   end

   def test_validation
     validate_test(@languagelevels, Languagelevel)
   end

   def test_collision
     collision_test(@languagelevels, Languagelevel)
   end

   def test_creating_languagelevel_with_empty_attributes
     @languagelevel = Languagelevel.new
     assert !@languagelevel.save
   end

   def test_checking_uniqueness
     @languagelevel = Languagelevel.new({:name => 'Hiperavanzado'})
     assert @languagelevel.save

     @languagelevel2 = Languagelevel.new({:name => 'Hiperavanzado'})
     assert !@languagelevel2.save
   end

   def test_validating_languagelevels_with_bad_values	
     @languagelevel = Languagelevel.new({:name => 'superavanzado'})

     #Non numeric ID --> Valid because the ID is a serial number
     @languagelevel.id = nil
     assert @languagelevel.valid?
     
     #Nil ID 
     @languagelevel.name = nil
     assert !@languagelevel.valid?

     #Negative number 
     @languagelevel.id = -5

     assert !@languagelevel.valid?

     #Negative number ID 
     @languagelevel.id= 1.8
     assert !@languagelevel.valid?
   end   
end
 
