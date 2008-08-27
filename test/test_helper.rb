ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require File.dirname(__FILE__) + "/factory"

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active object database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all
  def deny(condition, message)
    assert !condition, message
  end
  
  def login_as(login)
      user = User.find_by_login(login.to_s)
      @request.session[:user_id] = user.id ? user.id : nil
      user
  end

  module Shoulda # :nodoc: all
    module Extensions
        include Test::Unit::Assertions
        def should_allow_nil_value_for(*attributes)
          @record = make_model
          attributes.each do |attribute|
            @record.send("#{attribute}=", nil)
            @record.valid?
            assert !@record.errors.on(attribute), @record.errors.full_messages.join("\n")
          end
        end

        def should_not_allow_nil_value_for(*attributes)
          @record = make_model
          attributes.each do |attribute|
              @record.send("#{attribute}=", nil)
              assert_validation_with_message(/is not a number/, attribute)
          end
        end

        def should_not_allow_float_number_for(*attributes)
          @record = make_model
          attributes.each do |attribute|
            @record.send("#{attribute}=", 1.01)
            assert_validation_with_message(/is not a number/, attribute)
          end
        end

        def should_not_allow_zero_or_negative_number_for(*attributes)
          attributes.each do |attribute|
            should_not_allow_values_for attribute, -1,  :message => /must be greater than 0/
            should_not_allow_values_for attribute, 0,  :message => /must be greater than 0/
          end
        end
        
        def should_allow_only_boolean_for(*attributes)
            attributes.each do |attribute|
              should_allow_values_for attribute, [false, true]
              should_not_allow_values_for attribute, nil, :message =>  /is not included in the list/
            end
        end
        
        def assert_validation_with_message(pattern, attribute)
          model_name = @record.class
          @record.valid?
          assert @record.errors.on(attribute), "Expected #{model_name} to have an error on #{attribute}, but it did not."
          actual_error = @record.errors.on(attribute).to_s
          assert_match(pattern, actual_error, "Expected #{model_name} to have the error #{pattern}\n Real message was: #{actual_error}")
        end

        # private
        def make_model
            model =  model_class
            options = model.valid_options
            yield options if block_given?
            model.new(options)
        end
    end
  end
  include Shoulda::Extensions
  extend Shoulda::Extensions

end
