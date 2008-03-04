require File.dirname(__FILE__) + '/../test_helper'
require 'adscription'
require 'jobposition'
require 'user'
require 'user_adscription'

class UserAdscriptionTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions,  :adscriptions, :userstatuses, :users, 
      :jobpositionlevels, :roleinjobpositions, :jobpositiontypes, :jobpositioncategories,:jobpositions, :user_adscriptions

  def setup
    @user_adscriptions = %w(user_adscription_01 user_adscription_02)
    @myuser_adscription = UserAdscription.new({ :user_id => 3, :adscription_id => 2, :jobposition_id => 3 , :startyear => 2005})
  end

  # Right - CRUD
  def test_creating_user_adscription_from_yaml
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      assert_equal user_adscriptions(user_adscription.to_sym).id, @user_adscription.id
      assert_equal user_adscriptions(user_adscription.to_sym).user_id, @user_adscription.user_id
      assert_equal user_adscriptions(user_adscription.to_sym).adscription_id, @user_adscription.adscription_id
      assert_equal user_adscriptions(user_adscription.to_sym).jobposition_id, @user_adscription.jobposition_id
      assert_equal user_adscriptions(user_adscription.to_sym).startyear, @user_adscription.startyear
    }
  end

  def test_updating_adscription_id
    @user_adscriptions.each { |user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_equal user_adscriptions(user_adscription.to_sym).adscription_id, @user_adscription.adscription_id
      @user_adscription.adscription_id = 3
      assert @user_adscription.save
      assert_not_equal user_adscriptions(user_adscription.to_sym).adscription_id, @user_adscription.adscription_id
    }
  end

   def test_updating_user_id
    @user_adscriptions.each { |user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_equal user_adscriptions(user_adscription.to_sym).user_id, @user_adscription.user_id
      @user_adscription.user_id = 3
      assert @user_adscription.save
      # assert_not_equal user_adscriptions(user_adscription.to_sym).user_id, @user_adscription.user_id
    }
  end

   def test_updating_jobposition_id
    @user_adscriptions.each { |user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_equal user_adscriptions(user_adscription.to_sym).jobposition_id, @user_adscription.jobposition_id
      @user_adscription.jobposition_id = 3
      assert @user_adscription.save
      # assert_not_equal user_adscriptions(user_adscription.to_sym).jobposition_id, @user_adscription.jobposition_id
    }
  end

   def test_updating_startyear
    @user_adscriptions.each { |user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_equal user_adscriptions(user_adscription.to_sym).startyear, @user_adscription.startyear
      @user_adscription.startyear = @user_adscription.startyear - 2
      assert @user_adscription.save
      assert_not_equal user_adscriptions(user_adscription.to_sym).startyear, @user_adscription.startyear
    }
  end

  def test_deleting_user_adscriptions
    @user_adscriptions.each { |user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      @user_adscription.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_adscription = UserAdscription.new
    assert !@user_adscription.save
  end

     # Boundary
    def test_bad_values_for_id
     @myuser_adscription.id = 1.6
     assert !@myuser_adscription.valid?
     @myuser_adscription.id = 'mi_id'
     assert !@myuser_adscription.valid?
     end

  def test_bad_values_for_user_id
    @myuser_adscription.user_id= 1.6
    assert !@myuser_adscription.valid?
    @myuser_adscription.user_id = 'mi_id_texto'
    assert !@myuser_adscription.valid?
  end

  def test_bad_values_for_adscription_id
    @myuser_adscription.adscription_id = nil
    assert !@myuser_adscription.valid?
    @myuser_adscription.adscription_id = 1.6
    assert !@myuser_adscription.valid?
    @myuser_adscription.adscription_id = 'mi_id_texto'
    assert !@myuser_adscription.valid?
  end

  def test_bad_values_for_jobposition_id
    @myuser_adscription.jobposition_id = nil
    assert !@myuser_adscription.valid?
    @myuser_adscription.jobposition_id = 1.6
    assert !@myuser_adscription.valid?
    @myuser_adscription.jobposition_id = 'mi_id_texto'
    assert !@myuser_adscription.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      assert_equal @user_adscription.user_id, User.find(@user_adscription.user_id).id
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
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      @user_adscription.user_id = 5
      begin
        return true if @user_adscription.save
           rescue StandardError => x
        return false
      end
    }
  end

    #cross-Checking test for adscription
  def test_cross_checking_for_adscription_id
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      assert_equal @user_adscription.adscription_id, Adscription.find(@user_adscription.adscription_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_adscription_id
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      @user_adscription.adscription_id = 100000
      begin
        return true if @user_adscription.save
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for jobposition
  def test_cross_checking_for_jobposition_id
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      assert_equal @user_adscription.jobposition_id, Jobposition.find(@user_adscription.jobposition_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_jobposition_id
    @user_adscriptions.each { | user_adscription|
      @user_adscription = UserAdscription.find(user_adscriptions(user_adscription.to_sym).id)
      assert_kind_of UserAdscription, @user_adscription
      @user_adscription.jobposition_id = 2000
       begin
        return true if @user_adscription.save
       rescue StandardError => x
        return false
      end
    }
  end
end
