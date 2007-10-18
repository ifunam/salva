require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'identification'
require 'people_identification'

class PeopleIdentificationTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :idtypes, :identifications, :people_identifications

  def setup
    @people_identifications = %w(juana_curp_mexicana panchito_credencial_de_elector_mexicana admin_pasaporte_ucraniano)
    @mypeople_identification = PeopleIdentification.new({:user_id => 2, :identification_id => 2, :descr => 'Credencial de elector' })
  end

  # Right - CRUD
  def test_creating_people_identifications_from_yaml
    @people_identifications.each { | people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      assert_kind_of PeopleIdentification, @people_identification
      assert_equal people_identifications(people_identification.to_sym).id, @people_identification.id
      assert_equal people_identifications(people_identification.to_sym).identification_id, @people_identification.identification_id
      assert_equal people_identifications(people_identification.to_sym).user_id, @people_identification.user_id
      assert_equal people_identifications(people_identification.to_sym).descr, @people_identification.descr
    }
  end
  def test_updating_descr
    @people_identifications.each { |people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      assert_equal people_identifications(people_identification.to_sym).descr, @people_identification.descr
      @people_identification.update_attribute('descr', @people_identification.descr.chars.reverse) 
      assert_not_equal people_identifications(people_identification.to_sym).descr, @people_identification.descr
    }
  end  
  def test_deleting_people_identifications
    @people_identifications.each { |people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      @people_identification.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @people_identification = PeopleIdentification.new
    assert !@people_identification.save
  end

  def test_creating_duplicated_people_identification
    @people_identification = PeopleIdentification.new({:user_id => 2, :identification_id => 1, :descr => 'Curp Mexicana'})
    assert !@people_identification.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mypeople_identification.id = 1.6
    assert !@mypeople_identification.valid?
    @mypeople_identification.id = 'mi_id'
    assert !@mypeople_identification.valid?
  end

  def test_bad_values_for_identification_id
    @mypeople_identification.identification_id = nil
    assert !@mypeople_identification.valid?

    @mypeople_identification.identification_id= 1.6
    assert !@mypeople_identification.valid?

    @mypeople_identification.identification_id = 'mi_id'
    assert !@mypeople_identification.valid?
  end

  def test_bad_values_for_user_id
    @mypeople_identification.user_id = nil
    assert !@mypeople_identification.valid?

    @mypeople_identification.user_id = 3.1416
    assert !@mypeople_identification.valid?
    @mypeople_identification.user_id = 'mi_id'
    assert !@mypeople_identification.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_user_id
    @people_identifications.each { | people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      assert_kind_of PeopleIdentification, @people_identification
      assert_equal @people_identification.user_id, User.find(@people_identification.user_id).id
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
    @people_identifications.each { | people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      assert_kind_of PeopleIdentification, @people_identification
      @people_identification.user_id = 1000000
      begin
        return true if @people_identification.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_identification_id
    @people_identifications.each { | people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)

      assert_kind_of PeopleIdentification, @people_identification
      assert_equal @people_identification.identification_id, Identification.find(@people_identification.identification_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_identification_id
    @people_identifications.each { | people_identification|
      @people_identification = PeopleIdentification.find(people_identifications(people_identification.to_sym).id)
      assert_kind_of PeopleIdentification, @people_identification
      @people_identification.identification_id = 100000
      begin
        return true if @people_identification.save
      rescue StandardError => x
        return false
      end
    }
  end

end
