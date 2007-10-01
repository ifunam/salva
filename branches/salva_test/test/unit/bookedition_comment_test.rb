require File.dirname(__FILE__) + '/../test_helper'
require 'user'
require 'bookedition'
require 'bookedition_comment'

class BookeditionCommentTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions , :userstatuses, :users, :countries, :booktypes, :books, :editions, :mediatypes, :editionstatuses, :bookeditions, :bookedition_comments

  def setup
    @bookedition_comments = %w(administrador_sismologia juana_earthquakes)
    @mybookedition_comment = BookeditionComment.new({:user_id => 1, :bookedition_id => 2})
  end

  # Right - CRUD
  def test_creating_bookedition_comments_from_yaml
    @bookedition_comments.each { | bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      assert_kind_of BookeditionComment, @bookedition_comment
      assert_equal bookedition_comments(bookedition_comment.to_sym).id, @bookedition_comment.id
      assert_equal bookedition_comments(bookedition_comment.to_sym).bookedition_id, @bookedition_comment.bookedition_id
      assert_equal bookedition_comments(bookedition_comment.to_sym).user_id, @bookedition_comment.user_id
    }
  end

  def test_deleting_bookedition_comments
    @bookedition_comments.each { |bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      @bookedition_comment.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @bookedition_comment = BookeditionComment.new
    assert !@bookedition_comment.save
  end

  def test_creating_duplicated_bookedition_comment
    @bookedition_comment = BookeditionComment.new({:user_id => 2, :bookedition_id => 2})
    assert !@bookedition_comment.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mybookedition_comment.id = 1.6
    assert !@mybookedition_comment.valid?
    @mybookedition_comment.id = 'mi_id'
    assert !@mybookedition_comment.valid?
  end

  def test_bad_values_for_bookedition_id
    @mybookedition_comment.bookedition_id = nil
    assert !@mybookedition_comment.valid?

    @mybookedition_comment.bookedition_id= 1.6
    assert !@mybookedition_comment.valid?

    @mybookedition_comment.bookedition_id = 'mi_id'
    assert !@mybookedition_comment.valid?
  end

  def test_bad_values_for_user_id
    @mybookedition_comment.user_id = nil
    assert !@mybookedition_comment.valid?

    @mybookedition_comment.user_id = 3.1416
    assert !@mybookedition_comment.valid?
    @mybookedition_comment.user_id = 'mi_id'
    assert !@mybookedition_comment.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_user_id
    @bookedition_comments.each { | bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      assert_kind_of BookeditionComment, @bookedition_comment
      assert_equal @bookedition_comment.user_id, User.find(@bookedition_comment.user_id).id
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
    @bookedition_comments.each { | bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      assert_kind_of BookeditionComment, @bookedition_comment
      @bookedition_comment.user_id = 1000000
      begin
        return true if @bookedition_comment.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_bookedition_id
    @bookedition_comments.each { | bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)

      assert_kind_of BookeditionComment, @bookedition_comment
      assert_equal @bookedition_comment.bookedition_id, Bookedition.find(@bookedition_comment.bookedition_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_bookedition_id
    @bookedition_comments.each { | bookedition_comment|
      @bookedition_comment = BookeditionComment.find(bookedition_comments(bookedition_comment.to_sym).id)
      assert_kind_of BookeditionComment, @bookedition_comment
      @bookedition_comment.bookedition_id = 100000
      begin
        return true if @bookedition_comment.save
      rescue StandardError => x
        return false
      end
    }
  end

end
