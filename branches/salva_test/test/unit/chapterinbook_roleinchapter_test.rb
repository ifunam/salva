require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'roleinchapter'
require 'chapterinbook'
require 'chapterinbook_roleinchapter'

class ChapterinbookRoleinchapterTest < Test::Unit::TestCase

fixtures :roleinchapters, :userstatuses, :users, :booktypes, :bookchaptertypes, :editionstatuses, :mediatypes, :editions, :countries, :books, :bookeditions, :chapterinbooks, :chapterinbook_roleinchapters 


  def setup
    @chapterinbookroleinchapters = %w(juana panchito)
    @mychapterinbookroleinchapter = ChapterinbookRoleinchapter.new({:user_id =>1, :chapterinbook_id => 12, :roleinchapter_id => 3})
  end

  # Right - CRUD
  def test_creating_chapterinbookroleinchapters_from_yaml
    @chapterinbookroleinchapters.each { | chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      assert_kind_of ChapterinbookRoleinchapter, @chapterinbookroleinchapter
      assert_equal chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id, @chapterinbookroleinchapter.id
      assert_equal chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).user_id, @chapterinbookroleinchapter.user_id
      assert_equal chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).chapterinbook_id, @chapterinbookroleinchapter.chapterinbook_id
      assert_equal chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).roleinchapter_id, @chapterinbookroleinchapter.roleinchapter_id
    }
  end

  def test_deleting_chapterinbookroleinchapters
    @chapterinbookroleinchapters.each { |chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      @chapterinbookroleinchapter.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @chapterinbookroleinchapter = ChapterinbookRoleinchapter.new
    assert !@chapterinbookroleinchapter.save
  end

  def test_creating_duplicated_chapterinbookroleinchapter
    @chapterinbookroleinchapter = ChapterinbookRoleinchapter.new({:user_id =>1, :chapterinbook_id => 12, :roleinchapter_id => 3})
    assert !@chapterinbookroleinchapter.save
  end

  # Boundary
  def test_bad_values_for_user_id
    # Float number for ID
    @mychapterinbookroleinchapter.user_id = 1.6
    assert !@mychapterinbookroleinchapter.valid?
    @mychapterinbookroleinchapter.user_id = 'mi_id'
    assert !@mychapterinbookroleinchapter.valid?
  end

  def test_bad_values_for_chapterinbook_id
    @mychapterinbookroleinchapter.chapterinbook_id = nil
    assert !@mychapterinbookroleinchapter.valid?

    @mychapterinbookroleinchapter.chapterinbook_id = 1.6
    assert !@mychapterinbookroleinchapter.valid?

    @mychapterinbookroleinchapter.chapterinbook_id = 'mi_id'
    assert !@mychapterinbookroleinchapter.valid?
  end

  def test_bad_values_for_roleinchapter_id
    @mychapterinbookroleinchapter.roleinchapter_id = nil
    assert !@mychapterinbookroleinchapter.valid?

    @mychapterinbookroleinchapter.roleinchapter_id = 3.1416
    assert !@mychapterinbookroleinchapter.valid?
    @mychapterinbookroleinchapter.roleinchapter_id = 'mi_id'
    assert !@mychapterinbookroleinchapter.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_chapterinbook_id
    @chapterinbookroleinchapters.each { | chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      assert_kind_of ChapterinbookRoleinchapter, @chapterinbookroleinchapter
      assert_equal @chapterinbookroleinchapter.chapterinbook_id, Chapterinbook.find(@chapterinbookroleinchapter.chapterinbook_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_chapterinbook_id
    @chapterinbookroleinchapters.each { | chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      assert_kind_of ChapterinbookRoleinchapter, @chapterinbookroleinchapter
      @chapterinbookroleinchapter.chapterinbook_id = 1000000
      begin
        return true if @chapterinbookroleinchapter.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_roleinchapter_id
    @chapterinbookroleinchapters.each { | chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)

      assert_kind_of ChapterinbookRoleinchapter, @chapterinbookroleinchapter
      assert_equal @chapterinbookroleinchapter.roleinchapter_id, Roleinchapter.find(@chapterinbookroleinchapter.roleinchapter_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_roleinchapter_id
    @chapterinbookroleinchapters.each { | chapterinbook_roleinchapter|
      @chapterinbookroleinchapter = ChapterinbookRoleinchapter.find(chapterinbook_roleinchapters(chapterinbook_roleinchapter.to_sym).id)
      assert_kind_of ChapterinbookRoleinchapter, @chapterinbookroleinchapter
      @chapterinbookroleinchapter.roleinchapter_id = 100000
      begin
        return true if @chapterinbookroleinchapter.update
      rescue StandardError => x
        return false
      end
    }
  end

end
