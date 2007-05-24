require File.dirname(__FILE__) + '/../test_helper'
require 'roleinregularcourse'

class RoleinregularcourseTest < Test::Unit::TestCase
  fixtures :roleinregularcourses
  def setup
    @roleinregularcourses = %w(titular ayudante)
    @myroleinregularcourse = Roleinregularcourse.new({:name => 'Apoyo'})
  end
  
  # Right - CRUD
  def test_creating_from_yaml
    @roleinregularcourses.each { | roleinregularcourse|
      @roleinregularcourse = Roleinregularcourse.find(roleinregularcourses(roleinregularcourse.to_sym).id)
      assert_kind_of Roleinregularcourse, @roleinregularcourse
      assert_equal roleinregularcourses(roleinregularcourse.to_sym).id, @roleinregularcourse.id
      assert_equal roleinregularcourses(roleinregularcourse.to_sym).name, @roleinregularcourse.name
    }
  end
  
  def test_updating_name
    @roleinregularcourses.each { |roleinregularcourse|
      @roleinregularcourse = Roleinregularcourse.find(roleinregularcourses(roleinregularcourse.to_sym).id)
      assert_equal roleinregularcourses(roleinregularcourse.to_sym).name, @roleinregularcourse.name
      @roleinregularcourse.name = @roleinregularcourse.name.chars.reverse 
      assert @roleinregularcourse.update
      assert_not_equal roleinregularcourses(roleinregularcourse.to_sym).name, @roleinregularcourse.name
    }
  end  

  def test_deleting
    @roleinregularcourses.each { |roleinregularcourse|
      @roleinregularcourse = Roleinregularcourse.find(roleinregularcourses(roleinregularcourse.to_sym).id)
      @roleinregularcourse.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Roleinregularcourse.find(roleinregularcourses(roleinregularcourse.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @roleinregularcourse = Roleinregularcourse.new({:name => 'Titular'})
    assert !@roleinregularcourse.save
  end

  def test_empty_object
    @roleinregularcourse = Roleinregularcourse.new()
    assert !@roleinregularcourse.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinregularcourse.id = 'xx'
    assert !@myroleinregularcourse.valid?

    # Negative number ID 
    # @myroleinregularcourse.id = -1
    # assert !@myroleinregularcourse.valid?

    # Float number ID 
    @myroleinregularcourse.id = 1.3
    assert !@myroleinregularcourse.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinregularcourse = Roleinregularcourse.new
    @myroleinregularcourse.name = nil
    assert !@myroleinregularcourse.valid?
    @myroleinregularcourse.name = 'prueba' * 80
    assert !@myroleinregularcourse.valid?
  end
end
