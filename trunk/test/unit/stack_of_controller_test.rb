require File.dirname(__FILE__) + '/../test_helper'
class StackTest < Test::Unit::TestCase

  def setup
    @stack = StackOfController.new
  end

  def test_should_push_controller_and_action
    @stack.push('people_identification', 'new')
    assert_equal  'people_identification', @stack.controller
    assert_equal 'new', @stack.action
    @stack.clear
    assert @stack.empty?
  end

  def test_should_push_controller_and_action_and_id
    @stack.push('project', 'show', 10)
    assert_equal 'project', @stack.controller
    assert_equal 'show', @stack.action
    assert_equal 10, @stack.id
    @stack.clear
    assert @stack.empty?
  end

  def test_should_push_controller_and_action_and_model
    @stack.push('article', 'new', nil, Article.new)
    assert_equal 'article', @stack.controller
    assert_equal 'new', @stack.action
    assert_equal nil, @stack.id
    assert_instance_of Article, @stack.model
    @stack.clear
    assert @stack.empty?
  end

  def test_should_push_controller_and_action_and_model_and_attribute
    @stack.push('article', 'new', nil, Article.new, 'journal_id' )
    assert_equal 'article', @stack.controller
    assert_equal 'new', @stack.action
    assert_equal nil, @stack.id
    assert_instance_of Article, @stack.model
    assert_equal 'journal_id', @stack.attribute
    @stack.clear
    assert @stack.empty?
  end

  def test_should_push_controller_and_action_and_model_and_updated_attribute
    @stack.push('article', 'new', nil, Article.new, 'journal_id' )
    assert_equal 'article', @stack.controller
    assert_equal 'new', @stack.action
    assert_equal nil, @stack.id
    assert_instance_of Article, @stack.model
    assert_equal 'journal_id', @stack.attribute
    assert_equal  nil, @stack.model.journal_id
    @stack.set_attribute(10)
    assert_equal  10, @stack.model.journal_id
    @stack.clear
    assert @stack.empty?
  end

  def test_should_push_modelsecuence
    @stack.push('wizard', 'new', nil, ModelSequence.new([Schooling, Professionaltitle]),  'institutioncareer_id')
    assert_equal Schooling, @stack.model.class.name.constantize
    assert_equal  'wizard', @stack.controller
    assert_equal  'new', @stack.action
    assert_equal nil, @stack.id
    assert_equal 'institutioncareer_id', @stack.attribute
    @stack.clear
    assert @stack.empty?
  end

  def test_should_pop_model_from_stack
    @stack.push('person', 'new', nil, Person.new,  'country_id')
    @stack.pop
    deny @stack.pop, "The stack should be empty"
    assert @stack.empty?
  end

  def test_should_get_and_pop_model_from_stack
    @stack.push('person', 'new', nil, Person.new,  'country_id')
    assert_kind_of Person, @stack.model
    @stack.pop
    deny @stack.pop, "The stack should be empty"
    assert @stack.empty?
  end

  def test_should_clear_model_from_stack
    @stack.push('user_article', 'new', nil, UserArticle.new, 'article_id' )
    @stack.push('article', 'new', nil, Article.new, 'journal_id' )
    @stack.push('journal', 'new', nil, Journal.new, 'volume_id' )
    assert_equal 3, @stack.size
    assert @stack.clear
    assert @stack.empty?
  end

  def test_checking_inclusion_of_controllers
    @stack.push('user_article', 'new', nil, UserArticle.new, 'article_id' )
    @stack.push('article', 'new', nil, Article.new, 'journal_id' )
    @stack.push('journal', 'new', nil, Journal.new, 'volume_id' )
    assert @stack.included_controller?('user_article')
    assert @stack.included_controller?('article')
    assert @stack.included_controller?('journal')
    assert_equal 'journal', @stack.controller
    assert !@stack.included_controller?('unexistent_return_controller')
    @stack.clear
    assert @stack.empty?
  end

  def test_deleting_items_after_controller
    @stack.push('user_article', 'new', nil, UserArticle.new, 'article_id' )
    @stack.push('article', 'new', nil, Article.new, 'journal_id' )
    @stack.push('journal', 'new', nil, Journal.new, 'volume_id' )
    @stack.push('volume', 'new', nil, Volume.new, 'user_id' )
    assert_equal 4, @stack.size
    @stack.delete_after_controller('article')
    assert_equal 2, @stack.size
    assert_equal 'article', @stack.controller
    @stack.clear
    assert @stack.empty?
  end

    def test_should_push_controller_and_action_and_hash
      filter = { :country_id => 484, :state_id => 1 }
      @stack.push('article', 'new', nil, filter, :state_id)
      assert_equal 'article', @stack.controller
      assert_equal 'new', @stack.action
      assert_equal nil, @stack.id
      assert_instance_of Hash, @stack.model
      assert_equal :state_id, @stack.attribute
      assert_equal 1, @stack.model[:state_id]
      @stack.set_attribute(10)
      assert_equal 10, @stack.model[:state_id]
      @stack.clear
      assert @stack.empty?
    end

    #   def test_should_add_error_with_an_invalid_attribute
  #     deny @stack.push(Person.new, 'new', 'country'), "The attribute should have been invalid"
  #   end

 end
