require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
require 'city'
require 'addresstype'
require 'user'


class AddressTest < Test::Unit::TestCase
  fixtures [:userstatuses,:users,:countries, :states, :cities, :addresstypes, :addresses]

  def setup
    @addresses = %w(juana_en_fisica)
    @myaddress = Address.new({:user_id => 1,  :location => "Tajín No. 634, Int 1, Col. Letrán Valle, Delegación Benito Juárez",
      :zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  1, :is_postaddress=> true})

  end

#  Right - CRUD
  def test_creating_addresss_from_yaml
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal addresses(address.to_sym).id, @address.id
      assert_equal addresses(address.to_sym).location, @address.location
      assert_equal addresses(address.to_sym).user_id, @address.user_id
      assert_equal addresses(address.to_sym).state_id, @address.state_id
      assert_equal addresses(address.to_sym).country_id, @address.country_id
      assert_equal addresses(address.to_sym).city_id, @address.city_id
      assert_equal addresses(address.to_sym).addresstype_id, @address.addresstype_id

    }
  end

   def test_updating_addresss_name
     @addresses.each { |address|
       @address = Address.find(addresses(address.to_sym).id)
       assert_equal addresses(address.to_sym).location, @address.location
       @address.location = @address.location.chars.reverse
       assert @address.save
       assert_not_equal addresses(address.to_sym).location, @address.location
     }
   end

  def test_deleting_addresss
    @addresses.each { |address|
      @address = Address.find(addresses(address.to_sym).id)
      @address.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Address.find(addresses(address.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @address = Address.new
    assert !@address.save
  end

  def test_creating_duplicated_address
    @address = Address.new({:user_id => 2, :location => "Tajín No. 634, Int 1, Col. Letrán Valle, Delegación Benito Juárez",
      :zipcode => 03650,  :country_id => 484,  :state_id => 9,  :city_id => 64,  :addresstype_id =>  1, :is_postaddress=> true, :id => 1})
    assert !@address.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myaddress.id = 1.6
    assert !@myaddress.valid?
    @myaddress.id = 'mi_id'
    assert !@myaddress.valid?
  end

  def test_bad_values_for_name
    # Float number for ID

    @myaddress.location = nil
    assert !@myaddress.valid?
  end

  def test_bad_values_for_addressuser_id
    @myaddress.user_id = nil
    assert !@myaddress.valid?
    @myaddress.user_id= 1.6
    assert !@myaddress.valid?
    @myaddress.user_id = 'mi_id'
    assert !@myaddress.valid?
  end

  def test_bad_values_for_addresstype_id
    @myaddress.addresstype_id = nil
    assert !@myaddress.valid?
    @myaddress.addresstype_id = 1.6
    assert !@myaddress.valid?
    @myaddress.addresstype_id = 'mi_id'
    assert !@myaddress.valid?
  end

  def test_bad_values_for_country_id
    @myaddress.country_id = nil
    assert !@myaddress.valid?
    @myaddress.country_id= 1.6
    assert !@myaddress.valid?
    @myaddress.country_id = 'mi_id'
    assert !@myaddress.valid?
  end

def test_bad_values_for_state_id
    @myaddress.state_id = nil
    assert !@myaddress.valid?
    @myaddress.state_id= 1.6
    assert !@myaddress.valid?
    @myaddress.state_id = 'mi_id'
    assert !@myaddress.valid?
  end

def test_bad_values_for_country_id
    @myaddress.city_id = nil
    assert !@myaddress.valid?
    @myaddress.city_id= 1.6
    assert !@myaddress.valid?
    @myaddress.city_id = 'mi_id'
    assert !@myaddress.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_address_user_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal @address.user_id, User.find(@address.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_addressuser_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      @address.user_id = 50
      begin
        return true if @address.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for addresstype
  def test_cross_checking_for_addresstype_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal @address.addresstype_id, Addresstype.find(@address.addresstype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_addresstype_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      @address.addresstype_id = 20
      begin
        return true if @address.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for country
  def test_cross_checking_for_country_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal @address.country_id, Country.find(@address.country_id).id
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
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      @address.country_id = 20
      begin
        return true if @address.save
      rescue StandardError => x
        return false
      end
    }
  end

 #cross check for state_id
  def test_cross_checking_for_state_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal @address.state_id, State.find(@address.state_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_state_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      @address.state_id = 500000
      begin
        return true if @address.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for city_id
  def test_cross_checking_for_city_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      assert_equal @address.city_id, City.find(@address.city_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_state_id
    @addresses.each { | address|
      @address = Address.find(addresses(address.to_sym).id)
      assert_kind_of Address, @address
      @address.city_id = 500000
      begin
        return true if @address.save
      rescue StandardError => x
        return false
      end
    }
  end
end
