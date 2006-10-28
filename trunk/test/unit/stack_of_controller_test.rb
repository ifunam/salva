require File.dirname(__FILE__) + '/../test_helper'
require 'user_course'
require 'course'

class StackTest < Test::Unit::TestCase

  def setup
    @stack = StackOfController.new
  end
  def push_model(model,handler)
    @stack.push(model.new, 'new', handler)
  end

  def pop_model
    @stack.pop
  end

  def test_push
    push_model(UserCourse, 'course_id')
    assert_equal 'user_course', @stack.get_controller
    assert_equal 'new', @stack.get_action
  end
  
  def test_pop_model
    push_model(UserCourse,'course_id')
    @stack.set_handler_id(10)
    assert_equal 'user_course', @stack.get_controller
    assert_equal 'new', @stack.get_action
    assert_equal 10, @stack.get_model.course_id
    pop_model 
    assert @stack.empty?
  end
end
