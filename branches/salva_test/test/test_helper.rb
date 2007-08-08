ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase

  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = false

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
  def deny(condition, message)
    assert !condition, message
  end


  # Simple CRUD (Create-Read, Update and Delete) testing methods
  module UnitSimple
    # Create and Read test
    def create(keys,model)
      #print "Running *Create and Read*\n"
      fixture = method(Inflector.pluralize(model.name).downcase)
      keys.each { | item |
        @model = model.find(fixture.call(item.to_sym).id)
        assert_kind_of model, @model
        assert_equal fixture.call(item.to_sym).id, @model.id
        assert_equal fixture.call(item.to_sym).name, @model.name
      }
    end

    def update(keys,model)
      fixture = method(Inflector.pluralize(model.name).downcase)
      keys.each { | item |
        @model = model.find(fixture.call(item.to_sym).id)
        assert_equal fixture.call(item.to_sym).name, @model.name
        name = @model.name.chars.reverse
        @model.name = name
        assert @model.save, @model.errors.full_messages.join("; ")
        @model.reload
        assert_equal name, @model.name
      }
    end

    def delete(keys,model)
      fixture = method(Inflector.pluralize(model.name).downcase)
      keys.each { | item |
        @model = model.find(fixture.call(item.to_sym).id)
        @model.destroy
        assert_raise (ActiveRecord::RecordNotFound) {
          model.find(fixture.call(item.to_sym).id)
        }
      }
    end

    def crud_test(keys,model)
      create(keys,model)
      update(keys,model)
      delete(keys,model)
     end

    def validate_test(keys,model)
      fixture = method(Inflector.pluralize(model.name).downcase)
      keys.each { | item |
        @model = model.find(fixture.call(item.to_sym).id)
        assert_equal fixture.call(item.to_sym).id, @model.id
        assert_equal fixture.call(item.to_sym).name, @model.name
        @model.name = nil
        assert !@model.save
        assert_not_nil @model.errors.count
      }
    end

    def collision_test(values,model)
      fixture = method(Inflector.pluralize(model.name).downcase)
      values.each { | item |
        @model = model.find(fixture.call(item.to_sym).id)
        @newmodel = model.new
        @newmodel.name = @model.name
        assert_not_nil @newmodel.errors.count
      }
    end
  end

  module Session
    def login_as (user, password)
      @controller = UserController.new
      post :signup, :user => { :login => user, :passwd => 'maltiempo'}
    end
  end

  def teardown
    self.class.fixture_table_names.reverse.each do |table_name|
      klass_name = Inflector.classify(table_name.to_s)
      if Object.const_defined?(klass_name)
        klass = Object.const_get(klass_name)
        klass.connection.delete("DELETE FROM #{table_name}", 'Fixture Delete')
      else
        flunk("Cannot find class for table '#{table_name}' to delete fixtures")
      end
    end
  end
end

