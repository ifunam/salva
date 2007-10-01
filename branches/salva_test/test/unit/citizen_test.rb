require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'user'
require 'citizen'
require 'citizenmodality'


class ConferenceTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :migratorystatuses, :citizenmodalities, :citizens

  def setup
    @citizens = %w(mexicana japonesa ucraniana)
    @mycitizen = Citizen.new({ :user_id => 1, :migratorystatus_id => 3,  :citizen_country_id => 484, :citizenmodality_id => 1 })
  end

  # Right - CRUD
  def test_creating_citizens_from_yaml
    @citizens.each { | citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_kind_of Citizen, @citizen
      assert_equal citizens(citizen.to_sym).id, @citizen.id
      assert_equal citizens(citizen.to_sym).migratorystatus_id, @citizen.migratorystatus_id
      assert_equal citizens(citizen.to_sym).citizen_country_id, @citizen.citizen_country_id
      assert_equal citizens(citizen.to_sym).citizenmodality_id, @citizen.citizenmodality_id
      assert_equal citizens(citizen.to_sym).migratorystatus_id, @citizen.migratorystatus_id

    }
  end

  def test_updating_citizens_country
    @citizens.each { |citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_equal citizens(citizen.to_sym).citizen_country_id, @citizen.citizen_country_id
      @citizen.citizen_country_id = 666
      assert @citizen.save
      assert_not_equal citizens(citizen.to_sym).citizen_country_id, @citizen.citizen_country_id
    }
  end



  def test_deleting_citizens
    @citizens.each { |citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      @citizen.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Citizen.find(citizens(citizen.to_sym).id)
      }
    }
  end

   def test_creating_with_empty_attributes
     @citizen = Citizen.new
     assert !@citizen.save
   end

   def test_creating_duplicated_citizen
     @citizen = Citizen.new({ :user_id => 1, :migratorystatus_id => 1,  :citizen_country_id => 484, :citizenmodality_id => 1 })
     assert !@citizen.save
   end

     # Boundary
   def test_bad_values_for_id
     # Float number for ID
     @mycitizen.id = 1.6
     assert !@mycitizen.valid?

    # Negative numbers
     @mycitizen.id = -1
     assert !@mycitizen.valid?
   end

   def test_bad_values_for_migratorystatus_id
     @mycitizen.migratorystatus_id = nil
     assert !@mycitizen.valid?

     @mycitizen.migratorystatus_id = 3.1416
     assert !@mycitizen.valid?

     @mycitizen.title = -1
     assert !@mycitizen.valid?
   end

   def test_bad_values_for_citizen_country_id

     @mycitizen.citizen_country_id = nil
     assert !@mycitizen.valid?

     # Float number for ID
     @mycitizen.citizen_country_id = 3.1416
     assert !@mycitizen.valid?

    # Negative numbers
     @mycitizen.citizen_country_id = -1
     assert !@mycitizen.valid?
   end

   def test_bad_values_for_citizenmodality_id
     @mycitizen.citizenmodality_id = nil
     assert !@mycitizen.valid?

     # Float number for ID
     @mycitizen.citizenmodality_id = 3.1416
     assert !@mycitizen.valid?

     # Negative numbers
     @mycitizen.citizenmodality_id = -1
     assert !@mycitizen.valid?
   end

   def test_bad_values_for_migratorystatus_id

     @mycitizen.migratorystatus_id  = nil
     assert !@mycitizen.valid?

     # Float number for ID
     @mycitizen.migratorystatus_id  = 3.1416
     assert !@mycitizen.valid?
    @mycitizen.migratorystatus_id  = 3.1416
     assert !@mycitizen.valid?
   end

  #Cross-Checking test
 def test_cross_checking_for_migratorystatus_id
   @citizens.each { | citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_kind_of Citizen, @citizen
      assert_equal @citizen.migratorystatus_id, Migratorystatus.find(@citizen.migratorystatus_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.save
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_migratorystatus_id
    @citizens.each { | citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_kind_of Citizen, @citizen
      @citizen.migratorystatus_id = 50
      begin
        return true if @citizen.save
      rescue StandardError => x
        return false
      end
    }
  end

  #Cross-Checking test
 def test_cross_checking_for_citizenmodality_id
   @citizens.each { | citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_kind_of Citizen, @citizen
     assert_equal @citizen.citizenmodality_id, Citizenmodality.find(@citizen.citizenmodality_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.save
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_citizenmodality_id
    @citizens.each { | citizen|
      @citizen = Citizen.find(citizens(citizen.to_sym).id)
      assert_kind_of Citizen, @citizen
      @citizen.citizenmodality_id = 50
      begin
        return true if @citizen.save
      rescue StandardError => x
        return false
      end
    }
  end


end
