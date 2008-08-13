require File.dirname(__FILE__) + '/../test_helper'
require 'schooling'
require 'user'

class SchoolingTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :userstatuses, :users,  :schoolings

  def setup
    @schoolings = %w(schooling_01 schooling_02)
    @myschooling = Schooling.new({:institutioncareer_id => 1, :user_id => 1, :startyear => 2004})
  end

  # Right - CRUD
  def test_creating_schoolings_from_yaml
    @schoolings.each { | schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_kind_of Schooling, @schooling
      assert_equal schoolings(schooling.to_sym).id, @schooling.id
      assert_equal schoolings(schooling.to_sym).institutioncareer_id, @schooling.institutioncareer_id
      assert_equal schoolings(schooling.to_sym).user_id, @schooling.user_id
    }
  end

  def test_updating_schoolings_institutioncareer_id
    @schoolings.each { |schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_equal schoolings(schooling.to_sym).startyear, @schooling.startyear
      @schooling.startyear = 2005
      @schooling.save
      assert_not_equal schoolings(schooling.to_sym).startyear, @schooling.startyear
    }
  end

  def test_deleting_schoolings
    @schoolings.each { |schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      @schooling.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Schooling.find(schoolings(schooling.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @schooling = Schooling.new
    assert !@schooling.save
  end

  def test_creating_duplicated_schooling
    @schooling = Schooling.new({:institutioncareer_id => 1, :user_id => 2, :startyear => 1990})
    assert !@schooling.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myschooling.id = 1.6
    assert !@myschooling.valid?

    # Negative numbers
    #@myschooling.id = -1
    #assert !@myschooling.valid?
  end

  def test_bad_values_for_institutioncareer_id
     @myschooling.institutioncareer_id = nil
     assert !@myschooling.valid?
     @myschooling.institutioncareer_id = 3.1415
     assert !@myschooling.valid?

  end

  def test_bad_values_for_user_id
    # Checking constraints for institutioncareer_id
    # Nil institutioncareer_id
    @myschooling.user_id = nil
    assert !@myschooling.valid?

    # Float number for ID
    @myschooling.user_id = 3.1416
    assert !@myschooling.valid?

    # Negative numbers
    #@myschooling.user_id = -1
    #assert !@myschooling.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_user_id
    @schoolings.each { | schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_kind_of Schooling, @schooling
      assert_equal @schooling.user_id, User.find(@schooling.user_id).id
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
    @schoolings.each { | schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_kind_of Schooling, @schooling
      @schooling.user_id = 2000
      begin
        return true if @schooling.save
      rescue StandardError => x
        return false
      end
    }

 def test_cross_checking_for_institutioncareer_id
    @schoolings.each { | schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_kind_of Schooling, @schooling
      assert_equal @schooling.institutioncareer_id, Institutioncareer.find(@schooling.institutioncareer_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institutioncareer_id
    @schoolings.each { | schooling|
      @schooling = Schooling.find(schoolings(schooling.to_sym).id)
      assert_kind_of Schooling, @schooling
      @schooling.institutioncareer_id = 2000
      begin
        return true if @schooling.save
      rescue StandardError => x
        return false
      end
    }
  end
end
end
