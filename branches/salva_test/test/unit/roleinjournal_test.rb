require File.dirname(__FILE__) + '/../test_helper'
require 'roleinjournal'

class RoleinjournalTest < Test::Unit::TestCase
  fixtures :roleinjournals
  def setup
    @roleinjournals = %w(compilador editor revisor)
    @myroleinjournal = Roleinjournal.new({:name => 'Arbitro'})
  end
  
  # Right - CRUD
  def test_creating_from_yaml
    @roleinjournals.each { | roleinjournal|
      @roleinjournal = Roleinjournal.find(roleinjournals(roleinjournal.to_sym).id)
      assert_kind_of Roleinjournal, @roleinjournal
      assert_equal roleinjournals(roleinjournal.to_sym).id, @roleinjournal.id
      assert_equal roleinjournals(roleinjournal.to_sym).name, @roleinjournal.name
    }
  end
  
  def test_updating_name
    @roleinjournals.each { |roleinjournal|
      @roleinjournal = Roleinjournal.find(roleinjournals(roleinjournal.to_sym).id)
      assert_equal roleinjournals(roleinjournal.to_sym).name, @roleinjournal.name
      @roleinjournal.name = @roleinjournal.name.chars.reverse 
      assert @roleinjournal.update
      assert_not_equal roleinjournals(roleinjournal.to_sym).name, @roleinjournal.name
    }
  end  

  def test_deleting
    @roleinjournals.each { |roleinjournal|
      @roleinjournal = Roleinjournal.find(roleinjournals(roleinjournal.to_sym).id)
      @roleinjournal.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Roleinjournal.find(roleinjournals(roleinjournal.to_sym).id)
      }
    }
  end

  def test_uniqueness
    @roleinjournal = Roleinjournal.new({:name => 'Compilador'})
    assert !@roleinjournal.save
  end

  def test_empty_object
    @roleinjournal = Roleinjournal.new()
    assert !@roleinjournal.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myroleinjournal.id = 'xx'
    assert !@myroleinjournal.valid?

    # Negative number ID 
    @myroleinjournal.id = -1
    assert !@myroleinjournal.valid?

    # Float number ID 
    @myroleinjournal.id = 1.3
    assert !@myroleinjournal.valid?

    # Very large number for ID 
    @myroleinjournal.id = 10000
    assert !@myroleinjournal.valid?
  end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myroleinjournal = Roleinjournal.new
    @myroleinjournal.name = nil
    assert !@myroleinjournal.valid?
  end
end
