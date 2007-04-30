require File.dirname(__FILE__) + '/../test_helper'
require 'person'
require 'country'
require 'model_sequence'
require 'schooling'
require 'professionaltitle'
class StackTest < Test::Unit::TestCase
  fixtures :countries

  def setup
    @stack = StackOfController.new
  end
  
  def test_should_push_model_into_stack
    assert @stack.push(Person.new, 'new', 'country_id')
    assert_equal @stack.model.class, Person
    assert_equal @stack.return_controller, 'person'
    assert_equal @stack.action, 'new'
    assert_equal @stack.attribute, 'country_id'
    assert_equal @stack.previus_controller, 'country'
    @stack.set_attribute(484)
    assert_equal @stack.value, 484
    @stack.pop 
    assert @stack.empty?
  end
  
  def test_should_add_error_with_an_invalid_attribute
    deny @stack.push(Person.new, 'new', 'country'), "The attribute should have been invalid"
  end
  
  def test_should_push_modelsecuence_into_stack
    assert @stack.push(ModelSequence.new([Schooling, Professionaltitle]), 'new', 'institutioncareer_id')
    assert_equal @stack.model.class, ModelSequence
    assert_equal @stack.return_controller, 'wizard'
    assert_equal @stack.action, 'new'
    assert_equal @stack.attribute, 'institutioncareer_id'
    assert_equal @stack.previus_controller, 'institutioncareer'
    @stack.pop
    assert @stack.empty?
  end
  
  def test_should_pop_model_from_stack
    assert @stack.push(Person.new, 'new', 'country_id')
    assert @stack.pop
    deny @stack.pop, "The stack should be empty"
    assert @stack.empty?
  end

  def test_should_get_and_pop_model_from_stack
    assert @stack.push(Person.new, 'new', 'country_id')
    assert_kind_of Person, @stack.pop_model
    deny @stack.pop, "The stack should be empty"
    assert @stack.empty?
  end
  
  def test_should_clear_model_from_stack
    assert @stack.push(Person.new, 'new', 'country_id')
    assert @stack.clear
    assert @stack.empty?
  end

  def test_should_get_default_value_from_current_model
    @country = Country.find(484)
    @stack.push(@country, 'show', 'id')
    assert_equal @stack.return_controller, 'country'
    assert_equal @stack.action, 'show'
    assert_equal @stack.attribute, 'id'
    assert_equal @stack.value, 484
    @stack.clear 
    assert @stack.empty?
  end

   def test_checking_inclusion_of_controller
     assert @stack.push(ModelSequence.new([Schooling, Professionaltitle]), 'new', 'institutioncareer_id')
     assert @stack.push(Institutioncareer.new, 'new', 'institution_id')
     assert @stack.push(Institution.new, 'new', 'institution_id')
     assert @stack.include_controller?('wizard')
     assert @stack.include_controller?('institutioncareer')
     assert @stack.include_controller?('institution')
     assert_equal @stack.previus_controller, 'institution'

     assert !@stack.include_controller?('unexistent_return_controller')
     @stack.clear
     assert @stack.empty?
   end

   def test_deleting_items_after_an_specific_controller_name
     assert @stack.push(ModelSequence.new([Schooling, Professionaltitle]), 'new', 'institutioncareer_id')
     assert @stack.push(Institutioncareer.new, 'new', 'institution_id')
     assert @stack.push(Institution.new, 'new', 'institution_id')
     assert @stack.push(Career.new, 'new', 'degree_id')
     assert_equal @stack.size, 4
     @stack.delete_after_controller('institutioncareer')
     assert_equal @stack.size, 2
     assert_equal @stack.return_controller, 'institutioncareer'
     assert_equal @stack.previus_controller, 'institution'
     @stack.clear
     assert @stack.empty?
   end
end
