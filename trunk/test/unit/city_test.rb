require File.dirname(__FILE__) + '/../test_helper'
require 'state'
require 'city'
class CityTest < Test::Unit::TestCase
  fixtures  :states, :cities
  include UnitSimple

  def setup
    @cities = %w(culiacan monterrey)
    @mycity = City.new({:name => 'Ciudad de México', :state_id => 9})
  end

  def test_creating_records_from_yaml
    @cities.each { | city|
      @city = City.find(cities(city.to_sym).id)
      assert_kind_of City, @city
      assert_equal cities(city.to_sym).id, @city.id
      assert_equal cities(city.to_sym).name, @city.name
      assert_equal cities(city.to_sym).state_id, @city.state_id
    }
  end

  def test_updating_name
    @cities.each { |city|
      @city = City.find(cities(city.to_sym).id)
      assert_equal cities(city.to_sym).name, @city.name
      @city.name = @city.name.chars.reverse
      assert @city.update
      assert_not_equal cities(city.to_sym).name, @city.name
    }
  end

  def test_deleting
    @cities.each { |city|
      @city = City.find(cities(city.to_sym).id)

      @city.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        City.find(cities(city.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @city = City.new({:name => 'Culiacán', :state_id => 25 })
    assert !@city.save
  end

  def test_empty_object
    @city = City.new()
    assert !@city.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mycity.id = 1.6
    assert !@mycity.valid?
    @mycity.id = 'mi_id'
    assert !@mycity.valid?
  end

  def test_bad_values_for_name
    @mycity.name = nil
    assert !@mycity.valid?
  end

  def test_bad_values_for_state_id
    @mycity.state_id = nil
    assert !@mycity.valid?
    @mycity.state_id= 1.6
    assert !@mycity.valid?
    @mycity.state_id = 'mi_id'
    assert !@mycity.valid?

    # Negative number ID
    #@city.state_id = -1
    #assert !@city.valid?
  end

  #cross check for state
  def test_cross_checking_for_state_id
    @cities.each { | city|
      @city = City.find(cities(city.to_sym).id)
      assert_kind_of City, @city
      assert_equal @city.state_id, State.find(@city.state_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_state_id
    @cities.each { | city|
      @city = City.find(cities(city.to_sym).id)
      assert_kind_of City, @city
      @city.state_id = 20

      begin
        return true if @state.update
      rescue StandardError => x
        return false
      end
    }
  end

end
