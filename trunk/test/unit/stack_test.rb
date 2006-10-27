require File.dirname(__FILE__) + '/../test_helper'
require 'book'
require 'bookedition'
require 'publisher'

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
    push_model(Book, 'bookedition_id')
    assert_equal 'book', @stack.get_controller
    assert_equal 'new', @stack.get_action
    assert_equal 'bookedition_id', @stack.get_handler
  end
  
  def test_pop_model
    push_model(Book,'bookedition_id')
    @stack.set_handler_id(10)
    assert_equal 'book', @stack.get_controller
    assert_equal 'new', @stack.get_action
    assert_equal 'bookedition_id', @stack.get_handler
    assert_not_equal 1, @stack.get_handler_id
    assert_equal 10, @stack.get_handler_id
    pop_model 
    assert @stack.empty?
  end
end
