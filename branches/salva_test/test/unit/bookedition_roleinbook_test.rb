require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'bookedition'
require 'roleinbook'
require 'bookedition_roleinbook'

class BookeditionRoleinbookTest < Test::Unit::TestCase
  fixtures :countries, :booktypes, :books, :editions, :mediatypes, :editionstatuses, :bookeditions, :userstatuses, :users, :roleinbooks, :bookedition_roleinbooks

  def setup
    @bookedition_roleinbooks = %w(sismologia_autor_administrador earthquakes_coautor_juana spacephysics_revisor_panchito)
    @mybookedition_roleinbook = BookeditionRoleinbook.new({:user_id => 1, :bookedition_id => 2,:roleinbook_id => 2})
  end

  # Right - CRUD
  def test_creating_bookedition_roleinbooks_from_yaml
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      assert_equal bookedition_roleinbooks(bookedition_roleinbook.to_sym).id, @bookedition_roleinbook.id
      assert_equal bookedition_roleinbooks(bookedition_roleinbook.to_sym).bookedition_id, @bookedition_roleinbook.bookedition_id
      assert_equal bookedition_roleinbooks(bookedition_roleinbook.to_sym).user_id, @bookedition_roleinbook.user_id
      assert_equal bookedition_roleinbooks(bookedition_roleinbook.to_sym).roleinbook_id, @bookedition_roleinbook.roleinbook_id

    }
  end

  def test_deleting_bookedition_roleinbooks
    @bookedition_roleinbooks.each { |bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      @bookedition_roleinbook.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @bookedition_roleinbook = BookeditionRoleinbook.new
    assert !@bookedition_roleinbook.save
  end

  def test_creating_duplicated_bookedition_roleinbook
    @bookedition_roleinbook = BookeditionRoleinbook.new({:user_id => 2, :bookedition_id => 2, :roleinbook_id => 2})
    assert !@bookedition_roleinbook.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mybookedition_roleinbook.id = 1.6
    assert !@mybookedition_roleinbook.valid?
    @mybookedition_roleinbook.id = 'mi_id'
    assert !@mybookedition_roleinbook.valid?
  end

  def test_bad_values_for_bookedition_id
    @mybookedition_roleinbook.bookedition_id = nil
    assert !@mybookedition_roleinbook.valid?

    @mybookedition_roleinbook.bookedition_id= 1.6
    assert !@mybookedition_roleinbook.valid?

    @mybookedition_roleinbook.bookedition_id = 'mi_id'
    assert !@mybookedition_roleinbook.valid?
  end

  def test_bad_values_for_user_id
    @mybookedition_roleinbook.user_id = nil
    assert !@mybookedition_roleinbook.valid?

    @mybookedition_roleinbook.user_id = 3.1416
    assert !@mybookedition_roleinbook.valid?
    @mybookedition_roleinbook.user_id = 'mi_id'
    assert !@mybookedition_roleinbook.valid?
  end

  def test_bad_values_for_roleinbook_id
    @mybookedition_roleinbook.roleinbook_id = nil
    assert !@mybookedition_roleinbook.valid?

    @mybookedition_roleinbook.roleinbook_id = 3.1416
    assert !@mybookedition_roleinbook.valid?
    @mybookedition_roleinbook.roleinbook_id = 'mi_id'
    assert !@mybookedition_roleinbook.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_user_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      assert_equal @bookedition_roleinbook.user_id, User.find(@bookedition_roleinbook.user_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      @bookedition_roleinbook.user_id = 1000000
      begin
        return true if @bookedition_roleinbook.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_roleinbook_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      assert_equal @bookedition_roleinbook.roleinbook_id, Roleinbook.find(@bookedition_roleinbook.roleinbook_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinbook_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      @bookedition_roleinbook.roleinbook_id = 1000000
      begin
        return true if @bookedition_roleinbook.update
      rescue StandardError => x
        return false
      end
    }
  end


  def test_cross_checking_for_bookedition_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)

      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      assert_equal @bookedition_roleinbook.bookedition_id, Bookedition.find(@bookedition_roleinbook.bookedition_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_bookedition_id
    @bookedition_roleinbooks.each { | bookedition_roleinbook|
      @bookedition_roleinbook = BookeditionRoleinbook.find(bookedition_roleinbooks(bookedition_roleinbook.to_sym).id)
      assert_kind_of BookeditionRoleinbook, @bookedition_roleinbook
      @bookedition_roleinbook.bookedition_id = 100000
      begin
        return true if @bookedition_roleinbook.update
      rescue StandardError => x
        return false
      end
    }
  end
end
