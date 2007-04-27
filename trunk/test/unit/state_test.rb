require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
class StateTest < Test::Unit::TestCase
  fixtures :countries, :states
  include UnitSimple
  
  def setup
    @states = %w(sinaloa nuevo_leon)
    @mystate = State.new({:name => 'Oaxaca', :country_id => 484, :code => 'OAX'})
  end
  
  # Right - CRUD
  def test_creating_records_from_yaml
    @states.each { | state|
      @state = State.find(states(state.to_sym).id)
      assert_kind_of State, @state
      assert_equal states(state.to_sym).id, @state.id
      assert_equal states(state.to_sym).name, @state.name
    }
  end
  
  def test_updating_name
    @states.each { |state|
      @state = State.find(states(state.to_sym).id)
      assert_equal states(state.to_sym).name, @state.name
      @state.name = @state.name.chars.reverse 
      assert @state.update
      assert_not_equal states(state.to_sym).name, @state.name
    }
  end  

  def test_deleting_states
    @states.each { |state|
      @state = State.find(states(state.to_sym).id)
      @state.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        State.find(states(state.to_sym).id) 
      }
    }
  end 

   def test_create_with_empty_attributes
     @state = State.new
     assert !@state.save
   end

   def test_uniqueness
     @state = State.new({:name => 'Chipas', :country_id => 484,
                              :code => 'CHIS'})
     @state.id = 484
     assert !@state.save
   end


   # Boundary
   def test_validate_states_with_bad_values

     # Checking constraints for ID
     @state = State.new({:name => 'Chiapas', :code => nil, :country_id => 484})

     # Non numeric ID 
     @state.country_id = 'xx'
     assert !@state.valid?
     # Nil ID 
     @state.country_id = nil
     assert !@state.valid?
     # Negative number ID 
     @state.country_id = -1
     assert !@state.valid?
     # Very large number for ID 
     @state.id = 10000
     assert !@state.valid?

     @state.id = 999
     # Checking constraints for name
     # Nil name
     @state.name = nil
     assert !@state.valid?
     @state.name = 'Chiapas'
   end

   def test_check_uniqueness
     @state = State.new({:name => 'Chiapas', :code => nil, :country_id => 484})
     assert @state.save

     @state2 = State.new({:name => 'Chiapas', :code => nil, :country_id => 484})
     assert !@state2.save
   end
end
