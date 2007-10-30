require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'skilltype'
require 'user_skill'

class UserSkillTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :skilltypes, :user_skills

  def setup
    @user_skills = %w(musicales gastronomicas domesticas)
    @myuser_skill = UserSkill.new({ :user_id => 3, :skilltype_id => 2})
  end

  # Right - CRUD
  def test_creating_user_skill_from_yaml
    @user_skills.each { | user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_kind_of UserSkill, @user_skill
      assert_equal user_skills(user_skill.to_sym).id, @user_skill.id
      assert_equal user_skills(user_skill.to_sym).user_id, @user_skill.user_id
      assert_equal user_skills(user_skill.to_sym).skilltype_id, @user_skill.skilltype_id
    }
  end

  def test_updating_skilltype_id
    @user_skills.each { |user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_equal user_skills(user_skill.to_sym).skilltype_id, @user_skill.skilltype_id
      @user_skill.skilltype_id = 4
      assert @user_skill.save
      assert_not_equal user_skills(user_skill.to_sym).skilltype_id, @user_skill.skilltype_id
    }
  end

  def test_updating_user_id
    @user_skills.each { |user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_equal user_skills(user_skill.to_sym).user_id, @user_skill.user_id
      @user_skill.user_id = 1
      assert @user_skill.save
      assert_not_equal user_skills(user_skill.to_sym).user_id, @user_skill.user_id
    }
  end

  def test_updating_descr
    @user_skills.each { |user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_equal user_skills(user_skill.to_sym).descr, @user_skill.descr
      @user_skill.descr = "nueva descripcion"
      assert @user_skill.save
      assert_not_equal user_skills(user_skill.to_sym).descr, @user_skill.descr
    }
  end

  def test_deleting_user_skills
    @user_skills.each { |user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      @user_skill.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserSkill.find(user_skills(user_skill.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_skill = UserSkill.new
    assert !@user_skill.save
  end

  def test_creating_without_required_attributes
    @user_skill = UserSkill.new({:skilltype_id => 1 })
    assert !@user_skill.save
    @user_skill = UserSkill.new({:user_id => 4 })
    assert !@user_skill.save
  end

  # Boundary
  def test_bad_values_for_id
    @myuser_skill.id = 1.6
    assert !@myuser_skill.valid?
    @myuser_skill.id = 'mi_id'
    assert !@myuser_skill.valid?

    @myuser_skill.id = -1
    assert !@myuser_skill.valid?
  end

  def test_bad_values_for_user_id
    @myuser_skill.user_id= 1.6
    assert !@myuser_skill.valid?
    @myuser_skill.user_id = 'mi_id_texto'
    assert !@myuser_skill.valid?
    @myuser_skill.user_id= -1
    assert !@myuser_skill.valid?
  end

  def test_bad_values_for_skilltype_id
    @myuser_skill.skilltype_id = nil
    assert !@myuser_skill.valid?
    @myuser_skill.skilltype_id = -1
    assert !@myuser_skill.valid?
    @myuser_skill.skilltype_id = 1.6
    assert !@myuser_skill.valid?
    @myuser_skill.skilltype_id = 'mi_id_texto'
    assert !@myuser_skill.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_skills.each { | user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_kind_of UserSkill, @user_skill
      assert_equal @user_skill.user_id, User.find(@user_skill.user_id).id
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
    @user_skills.each { | user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_kind_of UserSkill, @user_skill
      @user_skill.user_id = 5000
      begin
        return true if @user_skill.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross-Checking test for skill
  def test_cross_checking_for_skilltype_id
    @user_skills.each { | user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_kind_of UserSkill, @user_skill
      assert_equal @user_skill.skilltype_id, Skilltype.find(@user_skill.skilltype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_skilltype_id
    @user_skills.each { | user_skill|
      @user_skill = UserSkill.find(user_skills(user_skill.to_sym).id)
      assert_kind_of UserSkill, @user_skill
      @user_skill.skilltype_id = 100000
      begin
        return true if @user_skill.save
      rescue StandardError => x
        return false
      end
    }
  end
end
