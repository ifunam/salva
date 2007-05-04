require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller/base'
require 'stackcontroller'
require 'person'
require 'country'
require 'stack_of_controller'
#require 'action_controller/test_process'
#require 'model_sequence'
#require 'schooling'
#require 'professionaltitle'


class StackControllerTest < Test::Unit::TestCase

  fixtures :userstatuses, :users, :countries, :states, :cities, :maritalstatuses, :people

  include Stackcontroller
  def setup
    @controller = PersonController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_have_a_empty_stack
    deny is_model_in_stack?, "the stack should be empty"
  end

  # Sintax for submit_for_stack method    
  def test_simple_options_for_stack
    controller, attribute = set_options('state', {:state_id => 22,  :country_id => 484})
    assert_equal controller, 'state'
  end
  

  def test_complex_options_for_redirect_action_using_an_id
    controller, attribute, id = set_options('state:country_id', {:state_id => 22,  :country_id => 484})
    assert_equal controller, 'state'
    assert_equal attribute, 'state_id'
    assert_equal id, 484
  end

  def test_options_with_a_predefined_id_for_the_next_controller
    controller, attribute, id = set_options('state:country_id', {:state_id => 22,  :country_id => 484})
    assert_equal controller, 'state'
    assert_equal attribute, 'state_id'
    assert_equal id, 484
  end

  def test_options_for_next_controller_with_diferent_local_attribute
    controller, attribute = set_options('outreachwork,genericwork_id', {:state_id => 22,  :country_id => 484})
    assert_equal controller, 'outreachwork'
    assert_equal attribute, 'genericwork_id'
  end
  
  def test_should_redirect_from_person_edit_to_state_new
    @person = Person.find_by_firstname('Juana')
    options = options_for_next_controller(@person,'person','edit',
                                          { :firstname => 'Juanita', 
                                            :country_id => 484 }, 
                                          'state:country_id')
    assert_equal options[:controller], 'state'
    assert_equal options[:action], 'new'
    assert_equal options[:id], @person.country_id
  end

  def test_should_return_from_state_new_to_person_edit
    @person = Person.find_by_firstname('Juana') 
    # Revisar bug: Si edito los datos y uso el stack para moverme a otro
    # formulario, es posible que los datos modificados no regresen.
    options = options_for_next_controller(@person,'person','edit',
                                          { :firstname => 'Juanita', 
                                            :country_id => 485 }, 
                                          'state:country_id')
    @controller = StateController.new
    update_model_attribute_in_stack(19)
    #    puts @controller.controller_name
    rc_options = options_for_return_controller
    assert_equal rc_options[:controller], 'person'
    assert_equal rc_options[:action], 'edit'

    @controller = PersonController.new
    @person_from_stack = model_from_stack

    assert_equal @person_from_stack.firstname, 'Juana'
    assert_equal @person_from_stack.state_id, 19
    assert_equal @person_from_stack.country_id, 484
  end
end
