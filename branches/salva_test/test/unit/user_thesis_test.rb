require File.dirname(__FILE__) + '/../test_helper'

require 'thesis'
require 'user'
require 'roleinthesis'
require 'user_thesis'

class UserThesisTest < Test::Unit::TestCase
  fixtures  :roleintheses, :userstatuses, :users, :countries, :states, :cities, :institutiontitles, :institutiontypes, :degrees, :careers, :institutions, :institutioncareers, :thesismodalities, :thesisstatuses, :theses, :user_theses

  def setup
    @user_theses = %w(juana_asesor_estudio_de_eventos_transitorios_economico-sociales_en_mexico admin_director_investigacion_sobre_la_administracion_publica_en_la_unam)
    @myuser_thesis = UserThesis.new({ :thesis_id => 1, :user_id => 2 , :roleinthesis_id => 3})
  end

  # Right - CRUD
  def test_creating_user_thesis_from_yaml
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      assert_equal user_theses(user_thesis.to_sym).id, @user_thesis.id
      assert_equal user_theses(user_thesis.to_sym).user_id, @user_thesis.user_id
      assert_equal user_theses(user_thesis.to_sym).roleinthesis_id, @user_thesis.roleinthesis_id
      assert_equal user_theses(user_thesis.to_sym).thesis_id, @user_thesis.thesis_id
    }
  end

  def test_updating_user_thesis_id
    @user_theses.each { |user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_equal user_theses(user_thesis.to_sym).thesis_id, @user_thesis.thesis_id

      @role.update_attribute('thesis_id', 3)
      assert_not_equal user_theses(user_thesis.to_sym).thesis_id, @user_thesis.thesis_id
    }
  end

  def test_updating_user_id
    @user_theses.each { |user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_equal user_theses(user_thesis.to_sym).user_id, @user_thesis.user_id
      @user_thesis.update_attribute('user_id', 3)
      assert_not_equal user_theses(user_thesis.to_sym).user_id, @user_thesis.user_id
    }
  end

  def test_updating_user_thesis_id
    @user_theses.each { |user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_equal user_theses(user_thesis.to_sym).roleinthesis_id, @user_thesis.roleinthesis_id
      @user_thesis.update_attribute('roleinthesis_id', 1)
      assert_not_equal user_theses(user_thesis.to_sym).roleinthesis_id, @user_thesis.roleinthesis_id
    }
  end

  def test_deleting_user_thesis
    @user_theses.each { |user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      @user_thesis.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserThesis.find(user_theses(user_thesis.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_thesis = UserThesis.new
    assert !@user_thesis.save
  end

  def test_creating_duplicated
    @user_thesis = UserThesis.new({:user_id => 2, :thesis_id => 1, :roleinthesis_id => 3 })
    assert !@user_thesis.valid?
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_thesis.id = 1.6
    assert !@myuser_thesis.valid?
    @myuser_thesis.id = 'mi_id'
    assert !@myuser_thesis.valid?
    @myuser_thesis.id = -1.0
    assert !@myuser_thesis.valid?
  end

  def test_bad_values_for_user_id
    @myuser_thesis.user_id = 1.6
    assert !@myuser_thesis.valid?
    @myuser_thesis.user_id = 'mi_id_texto'
    assert !@myuser_thesis.valid?
    @myuser_thesis.user_id = -1.0
    assert !@myuser_thesis.valid?
  end

  def test_bad_values_for_thesis_id
    @myuser_thesis.thesis_id = nil
    assert !@myuser_thesis.valid?
    @myuser_thesis.thesis_id = 1.6
    assert !@myuser_thesis.valid?
    @myuser_thesis.thesis_id = 'mi_id_texto'
    assert !@myuser_thesis.valid?
    @myuser_thesis.thesis_id = -1.0
    assert !@myuser_thesis.valid?
  end

  def test_bad_values_for_roleinthesis_id
    @myuser_thesis.roleinthesis_id = nil
    assert !@myuser_thesis.valid?
    @myuser_thesis.roleinthesis_id = 1.6
    assert !@myuser_thesis.valid?
    @myuser_thesis.roleinthesis_id = 'mi_id_texto'
    assert !@myuser_thesis.valid?
    @myuser_thesis.roleinthesis_id = -1.0
    assert !@myuser_thesis.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      assert_equal @user_thesis.user_id, User.find(@user_thesis.user_id).id
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
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      @user_thesis.user_id = 5
      begin
        return true if @user_thesis.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for thesis
  def test_cross_checking_for_thesis_id
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      assert_equal @user_thesis.thesis_id, Thesis.find(@user_thesis.thesis_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_thesis_id
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      @user_thesis.thesis_id = 1000000
      begin
        return true if @user_thesis.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for roleinthesis
  def test_cross_checking_for_thesis_id
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      assert_equal @user_thesis.roleinthesis_id, Roleinthesis.find(@user_thesis.roleinthesis_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_thesis_id
    @user_theses.each { | user_thesis|
      @user_thesis = UserThesis.find(user_theses(user_thesis.to_sym).id)
      assert_kind_of UserThesis, @user_thesis
      @user_thesis.roleinthesis_id = 1000000
      begin
        return true if @user_thesis.save
      rescue StandardError => x
        return false
      end
    }
  end

end
