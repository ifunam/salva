require File.dirname(__FILE__) + '/../test_helper'
require 'academicprogram'
require 'modality'
require 'regularcourse'

class RegularcourseTest < Test::Unit::TestCase
  fixtures  :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :degrees, :careers, :institutioncareers, :academicprogramtypes, :academicprograms, :modalities, :regularcourses

  def setup
    @regularcourses = %w(fisica_general algebra_superior)
    @myregularcourse = Regularcourse.new({:title => "Java", :modality_id => 1})
  end

  # Right - CRUD
  def test_creating_regularcourse_from_yaml
    @regularcourses.each { | regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_kind_of Regularcourse, @regularcourse
      assert_equal regularcourses(regularcourse.to_sym).id, @regularcourse.id
      assert_equal regularcourses(regularcourse.to_sym).title, @regularcourse.title
      assert_equal regularcourses(regularcourse.to_sym).modality_id, @regularcourse.modality_id
    }
  end

  def test_updating_title
    @regularcourses.each { |regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_equal regularcourses(regularcourse.to_sym).title, @regularcourse.title
      @regularcourse.title = "Java con Base de Datos"
      assert @regularcourse.save
      assert_not_equal regularcourses(regularcourse.to_sym).title, @regularcourse.title
    }
  end

  def test_updating_modality_id
    @regularcourses.each { |regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_equal regularcourses(regularcourse.to_sym).modality_id, @regularcourse.modality_id
      @regularcourse.modality_id = 3
      assert @regularcourse.save
      assert_not_equal regularcourses(regularcourse.to_sym).modality_id, @regularcourse.modality_id
    }
  end

  def test_updating_semester
    @regularcourses.each { |regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_equal regularcourses(regularcourse.to_sym).semester, @regularcourse.semester
      @regularcourse.semester = 10
      assert @regularcourse.save
      assert_not_equal regularcourses(regularcourse.to_sym).semester, @regularcourse.semester
    }
  end

  def test_updating_credits
    @regularcourses.each { |regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_equal regularcourses(regularcourse.to_sym).credits, @regularcourse.credits
      @regularcourse.credits = 100
      assert @regularcourse.save
      assert_not_equal regularcourses(regularcourse.to_sym).credits, @regularcourse.credits
    }
  end

  def test_deleting_regularcourses
    @regularcourses.each { |regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      @regularcourse.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @regularcourse = Regularcourse.new
    assert !@regularcourse.save
  end

  # Boundary
  def test_bad_values_for_id
    @myregularcourse.id = 1.6
    assert !@myregularcourse.valid?
    @myregularcourse.id = 'mi_id'
    assert !@myregularcourse.valid?
    @myregularcourse.id = -1
    assert !@myregularcourse.valid?
  end

  def test_bad_values_for_title
    @myregularcourse.title = nil
    assert !@myregularcourse.valid?
  end

  def test_bad_values_for_modality_id
    @myregularcourse.modality_id = nil
    assert !@myregularcourse.valid?
    @myregularcourse.modality_id = 1.6
    assert !@myregularcourse.valid?
    @myregularcourse.modality_id = 'mi_id_texto'
    assert !@myregularcourse.valid?
    @myregularcourse.modality_id = -1
    assert !@myregularcourse.valid?
  end

  def test_bad_values_for_academicprogram_id
    @myregularcourse.academicprogram_id = 1.6
    assert !@myregularcourse.valid?
    @myregularcourse.academicprogram_id = 'mi_id_texto'
    assert !@myregularcourse.valid?
    @myregularcourse.academicprogram_id = -1
    assert !@myregularcourse.valid?
  end

  def test_bad_values_for_semester
    @myregularcourse.semester = 1.6
    assert !@myregularcourse.valid?
    @myregularcourse.semester = 'my_semester'
    assert !@myregularcourse.valid?
    @myregularcourse.semester = -1
    assert !@myregularcourse.valid?
  end

  #cross-Checking test for modality
  def test_cross_checking_for_modality_id
    @regularcourses.each { | regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_kind_of Regularcourse, @regularcourse
      assert_equal @regularcourse.modality_id, Modality.find(@regularcourse.modality_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_modality_id
    @regularcourses.each { | regularcourse|
      @regularcourse = Regularcourse.find(regularcourses(regularcourse.to_sym).id)
      assert_kind_of Regularcourse, @regularcourse
      @regularcourse.modality_id = 50
      begin
        return true if @regularcourse.save
      rescue StandardError => x
        return false
      end
    }
  end
end
