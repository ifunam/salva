require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'course'
require 'roleincourse'
require 'user_course'

class UserCourseTest < Test::Unit::TestCase
  fixtures :userstatuses, :roleincourses, :countries, :states, :cities, :users, :modalities, :coursedurations, :courses, :user_courses

  def setup
    @user_courses = %w(linux matematicas)
    @myuser_course = UserCourse.new({:course_id => 2, :user_id => 4, :roleincourse_id => 1})
  end

  # Right - CRUD
  def test_creating_user_course_from_yaml
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      assert_equal user_courses(user_course.to_sym).id, @user_course.id
      assert_equal user_courses(user_course.to_sym).user_id, @user_course.user_id
      assert_equal user_courses(user_course.to_sym).course_id, @user_course.course_id
      assert_equal user_courses(user_course.to_sym).roleincourse_id, @user_course.roleincourse_id
    }
  end

  def test_updating_course_id
    @user_courses.each { |user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_equal user_courses(user_course.to_sym).course_id, @user_course.course_id
      @user_course.update_attribute('course_id', 3)
      assert_not_equal user_courses(user_course.to_sym).course_id, @user_course.course_id
    }
  end

  def test_updating_roleincourse_id
    @user_courses.each { |user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_equal user_courses(user_course.to_sym).roleincourse_id, @user_course.roleincourse_id
      @user_course.update_attribute('roleincourse_id', 1)
      assert_not_equal user_courses(user_course.to_sym).roleincourse_id, @user_course.roleincourse_id
    }
  end

  def test_deleting_user_courses
    @user_courses.each { |user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      @user_course.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserCourse.find(user_courses(user_course.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_course = UserCourse.new
    assert !@user_course.save
  end

  #     def test_creating_duplicated
  #      @user_course = UserCourse.new({:user_id => 2, :course_id => 1 , :roleincourse_id => 2})
  #      assert !@user_course.save
  #    end

  # Boundary
  def test_bad_values_for_id
    @myuser_course.id = 1.6
    assert !@myuser_course.valid?
    @myuser_course.id = 'mi_id'
    assert !@myuser_course.valid?
  end

  def test_bad_values_for_user_id
    # @myuser_course.user_id = nil
    # assert !@myuser_course.valid?
    @myuser_course.user_id= 1.6
    assert !@myuser_course.valid?
    @myuser_course.user_id = 'mi_id_texto'
    assert !@myuser_course.valid?
  end

  def test_bad_values_for_course_id
    @myuser_course.course_id = nil
    assert !@myuser_course.valid?
    @myuser_course.course_id = 1.6
    assert !@myuser_course.valid?
    @myuser_course.course_id = 'mi_id_texto'
    assert !@myuser_course.valid?
  end

  def test_bad_values_for_roleincourse_id
    @myuser_course.roleincourse_id = nil
    assert !@myuser_course.valid?
    @myuser_course.roleincourse_id = 1.6
    assert !@myuser_course.valid?
    @myuser_course.roleincourse_id = 'mi_id_texto'
    assert !@myuser_course.valid?
  end

  #cross-Checking test for user
  def test_cross_checking_for_user_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      assert_equal @user_course.user_id, User.find(@user_course.user_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def  test_cross_checking_with_bad_values_for_user_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      @user_course.user_id = 500000
      begin
        return true if @user_course.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for course
  def test_cross_checking_for_course_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      assert_equal @user_course.course_id, Course.find(@user_course.course_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_course_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      @user_course.course_id = 80000
      assert @user_course.valid?
      begin
        return true if @user_course.save
      rescue StandardError => x
        return false
      end
    }
  end

  #cross check for roleincourse
  def test_cross_checking_for_course_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      assert_equal @user_course.roleincourse_id, Roleincourse.find(@user_course.roleincourse_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleincourse_id
    @user_courses.each { | user_course|
      @user_course = UserCourse.find(user_courses(user_course.to_sym).id)
      assert_kind_of UserCourse, @user_course
      @user_course.roleincourse_id = 80000
      assert !@user_course.save
      begin
        return true if @user_course.save
      rescue StandardError => x
        return false
      end
    }
  end
end
