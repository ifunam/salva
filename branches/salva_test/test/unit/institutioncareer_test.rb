require File.dirname(__FILE__) + '/../test_helper'
require 'career'
require 'institution'
require 'institutioncareer'

class InstitutioncareerTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers

  def setup
    @institutioncareers = %w(actuaria_unam administracion_unam)
    @myinstitutioncareer = Institutioncareer.new({:institution_id => 1, :career_id => 3})
  end

  # Right - CRUD
  def test_creating_institutioncareers_from_yaml
    @institutioncareers.each { | institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      assert_kind_of Institutioncareer, @institutioncareer
      assert_equal institutioncareers(institutioncareer.to_sym).id, @institutioncareer.id
      assert_equal institutioncareers(institutioncareer.to_sym).career_id, @institutioncareer.career_id
      assert_equal institutioncareers(institutioncareer.to_sym).institution_id, @institutioncareer.institution_id
    }
  end

  def test_deleting_institutioncareers
    @institutioncareers.each { |institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      @institutioncareer.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @institutioncareer = Institutioncareer.new
    assert !@institutioncareer.save
  end

  def test_creating_duplicated_institutioncareer
    @institutioncareer = Institutioncareer.new({:institution_id => 1, :career_id => 2})
    assert !@institutioncareer.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myinstitutioncareer.id = 1.6
    assert !@myinstitutioncareer.valid?
    @myinstitutioncareer.id = 'mi_id'
    assert !@myinstitutioncareer.valid?
  end

  def test_bad_values_for_career_id
    @myinstitutioncareer.career_id = nil
    assert !@myinstitutioncareer.valid?

    @myinstitutioncareer.career_id= 1.6
    assert !@myinstitutioncareer.valid?

    @myinstitutioncareer.career_id = 'mi_id'
    assert !@myinstitutioncareer.valid?
  end

  def test_bad_values_for_institution_id
    @myinstitutioncareer.institution_id = nil
    assert !@myinstitutioncareer.valid?

    @myinstitutioncareer.institution_id = 3.1416
    assert !@myinstitutioncareer.valid?
    @myinstitutioncareer.institution_id = 'mi_id'
    assert !@myinstitutioncareer.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institution_id
    @institutioncareers.each { | institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      assert_kind_of Institutioncareer, @institutioncareer
      assert_equal @institutioncareer.institution_id, Institution.find(@institutioncareer.institution_id).id
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
    @institutioncareers.each { | institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      assert_kind_of Institutioncareer, @institutioncareer
      @institutioncareer.institution_id = 10
      begin
        return true if @institutioncareer.update
      rescue StandardError => x
        return false
      end
    }
  end

 def test_cross_checking_for_career_id
    @institutioncareers.each { | institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      assert_kind_of Institutioncareer, @institutioncareer
      assert_equal @institutioncareer.career_id, Career.find(@institutioncareer.career_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_career_id
    @institutioncareers.each { | institutioncareer|
      @institutioncareer = Institutioncareer.find(institutioncareers(institutioncareer.to_sym).id)
      assert_kind_of Institutioncareer, @institutioncareer
      @institutioncareer.career_id = 100000
      begin
        return true if @institutioncareer.update
      rescue StandardError => x
        return false
      end
    }
  end

end
