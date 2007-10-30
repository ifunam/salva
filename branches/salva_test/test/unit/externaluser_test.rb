require File.dirname(__FILE__) + '/../test_helper'
require 'externaluser'

class ExternaluserTest < Test::Unit::TestCase
  fixtures :externalusers
  def setup
    @externalusers = %w(external_user01 external_user02)
    @myexternaluser = Externaluser.new({:firstname => 'Eliane',  :lastname1 => 'Ceccon'})
  end

  # Right - CRUD
  def test_creating_from_yaml
    @externalusers.each { | externaluser|
      @externaluser = Externaluser.find(externalusers(externaluser.to_sym).id)
      assert_kind_of Externaluser, @externaluser
      assert_equal externalusers(externaluser.to_sym).id, @externaluser.id
      assert_equal externalusers(externaluser.to_sym).firstname, @externaluser.firstname
      assert_equal externalusers(externaluser.to_sym).lastname1, @externaluser.lastname1
    }
  end

  def test_updating_name
    @externalusers.each { |externaluser|
      @externaluser = Externaluser.find(externalusers(externaluser.to_sym).id)
      assert_equal externalusers(externaluser.to_sym).firstname, @externaluser.firstname
      @externaluser.firstname = @externaluser.firstname.chars.reverse
      assert @externaluser.save
      assert_not_equal externalusers(externaluser.to_sym).firstname, @externaluser.firstname

      @externaluser.lastname1 = @externaluser.lastname1.chars.reverse
      assert @externaluser.save
      assert_not_equal externalusers(externaluser.to_sym).lastname1, @externaluser.lastname1
    }
  end

  def test_deleting
    @externalusers.each { |externaluser|
      @externaluser = Externaluser.find(externalusers(externaluser.to_sym).id)
      @externaluser.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Externaluser.find(externalusers(externaluser.to_sym).id)
      }
    }
  end

  def test_empty_object
    @externaluser = Externaluser.new()
    assert !@externaluser.save
  end

  # Boundaries
  def test_bad_values_for_id
    @myexternaluser.id = 'xx'
    assert !@myexternaluser.valid?

    # Negative number ID
    @myexternaluser.id = -1
    assert !@myexternaluser.valid?

    # Float number ID
    @myexternaluser.id = 1.3
    assert !@myexternaluser.valid?
  end

  def test_bad_values_for_institution_id
    @myexternaluser.institution_id = 'xx'
    assert !@myexternaluser.valid?

    # Negative number
    @myexternaluser.institution_id = -1
    assert !@myexternaluser.valid?

    # Float number
    @myexternaluser.institution_id = 1.3
    assert !@myexternaluser.valid?
  end

  def test_bad_values_for_externaluserlevel_id
    @myexternaluser.externaluserlevel_id = 'xx'
    assert !@myexternaluser.valid?

    # Negative number
    @myexternaluser.externaluserlevel_id = -1
    assert !@myexternaluser.valid?

    # Float number
    @myexternaluser.externaluserlevel_id = 1.3
    assert !@myexternaluser.valid?

    @myexternaluser.externaluserlevel_id = nil
    assert @myexternaluser.valid?
  end

  def test_bad_values_for_degree_id
    @myexternaluser.degree_id = 'xx'
    assert !@myexternaluser.valid?

    # Negative number
    @myexternaluser.degree_id = -1
    assert !@myexternaluser.valid?

    # Float number
    @myexternaluser.degree_id = 1.3
    assert !@myexternaluser.valid?

    @myexternaluser.degree_id = nil
    assert @myexternaluser.valid?
  end

  def test_bad_values_for_firstname
    # Checking constraints for firstname
    # Nil firstname

    @myexternaluser.firstname = nil
    assert !@myexternaluser.valid?

    @myexternaluser.lastname1 = nil
    assert !@myexternaluser.valid?
  end
end
