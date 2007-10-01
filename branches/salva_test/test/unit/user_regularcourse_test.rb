require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'period'
require 'regularcourse'
require 'roleinregularcourse'
require 'user_regularcourse'

class UserRegularcourseTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :states, :cities, :periods, :institutiontitles, :institutiontypes, :institutions, :degrees, :careers, :institutioncareers, :academicprogramtypes, :academicprograms, :modalities, :regularcourses, :roleinregularcourses, :user_regularcourses

  def setup
    @user_regularcourses = %w(juana_fisica_general panchito_algebra_superior)
    @myuser_regularcourse = UserRegularcourse.new({ :user_id => 3, :regularcourse_id => 2, :period_id => 2 , :roleinregularcourse_id => 2 })
  end

  # Right - CRUD
  def test_creating_user_regularcourse_from_yaml
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      assert_equal user_regularcourses(user_regularcourse.to_sym).id, @user_regularcourse.id
      assert_equal user_regularcourses(user_regularcourse.to_sym).user_id, @user_regularcourse.user_id
      assert_equal user_regularcourses(user_regularcourse.to_sym).regularcourse_id, @user_regularcourse.regularcourse_id
      assert_equal user_regularcourses(user_regularcourse.to_sym).period_id, @user_regularcourse.period_id
      assert_equal user_regularcourses(user_regularcourse.to_sym).roleinregularcourse_id, @user_regularcourse.roleinregularcourse_id
    }
  end

  def test_updating_regularcourse_id
    @user_regularcourses.each { |user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_equal user_regularcourses(user_regularcourse.to_sym).regularcourse_id, @user_regularcourse.regularcourse_id
      @user_regularcourse.regularcourse_id = 3
      assert @user_regularcourse.save
      assert_not_equal user_regularcourses(user_regularcourse.to_sym).regularcourse_id, @user_regularcourse.regularcourse_id
    }
  end

   def test_updating_user_id
    @user_regularcourses.each { |user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_equal user_regularcourses(user_regularcourse.to_sym).user_id, @user_regularcourse.user_id
      @user_regularcourse.user_id = 1
      assert @user_regularcourse.save
      assert_not_equal user_regularcourses(user_regularcourse.to_sym).user_id, @user_regularcourse.user_id
    }
  end

 def test_updating_period_id
    @user_regularcourses.each { |user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_equal user_regularcourses(user_regularcourse.to_sym).period_id, @user_regularcourse.period_id
      @user_regularcourse.period_id = 3
      assert @user_regularcourse.save
      assert_not_equal user_regularcourses(user_regularcourse.to_sym).period_id, @user_regularcourse.period_id
    }
  end

 def test_updating_roleinregularcourse_id
    @user_regularcourses.each { |user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_equal user_regularcourses(user_regularcourse.to_sym).roleinregularcourse_id, @user_regularcourse.roleinregularcourse_id
      @user_regularcourse.roleinregularcourse_id = 2
      assert @user_regularcourse.save
      assert_not_equal user_regularcourses(user_regularcourse.to_sym).roleinregularcourse_id, @user_regularcourse.roleinregularcourse_id
    }
  end

  def test_deleting_user_regularcourses
    @user_regularcourses.each { |user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      @user_regularcourse.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_regularcourse = UserRegularcourse.new
    assert !@user_regularcourse.save
  end

     def test_creating_duplicated
     @user_regularcourse = UserRegularcourse.new({:user_id => 2, :regularcourse_id => 1, :period_id => 2, :roleinregularcourse_id =>1 })
     assert !@user_regularcourse.save
   end

   # Boundary
    def test_bad_values_for_id
     @myuser_regularcourse.id = 1.6
     assert !@myuser_regularcourse.valid?
     @myuser_regularcourse.id = 'mi_id'
     assert !@myuser_regularcourse.valid?
  end

  def test_bad_values_for_user_id
    @myuser_regularcourse.user_id= 1.6
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.user_id = 'mi_id_texto'
    assert !@myuser_regularcourse.valid?
  end

  def test_bad_values_for_regularcourse_id
    @myuser_regularcourse.regularcourse_id = nil
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.regularcourse_id= 1.6
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.regularcourse_id = 'mi_id_texto'
    assert !@myuser_regularcourse.valid?
  end

  def test_bad_values_for_period_id
    @myuser_regularcourse.period_id = nil
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.period_id= 1.6
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.period_id = 'mi_id_texto'
    assert !@myuser_regularcourse.valid?
  end

  def test_bad_values_for_roleinregularcourse_id
    @myuser_regularcourse.roleinregularcourse_id = nil
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.roleinregularcourse_id= 1.6
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.roleinregularcourse_id = 'mi_id_texto'
    assert !@myuser_regularcourse.valid?
  end

  def test_bad_values_for_hoursxweek_id
    @myuser_regularcourse.hoursxweek = 500
    assert !@myuser_regularcourse.valid?
    @myuser_regularcourse.hoursxweek = 'texto'
    assert !@myuser_regularcourse.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      assert_equal @user_regularcourse.user_id, User.find(@user_regularcourse.user_id).id
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
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      @user_regularcourse.user_id = 5
      begin
        return true if @user_regularcourse.save
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for regularcourse
  def test_cross_checking_for_regularcourse_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      assert_equal @user_regularcourse.regularcourse_id, Regularcourse.find(@user_regularcourse.regularcourse_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_regularcourse_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      @user_regularcourse.regularcourse_id = 100000
      begin
        return true if @user_regularcourse.save
           rescue StandardError => x
        return false
      end
    }
  end

   #cross-Checking test for period_id
  def test_cross_checking_for_period_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      assert_equal @user_regularcourse.period_id, Period.find(@user_regularcourse.period_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_period_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      @user_regularcourse.period_id = 100000
      begin
        return true if @user_regularcourse.save
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for roleinregularcourse
  def test_cross_checking_for_roleinregularcourse_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      assert_equal @user_regularcourse.roleinregularcourse_id, Roleinregularcourse.find(@user_regularcourse.roleinregularcourse_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinregularcourse_id
    @user_regularcourses.each { | user_regularcourse|
      @user_regularcourse = UserRegularcourse.find(user_regularcourses(user_regularcourse.to_sym).id)
      assert_kind_of UserRegularcourse, @user_regularcourse
      @user_regularcourse.roleinregularcourse_id = 2000
       begin
        return true if @user_regularcourse.save
       rescue StandardError => x
        return false
      end
    }
  end
end
