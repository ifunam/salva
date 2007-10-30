require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'prize'
require 'user_prize'

class UserPrizeTest < Test::Unit::TestCase
  fixtures :userstatuses, :prizetypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :users, :prizes, :user_prizes

  def setup
    @user_prizes = %w(ciencia_mexico mejor_estudio_de_genero)
    @myuser_prize = UserPrize.new({:prize_id => 3, :user_id => 4, :year => 2005, :month => 1})
  end

  # Right - CRUD
  def test_creating_user_prize_from_yaml
    @user_prizes.each { | user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_kind_of UserPrize, @user_prize
      assert_equal user_prizes(user_prize.to_sym).id, @user_prize.id
      assert_equal user_prizes(user_prize.to_sym).user_id, @user_prize.user_id
      assert_equal user_prizes(user_prize.to_sym).prize_id, @user_prize.prize_id
      assert_equal user_prizes(user_prize.to_sym).year, @user_prize.year
      assert_equal user_prizes(user_prize.to_sym).month, @user_prize.month
    }
  end

  def test_updating_prize_id
    @user_prizes.each { |user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_equal user_prizes(user_prize.to_sym).prize_id, @user_prize.prize_id
      @user_prize.prize_id = 3
      assert @user_prize.save
      assert_not_equal user_prizes(user_prize.to_sym).prize_id, @user_prize.prize_id
    }
  end

  def test_updating_year
    @user_prizes.each { |user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_equal user_prizes(user_prize.to_sym).year, @user_prize.year
      @user_prize.year = @user_prize.year - 2
      assert @user_prize.save
      assert_not_equal user_prizes(user_prize.to_sym).year, @user_prize.year
    }
  end

  def test_updating_month
    @user_prizes.each { |user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_equal user_prizes(user_prize.to_sym).month, @user_prize.month
      if !@user_prize.month.nil?
        @user_prize.month == 12 ? @user_prize.month = @user_prize.month - 2 : @user_prize.month = @user_prize.month + 1
      else
        @user_prize.month = 3
      end
      assert @user_prize.save
      assert_not_equal user_prizes(user_prize.to_sym).month, @user_prize.month
    }
  end

  def test_deleting_user_prizes
    @user_prizes.each { |user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      @user_prize.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserPrize.find(user_prizes(user_prize.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_prize = UserPrize.new
    assert !@user_prize.save
  end

  def test_creating_duplicated
    @user_prize = UserPrize.new({:user_id => 1, :prize_id => 1, :year => 2007})
    assert !@user_prize.save
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_prize.id = 1.6
    assert !@myuser_prize.valid?
    @myuser_prize.id = 'mi_id'
    assert !@myuser_prize.valid?
    @myuser_prize.id = -1
    assert !@myuser_prize.valid?
  end

  def test_bad_values_for_user_id
    @myuser_prize.user_id = nil
    assert !@myuser_prize.valid?
    @myuser_prize.user_id= 1.6
    assert !@myuser_prize.valid?
    @myuser_prize.user_id = 'mi_id_texto'
    assert !@myuser_prize.valid?
    @myuser_prize.user_id= -1
    assert !@myuser_prize.valid?
  end

  def test_bad_values_for_prize_id
    @myuser_prize.prize_id = nil
    assert !@myuser_prize.valid?
    @myuser_prize.prize_id = 1.6
    assert !@myuser_prize.valid?
    @myuser_prize.prize_id = 'mi_id_texto'
    assert !@myuser_prize.valid?
    @myuser_prize.prize_id = -1
    assert !@myuser_prize.valid?
  end

  def test_bad_values_for_year
    @myuser_prize.year = nil
    assert !@myuser_prize.valid?
    @myuser_prize.year = 1.6
    assert !@myuser_prize.valid?
    @myuser_prize.year = 'my_year'
    assert !@myuser_prize.valid?
    @myuser_prize.year = -1
    assert !@myuser_prize.valid?
  end

  #cross check for prize
  def test_cross_checking_for_prize_id
    @user_prizes.each { | user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_kind_of UserPrize, @user_prize
      assert_equal @user_prize.prize_id, Prize.find(@user_prize.prize_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_prize_id
    @user_prizes.each { | user_prize|
      @user_prize = UserPrize.find(user_prizes(user_prize.to_sym).id)
      assert_kind_of UserPrize, @user_prize
      @user_prize.prize_id = 50
      begin
        return true if @user_prize.save
      rescue StandardError => x
        return false
      end
    }
  end
end
