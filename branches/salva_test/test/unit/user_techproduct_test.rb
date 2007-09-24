require File.dirname(__FILE__) + '/../test_helper'
require 'techproduct'

class UserTechproductTest < Test::Unit::TestCase
  fixtures :degrees, :careers, :userstatuses, :users, :techproducttypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :institutioncareers, :users, :techproductstatuses, :techproducts, :user_techproducts

  def setup
    @user_techproducts = %w(user_techproduct_van_gogh_had_turbulence_down_to_a_fine_art user_techproduct_van_gogh_painted_perfect_turbulence)
    @myuser_techproduct = UserTechproduct.new({:techproduct_id => 2, :user_id => 2, :year => 2006})
  end

  # Right - CRUD
  def test_creating_user_techproducts_from_yaml
    @user_techproducts.each { | user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      assert_kind_of UserTechproduct, @user_techproduct
      assert_equal user_techproducts(user_techproduct.to_sym).id, @user_techproduct.id
      assert_equal user_techproducts(user_techproduct.to_sym).techproduct_id, @user_techproduct.techproduct_id
      assert_equal user_techproducts(user_techproduct.to_sym).user_id, @user_techproduct.user_id
      assert_equal user_techproducts(user_techproduct.to_sym).year, @user_techproduct.year
    }
  end

  def test_deleting_user_techproducts
    @user_techproducts.each { |user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      @user_techproduct.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_techproduct = UserTechproduct.new
    assert !@user_techproduct.save
  end

  def test_creating_duplicated_user_techproduct
    @user_techproduct = UserTechproduct.new({:techproduct_id => 1, :user_id => 2, :year => 1996})
    assert !@user_techproduct.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_techproduct.id = 1.6
    assert !@myuser_techproduct.valid?
    @myuser_techproduct.id = 'mi_id'
    assert !@myuser_techproduct.valid?
  end

  def test_bad_values_for_techproduct_id
    @myuser_techproduct.techproduct_id = nil
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.techproduct_id= 1.6
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.techproduct_id = 'mi_id'
    assert !@myuser_techproduct.valid?
  end

  def test_bad_values_for_user_id
    @myuser_techproduct.user_id = nil
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.user_id= 1.6
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.user_id = 'mi_id'
    assert !@myuser_techproduct.valid?
  end

  def test_bad_values_for_year
    @myuser_techproduct.year = nil
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.year= 1.6
    assert !@myuser_techproduct.valid?

    @myuser_techproduct.year = 'mi_id'
    assert !@myuser_techproduct.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_techproduct_id
    @user_techproducts.each { | user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)

      assert_kind_of UserTechproduct, @user_techproduct
      assert_equal @user_techproduct.techproduct_id, Techproduct.find(@user_techproduct.techproduct_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_techproduct_id
    @user_techproducts.each { | user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      assert_kind_of UserTechproduct, @user_techproduct
      @user_techproduct.techproduct_id = 100000
      begin
        return true if @user_techproduct.update
      rescue StandardError => x
        return false
      end
    }
  end


  def test_cross_checking_for_user_id
    @user_techproducts.each { | user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      assert_kind_of UserTechproduct, @user_techproduct
      assert_equal @user_techproduct.user_id, Techproduct.find(@user_techproduct.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @user_techproducts.each { | user_techproduct|
      @user_techproduct = UserTechproduct.find(user_techproducts(user_techproduct.to_sym).id)
      assert_kind_of UserTechproduct, @user_techproduct
      @user_techproduct.user_id = 100000
      begin
        return true if @user_techproduct.update
      rescue StandardError => x
        return false
      end
    }
  end


end
