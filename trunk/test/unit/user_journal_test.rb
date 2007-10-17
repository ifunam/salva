require File.dirname(__FILE__) + '/../test_helper'

require 'user'
require 'journal'
require 'roleinjournal'
require 'user_journal'

class UserJournalTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :mediatypes, :publishers, :journals, :roleinjournals, :user_journals

  def setup
    @user_journals = %w(columnista_quo compilador_conozca_mas revisor_conozca_mas)
    @myuser_journal = UserJournal.new({:user_id => 3, :journal_id => 2, :roleinjournal_id => 1, :startyear => 2007})
  end

  # Right - CRUD
  def test_creating_user_journals_from_yaml
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      assert_equal user_journals(user_journal.to_sym).id, @user_journal.id
      assert_equal user_journals(user_journal.to_sym).roleinjournal_id, @user_journal.roleinjournal_id
      assert_equal user_journals(user_journal.to_sym).journal_id, @user_journal.journal_id
      assert_equal user_journals(user_journal.to_sym).startyear, @user_journal.startyear
    }
  end

  def test_updating_user_journals_startyear
    @user_journals.each { |user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_equal user_journals(user_journal.to_sym).startyear, @user_journal.startyear
      @user_journal.startyear = @user_journal.startyear - 1
      assert @user_journal.save
      assert_not_equal user_journals(user_journal.to_sym).startyear, @user_journal.startyear
    }
  end

  def test_deleting_user_journals
    @user_journals.each { |user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      @user_journal.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        UserJournal.find(user_journals(user_journal.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @user_journal = UserJournal.new
    assert !@user_journal.save
  end

  def test_creating_duplicated_user_journal
    @user_journal = UserJournal.new({:user_id => 2 , :journal_id => 1, :roleinjournal_id => 3, :startyear => 2001})
    assert !@user_journal.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myuser_journal.id = 1.6
    assert !@myuser_journal.valid?
    @myuser_journal.id = 'mi_id'
    assert !@myuser_journal.valid?
  end

  def test_bad_values_for_roleinjournal_id
    @myuser_journal.roleinjournal_id = nil
    assert !@myuser_journal.valid?

    @myuser_journal.roleinjournal_id= 1.6
    assert !@myuser_journal.valid?

    @myuser_journal.roleinjournal_id = 'mi_id'
    assert !@myuser_journal.valid?
  end

  def test_bad_values_for_journal_id
    @myuser_journal.journal_id = nil
    assert !@myuser_journal.valid?

    @myuser_journal.journal_id = 3.1416
    assert !@myuser_journal.valid?
    @myuser_journal.journal_id = 'mi_id'
    assert !@myuser_journal.valid?
  end

  def test_bad_values_for_user_id
    @myuser_journal.user_id = nil
    assert !@myuser_journal.valid?

    @myuser_journal.user_id = 3.1416
    assert !@myuser_journal.valid?
    @myuser_journal.user_id = 'mi_id'
    assert !@myuser_journal.valid?
  end

  #Cross-Checking test

  def test_cross_checking_for_user_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      assert_equal @user_journal.user_id, User.find(@user_journal.user_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      @user_journal.user_id = 1000000
      begin
        return true if @user_journal.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_journal_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      assert_equal @user_journal.journal_id, Journal.find(@user_journal.journal_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_journal_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      @user_journal.journal_id = 1000000
      begin
        return true if @user_journal.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_roleinjournal_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)

      assert_kind_of UserJournal, @user_journal
      assert_equal @user_journal.roleinjournal_id, Roleinjournal.find(@user_journal.roleinjournal_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinjournal_id
    @user_journals.each { | user_journal|
      @user_journal = UserJournal.find(user_journals(user_journal.to_sym).id)
      assert_kind_of UserJournal, @user_journal
      @user_journal.roleinjournal_id = 100000
      begin
        return true if @user_journal.save
      rescue StandardError => x
        return false
      end
    }
  end

end
