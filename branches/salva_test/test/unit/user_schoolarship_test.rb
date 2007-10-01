require File.dirname(__FILE__) + '/../test_helper'
require 'schoolarship'
require 'country'
require 'user_schoolarship'


class UserSchoolarshipTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles,:institutiontypes, :institutions, :userstatuses, :users, :schoolarships, :user_schoolarships

  def setup
    @user_schoolarships = %w(becario_01 becario_02 becario_03)
    @myuser_schoolarship = UserSchoolarship.new({  :startyear => 2007, :user_id => 1 ,:schoolarship_id => 1 })
  end

  # Right - CRUD
  def test_creating_user_schoolarship_from_yaml
    @user_schoolarships.each { | user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_kind_of UserSchoolarship, @user_schoolarship
      assert_equal user_schoolarships(user_schoolarship.to_sym).id, @user_schoolarship.id
      assert_equal user_schoolarships(user_schoolarship.to_sym).schoolarship_id, @user_schoolarship.schoolarship_id
      assert_equal user_schoolarships(user_schoolarship.to_sym).user_id, @user_schoolarship.user_id
      assert_equal user_schoolarships(user_schoolarship.to_sym).startyear, @user_schoolarship.startyear
    }
  end

  def test_updating_user_schoolarship_id
    @user_schoolarships.each { |user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_equal user_schoolarships(user_schoolarship.to_sym).id, @user_schoolarship.id
      @user_schoolarship.id = 4
      assert @user_schoolarship.save
      assert_not_equal user_schoolarships(user_schoolarship.to_sym).id, @user_schoolarship.id
    }
  end

    def test_updating_user_id
    @user_schoolarships.each { |user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_equal user_schoolarships(user_schoolarship.to_sym).user_id, @user_schoolarship.user_id
      @user_schoolarship.user_id = 1
      assert @user_schoolarship.save
      assert_not_equal user_schoolarships(user_schoolarship.to_sym).user_id, @user_schoolarship.user_id
    }
  end

   def test_updating_schoolarship_id
    @user_schoolarships.each { |user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_equal user_schoolarships(user_schoolarship.to_sym).schoolarship_id, @user_schoolarship.schoolarship_id
      @user_schoolarship.schoolarship_id = 1
       assert @user_schoolarship.save
      assert_not_equal user_schoolarships(user_schoolarship.to_sym).schoolarship_id, @user_schoolarship.schoolarship_id
    }
  end

      def test_updating_startyear
    @user_schoolarships.each { |user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_equal user_schoolarships(user_schoolarship.to_sym).startyear, @user_schoolarship.startyear
      @user_schoolarship.startyear = 2000
      assert @user_schoolarship.save
      assert_not_equal user_schoolarships(user_schoolarship.to_sym).startyear, @user_schoolarship.startyear
    }
  end

  def test_deleting_user_schoolarships
    @user_schoolarships.each { |user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      @user_schoolarship.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_schoolarship = UserSchoolarship.new
    assert !@user_schoolarship.save
  end

   def test_creating_duplicated
     @user_schoolarship = UserSchoolarship.new({ :startyear => 2006, :user_id => 3, :schoolarship_id => 3 })
    assert !@user_schoolarship.save
   end

   # Boundary
    def test_bad_values_for_id
     @myuser_schoolarship.id = 1.6
    assert !@myuser_schoolarship.valid?
    @myuser_schoolarship.id = 'mi_id'
    assert !@myuser_schoolarship.valid?
  end

  def test_bad_values_for_schoolarship_id
    @myuser_schoolarship.schoolarship_id= 1.6
    assert !@myuser_schoolarship.valid?
    @myuser_schoolarship.schoolarship_id = 'mi_id_texto'
    assert !@myuser_schoolarship.valid?
  end

    def test_bad_values_for_user_id
    @myuser_schoolarship.user_id = nil
    assert !@myuser_schoolarship.valid?
    @myuser_schoolarship.user_id = 1.6
    assert !@myuser_schoolarship.valid?
    @myuser_schoolarship.user_id = 'my_year'
    assert !@myuser_schoolarship.valid?
  end

  #cross-Checking test for user_schoolarship
  def test_cross_checking_for_user_schoolarship_id
    @user_schoolarships.each { | user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_kind_of UserSchoolarship, @user_schoolarship
      assert_equal @user_schoolarship.schoolarship_id, Schoolarship.find(@user_schoolarship.schoolarship_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_schoolarship_id
    @user_schoolarships.each { | user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_kind_of UserSchoolarship, @user_schoolarship
      @user_schoolarship.schoolarship_id = 5
          begin
        return true if @user_schoolarship.save
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for edition
  def test_cross_checking_for_user_id
    @user_schoolarships.each { | user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_kind_of UserSchoolarship, @user_schoolarship
      assert_equal @user_schoolarship.user_id, User.find(@user_schoolarship.user_id).id
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
    @user_schoolarships.each { | user_schoolarship|
      @user_schoolarship = UserSchoolarship.find(user_schoolarships(user_schoolarship.to_sym).id)
      assert_kind_of UserSchoolarship, @user_schoolarship
      @user_schoolarship.user_id = 10
       begin
        return true if @user_schoolarship.save
       rescue StandardError => x
        return false
      end
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

end
