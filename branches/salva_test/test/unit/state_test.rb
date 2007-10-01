require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
class StateTest < Test::Unit::TestCase
  fixtures :countries, :states

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
      assert_equal states(state.to_sym).country_id, @state.country_id
    }
  end

  def test_updating_name
    @states.each { |state|
      @state = State.find(states(state.to_sym).id)
      assert_equal states(state.to_sym).name, @state.name
      @state.name = @state.name.chars.reverse
      assert @state.save
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
    @state = State.new({:name => 'Sinaloa', :country_id => 484,
                         :code => 'Sin'})
    assert !@state.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mystate.id = 1.6
    assert !@mystate.valid?
    @mystate.id = 'mi_id'
    assert !@mystate.valid?
  end

  def test_bad_values_for_name
    @mystate.name = nil
    assert !@mystate.valid?
  end

  def test_bad_values_for_country_id
    @mystate.country_id = nil
    assert !@mystate.valid?
    @mystate.country_id= 1.6
    assert !@mystate.valid?
    @mystate.country_id = 'mi_id'
    assert !@mystate.valid?

    # Negative number ID
    #@state.country_id = -1
    #assert !@state.valid?
  end

  #cross check for country
  def test_cross_checking_for_country_id
    @states.each { | state|
      @state = State.find(states(state.to_sym).id)
      assert_kind_of State, @state
      assert_equal @state.country_id, Country.find(@state.country_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_country_id
    @states.each { | state|
      @state = State.find(states(state.to_sym).id)
      assert_kind_of State, @state
      @state.country_id = 20

      begin
        return true if @state.save
      rescue StandardError => x
        return false
      end
    }
  end

end
