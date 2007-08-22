require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'idtype'
require 'identification'

class IdentificationTest < Test::Unit::TestCase
  fixtures :countries, :idtypes, :identifications

  def setup
    @identifications = %w(curp_mexicana credencial_de_elector_mexicana pasaporte_mexicana)
    @myidentification = Identification.new({:idtype_id => 4, :citizen_country_id => 484})
  end

  # Right - CRUD
  def test_creating_identifications_from_yaml
    @identifications.each { | identification|
      @identification = Identification.find(identifications(identification.to_sym).id)
      assert_kind_of Identification, @identification
      assert_equal identifications(identification.to_sym).id, @identification.id
      assert_equal identifications(identification.to_sym).citizen_country_id, @identification.citizen_country_id
      assert_equal identifications(identification.to_sym).idtype_id, @identification.idtype_id
    }
  end

  def test_deleting_identifications
    @identifications.each { |identification|
      @identification = Identification.find(identifications(identification.to_sym).id)
      @identification.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Identification.find(identifications(identification.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @identification = Identification.new
    assert !@identification.save
  end

  def test_creating_duplicated_identification
    @identification = Identification.new({:idtype_id => 2, :citizen_country_id => 484})
    assert !@identification.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myidentification.id = 1.6
    assert !@myidentification.valid?
    @myidentification.id = 'mi_id'
    assert !@myidentification.valid?
  end

  def test_bad_values_for_citizen_country_id
    @myidentification.citizen_country_id = nil
    assert !@myidentification.valid?

    @myidentification.citizen_country_id= 1.6
    assert !@myidentification.valid?

    @myidentification.citizen_country_id = 'mi_id'
    assert !@myidentification.valid?
  end

  def test_bad_values_for_idtype_id
    @myidentification.idtype_id = nil
    assert !@myidentification.valid?

    @myidentification.idtype_id = 3.1416
    assert !@myidentification.valid?
    @myidentification.idtype_id = 'mi_id'
    assert !@myidentification.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_idtype_id
    @identifications.each { | identification|
      @identification = Identification.find(identifications(identification.to_sym).id)
      assert_kind_of Identification, @identification
      assert_equal @identification.idtype_id, Idtype.find(@identification.idtype_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_idtype_id
    @identifications.each { | identification|
      @identification = Identification.find(identifications(identification.to_sym).id)
      assert_kind_of Identification, @identification
      @identification.idtype_id = 10
      begin
        return true if @identification.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_citizen_country_id
    @identifications.each { | identification|
      @identification = Identification.find(identifications(identification.to_sym).id)

      assert_kind_of Identification, @identification
      assert_equal @identification.citizen_country_id, Country.find(@identification.citizen_country_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_citizen_country_id
    @identifications.each { | identification|
      @identification = Identification.find(identifications(identification.to_sym).id)
      assert_kind_of Identification, @identification
      @identification.citizen_country_id = 100000
      begin
        return true if @identification.update
      rescue StandardError => x
        return false
      end
    }
  end

end
