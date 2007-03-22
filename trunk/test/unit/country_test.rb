require File.dirname(__FILE__) + '/../test_helper'
require 'country'

class CountryTest < Test::Unit::TestCase
  fixtures :countries

  def setup
    @countries = %w(mexico japan ukrania)
  end
  
  # Right - CRUD
  def test_created_countries_from_yaml
    @countries.each { | country|
      @country = Country.find(countries(country.to_sym).id)
      assert_kind_of Country, @country
      assert_equal countries(country.to_sym).id, @country.id
      assert_equal countries(country.to_sym).name, @country.name
    }
  end
  
  def test_update_countries_name
    @countries.each { |country|
      @country = Country.find(countries(country.to_sym).id)
      assert_equal countries(country.to_sym).name, @country.name
      @country.name = @country.name.chars.reverse 
      assert @country.update
      assert_not_equal countries(country.to_sym).name, @country.name
    }
  end  

  def test_delete_countries
    @countries.each { |country|
      @country = Country.find(countries(country.to_sym).id)
      @country.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Country.find(countries(country.to_sym).id) 
      }
    }
  end 

   def test_create_with_empty_attributes
     @country = Country.new
     assert !@country.save
   end

   def test_create_duplicated_country
     @country = Country.new({:name => 'México', :citizen => 'Mexicana', :code =>'MX'})
     @country.id = 484
     assert !@country.save
   end

   # Boundary
   def test_validate_countries_with_bad_values

     # Checking constraints for ID
     @country = Country.new({:name => 'China', :citizen => 'China', :code => 'CH'})

     # Non numeric ID 
     @country.id = 'xx'
     assert !@country.valid?
     # Nil ID 
     @country.id = nil
     assert !@country.valid?
     # Negative number ID 
     @country.id = -1
     assert !@country.valid?
     # Very large number for ID 
     @country.id = 10000
     assert !@country.valid?

     @country.id = 999
     # Checking constraints for name and citizen
     # Nil name
     @country.name = nil
     assert !@country.valid?
     @country.name = 'China'

     # Nil citizen
     @country.citizen = nil
     assert !@country.valid?
     @country.citizen = 'China'

     # Checking constraints for code
     # Nil code
     @country.code = nil
     assert !@country.valid?
     # Very shot code
     @country.code = 'C'
     assert !@country.valid?
     # Very large code
     @country.code = 'CHCHCHCH'
     assert !@country.valid?
   end

end

