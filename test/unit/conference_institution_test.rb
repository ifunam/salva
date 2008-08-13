require File.dirname(__FILE__) + '/../test_helper'
require 'conference'
require 'institution'
require 'conference_institution'

class ConferenceInstitutionTest < Test::Unit::TestCase
fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :conferencetypes, :conferencescopes, :conferences, :conference_institutions
 
  def setup
    @conference_institutions = %w(secretaria_de_educacion_publica centro_de_ciencias_de_la_atmosfera)
    @myconference_institution = ConferenceInstitution.new({:conference_id => 1, :institution_id => 57})
  end

  # Right - CRUD
  def test_creating_conference_institutions_from_yaml
    @conference_institutions.each { | conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      assert_kind_of ConferenceInstitution, @conference_institution
      assert_equal conference_institutions(conference_institution.to_sym).id, @conference_institution.id
      assert_equal conference_institutions(conference_institution.to_sym).conference_id, @conference_institution.conference_id
      assert_equal conference_institutions(conference_institution.to_sym).institution_id, @conference_institution.institution_id
    }
  end

  def test_deleting_conference_institutions
    @conference_institutions.each { |conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      @conference_institution.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @conference_institution = ConferenceInstitution.new
    assert !@conference_institution.save
  end

  def test_creating_duplicated_conference_institution
   @conference_institution = ConferenceInstitution.new({:conference_id => 2, :institution_id => 57})
    assert !@conference_institution.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myconference_institution.id = 1.6
    assert !@myconference_institution.valid?
    @myconference_institution.id = 'mi_id'
    assert !@myconference_institution.valid?
  end

  def test_bad_values_for_conference_id
    @myconference_institution.conference_id = nil
    assert !@myconference_institution.valid?

    @myconference_institution.conference_id= 1.6
    assert !@myconference_institution.valid?

    @myconference_institution.conference_id = 'mi_id'
    assert !@myconference_institution.valid?
  end

  def test_bad_values_for_institution_id
    @myconference_institution.institution_id = nil
    assert !@myconference_institution.valid?

    @myconference_institution.institution_id = 3.1416
    assert !@myconference_institution.valid?
    @myconference_institution.institution_id = 'mi_id'
    assert !@myconference_institution.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @conference_institutions.each { | conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      assert_kind_of ConferenceInstitution, @conference_institution
      assert_equal @conference_institution.institution_id, Institution.find(@conference_institution.institution_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @conference_institutions.each { | conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      assert_kind_of ConferenceInstitution, @conference_institution
      @conference_institution.institution_id = 1000000
      begin
        return true if @conference_institution.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_conference_id
    @conference_institutions.each { | conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      assert_kind_of ConferenceInstitution, @conference_institution
      assert_equal @conference_institution.conference_id, Conference.find(@conference_institution.conference_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_conference_id
    @conference_institutions.each { | conference_institution|
      @conference_institution = ConferenceInstitution.find(conference_institutions(conference_institution.to_sym).id)
      assert_kind_of ConferenceInstitution, @conference_institution
      @conference_institution.conference_id = 100000
      begin
        return true if @conference_institution.save
      rescue StandardError => x
        return false
      end
    }
  end

end
