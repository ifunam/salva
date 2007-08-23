require File.dirname(__FILE__) + '/../test_helper'
require 'institutioncareer'
require 'academicprogramtype'
require 'academicprogram'

class AcademicprogramTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :degrees, :careers, :institutioncareers, :academicprogramtypes, :academicprograms

  def setup
    @academicprograms = %w(programa_academico_licenciatura programa_academico_maestria)
    @myacademicprogram = Academicprogram.new({:institutioncareer_id => 3, :academicprogramtype_id => 3, :year => 2007})
  end

  # Right - CRUD
  def test_creating_academicprograms_from_yaml
    @academicprograms.each { | academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      assert_kind_of Academicprogram, @academicprogram
      assert_equal academicprograms(academicprogram.to_sym).id, @academicprogram.id
      assert_equal academicprograms(academicprogram.to_sym).academicprogramtype_id, @academicprogram.academicprogramtype_id
      assert_equal academicprograms(academicprogram.to_sym).institutioncareer_id, @academicprogram.institutioncareer_id
      assert_equal academicprograms(academicprogram.to_sym).year, @academicprogram.year
    }
  end

  def test_deleting_academicprograms
    @academicprograms.each { |academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      @academicprogram.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @academicprogram = Academicprogram.new
    assert !@academicprogram.save
  end

  def test_creating_duplicated_academicprogram
    @academicprogram = Academicprogram.new({:institutioncareer_id => 2, :academicprogramtype_id => 1, :year => 2006})
    assert !@academicprogram.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myacademicprogram.id = 1.6
    assert !@myacademicprogram.valid?
    @myacademicprogram.id = 'mi_id'
    assert !@myacademicprogram.valid?
  end

  def test_bad_values_for_academicprogramtype_id
    @myacademicprogram.academicprogramtype_id = nil
    assert !@myacademicprogram.valid?

    @myacademicprogram.academicprogramtype_id= 1.6
    assert !@myacademicprogram.valid?

    @myacademicprogram.academicprogramtype_id = 'mi_id'
    assert !@myacademicprogram.valid?
  end

  def test_bad_values_for_institutioncareer_id
    @myacademicprogram.institutioncareer_id = nil
    assert !@myacademicprogram.valid?

    @myacademicprogram.institutioncareer_id = 3.1416
    assert !@myacademicprogram.valid?
    @myacademicprogram.institutioncareer_id = 'mi_id'
    assert !@myacademicprogram.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_institutioncareer_id
    @academicprograms.each { | academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      assert_kind_of Academicprogram, @academicprogram
      assert_equal @academicprogram.institutioncareer_id, Institutioncareer.find(@academicprogram.institutioncareer_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutioncareer_id
    @academicprograms.each { | academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      assert_kind_of Academicprogram, @academicprogram
      @academicprogram.institutioncareer_id = 1000000
      begin
        return true if @academicprogram.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_academicprogramtype_id
    @academicprograms.each { | academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)

      assert_kind_of Academicprogram, @academicprogram
      assert_equal @academicprogram.academicprogramtype_id, Academicprogramtype.find(@academicprogram.academicprogramtype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_academicprogramtype_id
    @academicprograms.each { | academicprogram|
      @academicprogram = Academicprogram.find(academicprograms(academicprogram.to_sym).id)
      assert_kind_of Academicprogram, @academicprogram
      @academicprogram.academicprogramtype_id = 100000
      begin
        return true if @academicprogram.update
      rescue StandardError => x
        return false
      end
    }
  end

end
