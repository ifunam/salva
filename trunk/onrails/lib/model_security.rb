require 'once'

module ModelSecurity
private
  # Functions that are both class and instance methods within ModelSecurity.
  module BothClassAndInstanceMethods
  private
    # Run a single test. 
    def run_test t
      case t.class.name
      when 'Proc'
        return t.call(binding)
      when 'Symbol'
        return self.send(t)
      when 'String'
        return eval(t)
      else
        return false
      end
    end
  
    # This does the permission test for readable?, writable?, and display?. 
    # A global variable is used to short-circuit recursion.
    # 
    # FIX: The global variable should be replaced with a thread-local variable
    # once I learn how to make one. 
    #
    def run_tests(d, attribute)
      global = d[:all]
      local = d[attribute.to_sym]
      result = true
  
      if (global or local) and ($in_test_permission != true)
        $in_test_permission = true
        result = (run_test(global) or run_test(local))
        $in_test_permission = false
      end
      return result
    end
  
  public
    # Stub test for let_read and friends. Always returns true.
    def always?
      true
    end
  
    # Stub test for let_read and friends. Always returns false.
    def never?
      false
    end
  end
end

# Class methods for ModelSecurity. They are broken out this way so that they
# can be fed to base.extend(), Ruby interpreter magic so that class methods
# of this module work while a class including it is being defined.
# Uses a Rails-internal inheritable-attribute mechanism so that this data in a
# derived class survives modification of similar data in its base class.
#
module ModelSecurity
private
  module ClassMethods
  private
    include BothClassAndInstanceMethods
  
    # Internal function where the work of let_read, let_write, let_access,
    # and let_display is done. Store the tests to be run for each attribute
    # in the class, to be evaluated later. *permission* is :let_read,
    # :let_write, or :let_display. *arguments* is a list of attributes
    # upon which security permissions are being declared and a hash
    # containing all options, currently just :if . *block*, if given,
    # contains a security test.
    #
    def let(permission, arguments, block)
      attributes = []	# List of attributes that this permission applies to.
      parameters = {}	# Optional parameters, currently only :if
      procedure = nil	# Permission-test procedure.
  
      arguments.each { | argument |
	case argument.class.name
	when 'Hash'
	  parameters.merge! argument
	else
	  attributes << argument
	end
      }
      if not block.nil?
	procedure = block
      elsif (p = parameters[:if])
	procedure = p
      else
	procedure = :always?
      end
  
      d = {}
      attributes.each { | name | d[name] = procedure }
      write_inheritable_hash(permission, d)
    end
  
  public
  
    # Install default permissions for all of the attributes that Rails defines.
    #
    # Readable:
    #	created_at, created_on, type, id, updated_at, updated_on,
    #	lock_version, position, parent_id, lft, rgt,
    #	table_name + '_count'
    #
    # Writable:
    #	updated_at, updated_on, lock_version, position, parent_id, lft, rgt
    #
    # Writable only before the first save of an Active Record:
    #	created_at, created_on, type, id
    #
    def default_permissions
      let_read :created_at, :created_on, :type, :id, :updated_at, \
       :updated_on, :lock_version, :position, :parent_id, :lft, :rgt, \
       (table_name + '_count').to_sym
  
      # These shouldn't change after the first save.
      let_write :created_at, :created_on, :type, :id, :if => :new_record?
  
      # These can change.
      let_write :updated_at, :updated_on, :lock_version, :position, :parent_id, \
       :lft, :rgt
    end
  
    # Return true if display of the attribute is permitted. *attribute* is a
    # symbol, and should match a field in the database schema corresponding to
    # this model.
    def display?(attribute)
      if (d = read_inheritable_attribute(:let_display))
	return run_tests(d, attribute)
      else
	return true
      end
    end
  
    # Declare whether reads and writes are permitted on the named attributes.
    def let_access(*arguments, &block)
      let(:let_read, arguments, block)
      let(:let_write, arguments, block)
    end
  
    # Declare whether display of the named attribute is permitted.
    def let_display(*arguments, &block)
      let(:let_display, arguments, block)
    end
  
  
    # Declare whether read is permitted upon the named attributes.
    def let_read(*arguments, &block)
      let(:let_read, arguments, block)
    end
  
    # Declare whether write is permitted upon the named attributes.
    def let_write(*arguments, &block)
      let(:let_write, arguments, block)
    end
  end
end

# The ModelSecurity module allows you to specify security permissions on any
# or all of the attributes of a model implemented using ActiveRecord.
#
# Security permissions are
# specified in the declaration of the model's class, similarly to the way
# you can specify validators. The specification includes the names of
# attributes to which permissions apply, and an optional permission test that
# should return true or false depending on whether the access should be allowed
# or denied.
#
#  let_read :attribute|:all [[, :attribute ] ...], [:if => :test-name] [do block end]
#  let_write :attribute|:all [[, :attribute ] ...], [:if => :test-name] [do block end]
#  let_access :attribute|:all [[, :attribute ] ...], [:if => :test-name] [do block end]
#
# let_read specifies when the attribute can be read, let_write specifies when
# it can be written, and let_access does both.
#
# If no permission test is specified, that is the same as specifying a test
# that always returns true. Two stub tests are provided:
#
#  :always?
#
# Always returns true.
#
#  :never?
#
# Always returns false.
#
# You can easily add your own tests as instance methods of your model:
#
#  let_read :phone_number :if => :admin?
#
#  def admin?
#    return $current_login.is_the_administrator
#  end
#
# If the permission test is specified using the syntax
#  :if => :test-name
# it will be run as a method of the model this way:
#  self.send(:test-name)
#
# If the permission test is specified as a block, using *do* and *end*,
# it will be called with the binding of the active record instance that
# is being accessed.
#
# Permission tests can also be strings, and these are passed to eval().
#
# The special attribute name :all means that a test will be applied to all
# attributes of the model. Any tests for :all are run first, then any tests
# for the specific attribute. Any test that returns true ends the run, further
# tests will not be evaluated.
#
# If *no* security permissions are declared for an attribute or :all, that
# attribute may always be accessed. Once a test for :all is delcared, that
# test will apply to all attributes of the model.
#
# The security tests themselves may access any data with impunity. A global
# variable is used to disable further security testing while a security test
# is in progress.
#
# = Display Control
#
# A companion mechanism is used to control views, including scaffold views,
# using a syntax similar to that for security specifications:
#
#  let_display :attribute|:all [[, :attribute ] ...], [:if => :test-name] [do block end]
#
# let_display is mostly useful for specifying if a table view should have a
# column for a particular attribute. Its tests must be declared as class
# methods of the model, while the tests of let_read, let_write, and
# let_access are instance methods. This is because the information declared
# by let_display is accessed before iteration over active records begins.
#
#
# = Accessing Security Test Results
#
# ModelSecurity provides two instance methods, readable? and writable?
# to inform the program if a particular attribute can be accessed. The class
# method display? will return true or false depending upon whether a
# particular attribute should be displayed. These can
# be used to modify a view so that any non-writable data will not be presented
# in an editable field. ModelSecurityHelper overloads the methods that are
# usually
# used to edit models so that they will not attempt to read or write what they
# aren't permitted and will render appropriately for the permissions on any
# model attribute. Those methods are: check_box, file_field, hidden_field,
# password_field, radio_button, text_area, text_field.
# ModelSecurityHelper also replaces the scaffold views with versions that
# never access data when not permitted to, render appropriately for the
# permissions on an attribute, and omit columns for which display? returns
# false.
#
#
# = Exceptions
#
# ActiveRecord provides two internal methods that perform normal attribute
# accesses: read_attribute, and write_attribute. These are overloaded to
# perform security testing, and will raise *SecurityError* when an unpermitted
# access is attempted.
#
module ModelSecurity
  include BothClassAndInstanceMethods

  # This does the permission test for readable? or writable?.
  def test_permission(permission, attribute)
    if (d = self.class.read_inheritable_attribute(permission))
      return run_tests(d, attribute)
    else
      return true
    end
  end
private

  # Responsible for raising an exception when an unpermitted security
  # access is attempted. *permission* is :let_read or :let_write.
  # *attribute* is the name of the attribute upon which an access is
  # being attempted.
  #
  def security_error(permission, attribute)
    global = nil
    local = nil

    if (d = self.class.read_inheritable_attribute(permission))
      global = d[:all]
      local = d[attribute.to_sym]
    end

    message = "SECURITY VIOLATON: #{permission} on attribute #{attribute}" \
     "\n\tof object: #{self.inspect}."

    if global
      message << "\n\tTest for :all is #{global.inspect}."
    end

    if local
      message << "\n\tTest for :#{attribute} is #{local.inspect}."
    end

    raise SecurityError.new(message)
  end

public
  # Ruby interpreter magic to cause the class methods herein to work correctly
  # while a class including this module is still being declared.
  def self.append_features(base)
    super
    base.extend(ClassMethods)

    # Define default permissions for attributes like :id that are used by
    # Rails.
    base.default_permissions
  end


  # Return true if a read of *attribute* is permitted.
  # *attribute* should be a symbol, and should be the
  # name of a database field for this model.
  def readable?(attribute)
    test_permission(:let_read, attribute)
  end

  # Overloads ActiveRecord::Base#read_attribute. Read the attribute if that is
  # permitted. Otherwise, throw an exception.
  def read_attribute(name)
    if not readable?(name)
      security_error(:let_read, name)
    end
    old_read_attribute(name)
  end

  # Return true if a write of *attribute* is permitted.
  # *attribute* should be a symbol, and should be the
  # name of a database field for this model.
  def writable?(attribute)
    test_permission(:let_write, attribute)
  end
  
  # Overloads ActiveRecord::Base#write_attribute. Write the attribute if that is
  # permitted. Otherwise, throw an exception.
  def write_attribute(name, value)
    if not writable?(name)
      security_error(:let_write, name)
    end
    old_write_attribute(name, value)
  end
end

