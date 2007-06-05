require File.dirname(__FILE__) + '/../test_helper'
require 'language'

class LanguageTest < Test::Unit::TestCase
  fixtures :languages

  def setup
    @languages= %w(portugues ingles espanol)
    @mylanguage = Language.new({:name => 'Chino'})
  end
  
  # Right - CRUD
  def test_creating_languages_from_yaml
    @languages.each { | language|
      @language = Language.find(languages(language.to_sym).id)
      assert_kind_of Language, @language
      assert_equal languages(language.to_sym).id, @language.id
      assert_equal languages(language.to_sym).name, @language.name
    }
  end
  
  def test_creating_languages
    @languages.each { |language|
      @language = Language.find(languages(language.to_sym).id)
      assert_equal languages(language.to_sym).name, @language.name
      @language.name = @language.name.chars.reverse 
      assert @language.update
      assert_not_equal languages(language.to_sym).name, @language.name
    }
  end  

  def test_deleting_languages
    @languages.each { |language|
      @language = Language.find(languages(language.to_sym).id)
      @language.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Language.find(languages(language.to_sym).id) 
      }
    }
  end 

   def test_create_with_empty_attributes
     @language = Language.new
     assert !@language.save
   end

   
   #validates uniqueness
   def test_uniqueness
     @language = Language.new({:name => 'Inglés'})
     @language.id = 2
     assert !@language.save
   end

   ##############
   # Boundary   #
   ##############
   
   # Checking constraints for name
   def test_bad_values_for_name
     @mylanguage.name = nil
     assert !@mylanguage.valid?

     @mylanguage.name = 'X'
     assert !@mylanguage.valid?

     @mylanguage.name = 'X' * 201
     assert !@mylanguage.valid?

     @mylanguage.name = '5' 
     assert !@mylanguage.valid?
  end
   
   # Checking constraints for ID
   def test_bad_values_for_id
     @mylanguage.id = 'xx'
     assert !@mylanguage.valid?

     @mylanguage.id = nil
     assert !@mylanguage.valid?

     @mylanguage.id = 3.1416
     assert !@mylanguage.valid?

     @mylanguage.id = -7
     assert !@mylanguage.valid?
  end
end

