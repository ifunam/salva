require File.dirname(__FILE__) + '/../test_helper'
require 'book'
require 'bookedition'
require 'publisher'

class StackTest < Test::Unit::TestCase

  def setup
    @stack = StackOfController.new
  end
  def push_model(model)
    @stack.push(model.new, 'new')
  end

  def pop_model
    @stack.pop
  end

  def test_push
    push_model(Book)
    assert_equal 'book', @stack.get_controller
    assert_equal 'new', @stack.get_action
  end
  
  def test_pop_models
    models = [ Book, Bookedition, Publisher ]
    models.each { |model|
      push_model(model)
      assert_equal Inflector.singularize(Inflector.tableize(model)), @stack.get_controller
    }      
    models.each { |model| pop_model }
    assert @stack.empty?
  end

end
