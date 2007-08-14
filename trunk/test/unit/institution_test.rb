 require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'state'
require 'city'
require 'institutiontype'
require 'institutiontitle'
require 'institution'

class InstitutionTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions

  def setup
    @institutions = %w(programa_Universitario_de_Estudios_de_Genero unam cele)
    @myinstitution = Institution.new({:name => 'Auditoria Interna', :institutiontitle_id => 14, :institutiontype_id => 1, :country_id => 484})
  end

  # Right - CRUD
  def test_creating_institutions_from_yaml
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal institutions(institution.to_sym).id, @institution.id
      assert_equal institutions(institution.to_sym).name, @institution.name
      assert_equal institutions(institution.to_sym).institutiontitle_id, @institution.institutiontitle_id
      assert_equal institutions(institution.to_sym).institutiontype_id, @institution.institutiontype_id
      assert_equal institutions(institution.to_sym).country_id, @institution.country_id

    }
  end

  def test_updating_institutions_name
    @institutions.each { |institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_equal institutions(institution.to_sym).name, @institution.name
      @institution.name = @institution.name.chars.reverse
      assert @institution.update
      assert_not_equal institutions(institution.to_sym).name, @institution.name
    }
  end

  def test_deleting_institutions
    @institutions.each { |institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      @institution.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Institution.find(institutions(institution.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @institution = Institution.new
    assert !@institution.save
  end

  def test_creating_duplicated_institution
    @institution = Institution.new({:name => 'Universidad Nacional Autónoma de México', :institutiontitle_id => 1, :institutiontype_id => 1})
    assert !@institution.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myinstitution.id = 1.6
    assert !@myinstitution.valid?
    @myinstitution.id = 'mi_id'
    assert !@myinstitution.valid?
  end

  def test_bad_values_for_name
    # Float number for ID
    @myinstitution.name = nil
    assert !@myinstitution.valid?
  end

  def test_bad_values_for_institutiontitle_id
    @myinstitution.institutiontitle_id = nil
    assert !@myinstitution.valid?
    @myinstitution.institutiontitle_id= 1.6
    assert !@myinstitution.valid?
    @myinstitution.institutiontitle_id = 'mi_id'
    assert !@myinstitution.valid?
  end

  def test_bad_values_for_institutiontype_id
    @myinstitution.institutiontype_id = nil
    assert !@myinstitution.valid?
    @myinstitution.institutiontype_id= 1.6
    assert !@myinstitution.valid?
    @myinstitution.institutiontype_id = 'mi_id'
    assert !@myinstitution.valid?
  end

  def test_bad_values_for_country_id
    @myinstitution.country_id = nil
    assert !@myinstitution.valid?
    @myinstitution.country_id= 1.6
    assert !@myinstitution.valid?
    @myinstitution.country_id = 'mi_id'
    assert !@myinstitution.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_institutiontile_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.institutiontitle_id, Institutiontitle.find(@institution.institutiontitle_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutiontitle_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.institutiontitle_id = 50
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for institutiontype
  def test_cross_checking_for_institutiontype_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.institutiontype_id, Institutiontype.find(@institution.institutiontype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutiontype_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.institutiontype_id = 20
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for country
  def test_cross_checking_for_country_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.country_id, Country.find(@institution.country_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_country_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.country_id = 20
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for institution_id
  def test_cross_checking_for_institution_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.institution_id, Institution.find(@institution.institution_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.institution_id = 0
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for state_id
  def test_cross_checking_for_state_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.state_id, State.find(@institution.state_id).id
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
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.state_id = 500000
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for city_id
  def test_cross_checking_for_city_id
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      assert_equal @institution.city_id, City.find(@institution.city_id).id
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
    @institutions.each { | institution|
      @institution = Institution.find(institutions(institution.to_sym).id)
      assert_kind_of Institution, @institution
      @institution.city_id = 500000
      begin
        return true if @institution.update
      rescue StandardError => x
        return false
      end
    }
  end
end

