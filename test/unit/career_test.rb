require File.dirname(__FILE__) + '/../test_helper'
require 'degree'
require 'career'

class CareerTest < Test::Unit::TestCase
  fixtures :degrees, :careers

  def setup
    @careers = %w(actuaria administracion)
    @mycareer = Career.new({:name => 'Computer Science', :degree_id => 3})
  end

  # Right - CRUD
  def test_creating_careers_from_yaml
    @careers.each { | career|
      @career = Career.find(careers(career.to_sym).id)
      assert_kind_of Career, @career
      assert_equal careers(career.to_sym).id, @career.id
      assert_equal careers(career.to_sym).name, @career.name
      assert_equal careers(career.to_sym).degree_id, @career.degree_id
    }
  end

  def test_updating_careers_name
    @careers.each { |career|
      @career = Career.find(careers(career.to_sym).id)
      assert_equal careers(career.to_sym).name, @career.name
      @career.name = @career.name.chars.reverse
      assert @career.save
      assert_not_equal careers(career.to_sym).name, @career.name
    }
  end

  def test_deleting_careers
    @careers.each { |career|
      @career = Career.find(careers(career.to_sym).id)
      @career.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Career.find(careers(career.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @career = Career.new
    assert !@career.save
  end

  def test_creating_duplicated_career
    @career = Career.new({:name => 'Actuaria', :degree_id => 3})
    @career.id = 1
    assert !@career.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mycareer.id = 1.6
    assert !@mycareer.valid?
  end

  def test_bad_values_for_name
    @mycareer.name = nil
    assert !@mycareer.valid?
  end

  def test_bad_values_for_degree_id
    # Checking constraints for name
    # Nil name
    @mycareer.degree_id = nil
    assert !@mycareer.valid?
    @mycareer.degree_id = 3.1416
    assert !@mycareer.valid?
    @mycareer.degree_id = 'mi_id'
    assert !@mycareer.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_degree_id
    @careers.each { | career|
      @career = Career.find(careers(career.to_sym).id)
      assert_kind_of Career, @career
      assert_equal @career.degree_id, Degree.find(@career.degree_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_degree_id
    @careers.each { | career|
      @career = Career.find(careers(career.to_sym).id)
      assert_kind_of Career, @career
      @career.degree_id = 10
      begin
        return true if @career.save
      rescue StandardError => x
        return false
      end
    }
  end
end
