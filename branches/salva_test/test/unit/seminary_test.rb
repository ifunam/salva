require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'seminary'

class SeminaryTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :seminaries

  def setup
    @seminaries = %w(analisis_de_onda_P proceso_ruptura_en_sumatra)
    @myseminary = Seminary.new({ :title => "Base de datos", :isseminary => "t", :year => 2007, :institution_id => 1})
  end

  # Right - CRUD
  def test_creating_seminary_from_yaml
    @seminaries.each { | seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_kind_of Seminary, @seminary
      assert_equal seminaries(seminary.to_sym).id, @seminary.id
      assert_equal seminaries(seminary.to_sym).title, @seminary.title
      assert_equal seminaries(seminary.to_sym).isseminary, @seminary.isseminary
      assert_equal seminaries(seminary.to_sym).year, @seminary.year
      assert_equal seminaries(seminary.to_sym).institution_id, @seminary.institution_id
    }
  end

  def test_updating_title
    @seminaries.each { |seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_equal seminaries(seminary.to_sym).title, @seminary.title
      @seminary.update_attribute('title', @seminary.title.chars.reverse)
      assert_not_equal seminaries(seminary.to_sym).title, @seminary.title
    }
  end



  def test_updating_year
    @seminaries.each { |seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_equal seminaries(seminary.to_sym).year, @seminary.year
      @seminary.update_attribute('year', 2000)
      assert_not_equal seminaries(seminary.to_sym).year, @seminary.year
    }
  end

  def test_updating_institution_id
    @seminaries.each { |seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_equal seminaries(seminary.to_sym).institution_id, @seminary.institution_id
      @seminary.update_attribute('institution_id', 71)
      assert_not_equal seminaries(seminary.to_sym).institution_id, @seminary.institution_id
    }
  end

  def test_deleting_seminaries
    @seminaries.each { |seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      @seminary.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Seminary.find(seminaries(seminary.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @seminary = Seminary.new
    assert !@seminary.save
  end

  def test_creating_duplicated
    @seminary = Seminary.new({:title => 'Analisis de Onda P',:isseminary => "t", :year => 2004, :institution_id => 1})
    assert !@seminary.save
  end

  # Boundary
  def test_bad_values_for_id
    @myseminary.id = 1.6
    assert !@myseminary.valid?
    @myseminary.id = 'mi_id'
    assert !@myseminary.valid?
  end

  def test_bad_values_for_institution_id
    @myseminary.institution_id = nil
    assert !@myseminary.valid?
    @myseminary.institution_id= 1.6
    assert !@myseminary.valid?
    @myseminary.institution_id = 'mi_id_texto'
    assert !@myseminary.valid?
  end

  def test_bad_values_for_year
    @myseminary.year = nil
    assert !@myseminary.valid?
    @myseminary.year = 1.6
    assert !@myseminary.valid?
    @myseminary.year = 'my_year'
    assert !@myseminary.valid?
  end

  def test_bad_values_for_isseminary
    @myseminary.isseminary = nil
    assert !@myseminary.valid?
    @myseminary.isseminary = 1.6
    assert !@myseminary.valid?
    @myseminary.isseminary = 'my_isseminary'
    assert !@myseminary.valid?
  end

  def test_bad_values_for_month
    @myseminary.month = -1.0
    assert !@myseminary.valid?
    @myseminary.month = 25.32
    assert !@myseminary.valid?
    @myseminary.month = 'my_month'
    assert !@myseminary.valid?
  end

  #cross-Checking test for institution
  def test_cross_checking_for_institution_id
    @seminaries.each { | seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_kind_of Seminary, @seminary
      assert_equal @seminary.institution_id, Institution.find(@seminary.institution_id).id
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
    @seminaries.each { | seminary|
      @seminary = Seminary.find(seminaries(seminary.to_sym).id)
      assert_kind_of Seminary, @seminary
      @seminary.institution_id = 500000
      begin
        return true if @seminary.save
      rescue StandardError => x
        return false
      end
    }
  end
end
