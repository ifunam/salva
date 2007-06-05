require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'indivadviceprogram'

class IndivadviceprogramTest < Test::Unit::TestCase
fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes, :institutions, :indivadviceprograms

  def setup
    @indivadviceprograms = %w(paas pidi pappit)
    @myindivadviceprogram = Indivadviceprogram.new({:name => 'PAIIS', :institution_id => 96})
  end
  
  # Right - CRUD
  def test_creating_from_yaml
    @indivadviceprograms.each { | indivadviceprogram|
      @indivadviceprogram = Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id)
      assert_kind_of Indivadviceprogram, @indivadviceprogram
      assert_equal indivadviceprograms(indivadviceprogram.to_sym).id, @indivadviceprogram.id
      assert_equal indivadviceprograms(indivadviceprogram.to_sym).name, @indivadviceprogram.name
      assert_equal indivadviceprograms(indivadviceprogram.to_sym).institution_id, @indivadviceprogram.institution_id	
     }
  end
  
  def test_updating_indivadviceprograms_name
    @indivadviceprograms.each { |indivadviceprogram|
      @indivadviceprogram = Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id)
      assert_equal indivadviceprograms(indivadviceprogram.to_sym).name, @indivadviceprogram.name
      @indivadviceprogram.name = @indivadviceprogram.name.chars.reverse 
      assert @indivadviceprogram.update
      assert_not_equal indivadviceprograms(indivadviceprogram.to_sym).name, @indivadviceprogram.name
    }
  end  

  def test_deleting_indivadviceprograms
    @indivadviceprograms.each { |indivadviceprogram|
      @indivadviceprogram = Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id)
      @indivadviceprogram.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
      Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @indivadviceprogram = Indivadviceprogram.new
     assert !@indivadviceprogram.save
   end

   def test_creating_duplicated_indivadviceprogram
     @indivadviceprogram = Indivadviceprogram.new({:name => 'PAAS', :institution_id => 96})
     assert !@indivadviceprogram.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @myindivadviceprogram.id = 1.6
     assert !@myindivadviceprogram.valid?
     @myindivadviceprogram.id = 'mi_id_texto'
     assert !@myindivadviceprogram.valid?
   end

   def test_bad_values_for_name
     @myindivadviceprogram.name = nil
     assert !@myindivadviceprogram.valid?

     @myindivadviceprogram.name = 'A' 
     assert !@myindivadviceprogram.valid?

     @myindivadviceprogram.name = 'AB' * 800
     assert !@myindivadviceprogram.valid?
   end


      # Checking constraints for institution_id
   def test_bad_values_for_institution_id
     @myindivadviceprogram.institution_id = nil
     assert !@myindivadviceprogram.valid?
     @myindivadviceprogram.institution_id = 3.1416
     assert !@myindivadviceprogram.valid?
     @myindivadviceprogram.institution_id = 'mi_id_texto'
     assert !@myindivadviceprogram.valid?
   end
    
   #Cross-Checking test for institution_id
 def test_cross_checking_for_institution_id
    @indivadviceprograms.each { | indivadviceprogram|
      @indivadviceprogram = Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id)
      assert_kind_of Indivadviceprogram, @indivadviceprogram
      assert_equal @indivadviceprogram.institution_id, Institution.find(@indivadviceprogram.institution_id).id 
    }
 end 

 def catch_exception_when_update_invalid_key(record)
   begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
end

 def test_cross_checking_with_bad_values_for_institution_id
   
 @indivadviceprograms.each { | indivadviceprogram|
      @indivadviceprogram = Indivadviceprogram.find(indivadviceprograms(indivadviceprogram.to_sym).id)
      assert_kind_of Indivadviceprogram, @indivadviceprogram
     @indivadviceprogram.institution_id = 500000
     begin 
            return true if @indivadviceprogram.update
     rescue StandardError => x
            return false
     end
   }
 end

end
