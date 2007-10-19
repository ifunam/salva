require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'country'
require 'person'

class PersonTest < Test::Unit::TestCase
  fixtures   :countries, :states, :cities, :maritalstatuses, :userstatuses, :users, :people

  def setup
    @people = %w(juana panchito)
    @myperson = Person.new({:user_id => 4, :country_id => 392, :firstname  => 'Elena', :lastname1  => 'de Oteiza', :dateofbirth => 1970, :gender => false})
  end

  # Right - CRUD
  def test_creating_people_from_yaml
    @people.each { | person|
      @person = Person.find(people(person.to_sym).user_id)
      assert_kind_of Person, @person
      assert_equal people(person.to_sym).user_id, @person.user_id
      assert_equal people(person.to_sym).country_id, @person.country_id
      assert_equal people(person.to_sym).firstname, @person.firstname
      assert_equal people(person.to_sym).lastname1, @person.lastname1
      assert_equal people(person.to_sym).dateofbirth, @person.dateofbirth
      assert_equal people(person.to_sym).gender, @person.gender
    }
  end

  def test_updating_people_firstname
    @people.each { |person|
      @person = Person.find(people(person.to_sym).id)
      assert_equal people(person.to_sym).firstname, @person.firstname
      @person.update_attribute('firstname', @person.firstname.chars.reverse)
      assert_not_equal people(person.to_sym).firstname, @person.firstname
    }
  end

  def test_updating_people_lastname1
    @people.each { |person|
      @person = Person.find(people(person.to_sym).id)
      assert_equal people(person.to_sym).lastname1, @person.lastname1
      @person.update_attribute('lastname1', @person.lastname1.chars.reverse)
      assert_not_equal people(person.to_sym).lastname1, @person.lastname1
    }
  end

  def test_deleting_people
    @people.each { |person|
      @person = Person.find(people(person.to_sym).id)
      @person.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Person.find(people(person.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @person = Person.new
    assert !@person.save
  end

  def test_creating_duplicated_person
    @person = Person.new({:user_id => 3, :country_id => 484, :dateofbirth => '07/02/1986', :firstname  => 'Francisco', :lastname1  => 'Buentiempo', :gender => false})
     @person_user_id = 3
    assert !@person.save
  end

  # Boundary
  def test_bad_values_for_country_id
   # @myperson.country_id = nil
   # assert !@myperson.valid?

    @myperson.country_id= 1.6
    assert !@myperson.valid?

    @myperson.country_id = 'mi_id'
    assert !@myperson.valid?
  end

  def test_bad_values_for_user_id
    @myperson_user_id = 3.1416
    assert !@myperson.valid?

    @myperson_user_id = 'mi_id'
    assert !@myperson.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_user_id
    @people.each { | person|
      @person = Person.find(people(person.to_sym).id)
      assert_kind_of Person, @person
      assert_equal @person.user_id, User.find(@person.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @people.each { | person|
      @person = Person.find(people(person.to_sym).id)
      assert_kind_of Person, @person
      @person.user_id = 1000000
      begin
        return true if @person.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_country_id
    @people.each { | person|
      @person = Person.find(people(person.to_sym).id)
      assert_kind_of Person, @person
      assert_equal @person.country_id, Country.find(@person.country_id).id
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
    @people.each { | person|
      @person = Person.find(people(person.to_sym).id)
      assert_kind_of Person, @person
      @person.country_id = 100000
      begin
        return true if @person.save
      rescue StandardError => x
        return false
      end
    }
  end

end
