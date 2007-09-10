require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'chapterinbook'
require 'chapterinbook_comment'

class ChapterinbookCommentTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :booktypes, :books, :editions, :publishers, :mediatypes, :editionstatuses, :bookeditions, :bookchaptertypes, :chapterinbooks, :chapterinbook_comments

  def setup
    @chapterinbook_comments = %w(tema_para_licenciatura tema_para_maestria)
    @mychapterinbook_comment = ChapterinbookComment.new({:user_id => 1, :chapterinbook_id => 2})
  end

  # Right - CRUD
  def test_creating_chapterinbook_comments_from_yaml
    @chapterinbook_comments.each { | chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      assert_kind_of ChapterinbookComment, @chapterinbook_comment
      assert_equal chapterinbook_comments(chapterinbook_comment.to_sym).id, @chapterinbook_comment.id
      assert_equal chapterinbook_comments(chapterinbook_comment.to_sym).chapterinbook_id, @chapterinbook_comment.chapterinbook_id
      assert_equal chapterinbook_comments(chapterinbook_comment.to_sym).user_id, @chapterinbook_comment.user_id
    }
  end

  def test_deleting_chapterinbook_comments
    @chapterinbook_comments.each { |chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      @chapterinbook_comment.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @chapterinbook_comment = ChapterinbookComment.new
    assert !@chapterinbook_comment.save
  end

  def test_creating_duplicated_chapterinbook_comment
    @chapterinbook_comment = ChapterinbookComment.new({:user_id => 2, :chapterinbook_id => 2})
    assert !@chapterinbook_comment.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mychapterinbook_comment.id = 1.6
    assert !@mychapterinbook_comment.valid?
    @mychapterinbook_comment.id = 'mi_id'
    assert !@mychapterinbook_comment.valid?
  end

  def test_bad_values_for_chapterinbook_id
    @mychapterinbook_comment.chapterinbook_id = nil
    assert !@mychapterinbook_comment.valid?

    @mychapterinbook_comment.chapterinbook_id= 1.6
    assert !@mychapterinbook_comment.valid?

    @mychapterinbook_comment.chapterinbook_id = 'mi_id'
    assert !@mychapterinbook_comment.valid?
  end

  def test_bad_values_for_user_id
    @mychapterinbook_comment.user_id = nil
    assert !@mychapterinbook_comment.valid?

    @mychapterinbook_comment.user_id = 3.1416
    assert !@mychapterinbook_comment.valid?
    @mychapterinbook_comment.user_id = 'mi_id'
    assert !@mychapterinbook_comment.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_user_id
    @chapterinbook_comments.each { | chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      assert_kind_of ChapterinbookComment, @chapterinbook_comment
      assert_equal @chapterinbook_comment.user_id, User.find(@chapterinbook_comment.user_id).id
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
    @chapterinbook_comments.each { | chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      assert_kind_of ChapterinbookComment, @chapterinbook_comment
      @chapterinbook_comment.user_id = 1000000
      begin
        return true if @chapterinbook_comment.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_chapterinbook_id
    @chapterinbook_comments.each { | chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)

      assert_kind_of ChapterinbookComment, @chapterinbook_comment
      assert_equal @chapterinbook_comment.chapterinbook_id, Chapterinbook.find(@chapterinbook_comment.chapterinbook_id).id
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
    @chapterinbook_comments.each { | chapterinbook_comment|
      @chapterinbook_comment = ChapterinbookComment.find(chapterinbook_comments(chapterinbook_comment.to_sym).id)
      assert_kind_of ChapterinbookComment, @chapterinbook_comment
      @chapterinbook_comment.chapterinbook_id = 100000
      begin
        return true if @chapterinbook_comment.update
      rescue StandardError => x
        return false
      end
    }
  end

end
