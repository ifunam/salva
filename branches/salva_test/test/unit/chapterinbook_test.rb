require File.dirname(__FILE__) + '/../test_helper'
require 'bookedition'
require 'bookchaptertype'
require 'chapterinbook'

class ChapterinbookTest < Test::Unit::TestCase
  fixtures  :countries, :booktypes, :books, :editions, :publishers, :mediatypes, :editionstatuses, :bookeditions, :bookchaptertypes, :chapterinbooks

  def setup
    @chapterinbooks = %w(fuerzas_sobre_la_atmosfera_de_Venus fuerzas_sobre_la_superficie_de_la_tierra)
    @mychapterinbook = Chapterinbook.new({:bookedition_id => 1, :bookchaptertype_id => 2, :title => 'Fuerza de Gravedad'})
  end

  # Right - CRUD
  def test_creating_chapterinbooks_from_yaml
    @chapterinbooks.each { | chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)
      assert_kind_of Chapterinbook, @chapterinbook
      assert_equal chapterinbooks(chapterinbook.to_sym).id, @chapterinbook.id
      assert_equal chapterinbooks(chapterinbook.to_sym).bookchaptertype_id, @chapterinbook.bookchaptertype_id
      assert_equal chapterinbooks(chapterinbook.to_sym).bookedition_id, @chapterinbook.bookedition_id
      assert_equal chapterinbooks(chapterinbook.to_sym).title, @chapterinbook.title
    }
  end

  def test_deleting_chapterinbooks
    @chapterinbooks.each { |chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)

      @chapterinbook.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @chapterinbook = Chapterinbook.new
    assert !@chapterinbook.save
  end

  def test_creating_duplicated_chapterinbook
    @chapterinbook = Chapterinbook.new({:bookedition_id => 1, :bookchaptertype_id => 3, :title => 'Fuerzas sobre la Atmosfera de Venus'})
    assert !@chapterinbook.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mychapterinbook.id = 1.6
    assert !@mychapterinbook.valid?
    @mychapterinbook.id = 'mi_id'
    assert !@mychapterinbook.valid?
    @mychapterinbook.id = -1
    assert !@mychapterinbook.valid?
  end

  def test_bad_values_for_bookchaptertype_id
    @mychapterinbook.bookchaptertype_id = nil
    assert !@mychapterinbook.valid?

    @mychapterinbook.bookchaptertype_id= 1.6
    assert !@mychapterinbook.valid?

    @mychapterinbook.bookchaptertype_id = 'mi_id'
    assert !@mychapterinbook.valid?
    @mychapterinbook.bookchaptertype_id= -1
    assert !@mychapterinbook.valid?
  end

  def test_bad_values_for_bookedition_id
    @mychapterinbook.bookedition_id = nil
    assert !@mychapterinbook.valid?

    @mychapterinbook.bookedition_id = 3.1416
    assert !@mychapterinbook.valid?
    @mychapterinbook.bookedition_id = 'mi_id'
    assert !@mychapterinbook.valid?
    @mychapterinbook.bookedition_id = -1
    assert !@mychapterinbook.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_bookedition_id
    @chapterinbooks.each { | chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)
      assert_kind_of Chapterinbook, @chapterinbook
      assert_equal @chapterinbook.bookedition_id, Bookedition.find(@chapterinbook.bookedition_id).id
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
    @chapterinbooks.each { | chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)
      assert_kind_of Chapterinbook, @chapterinbook
      @chapterinbook.bookedition_id = 1000000
      begin
        return true if @chapterinbook.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_bookchaptertype_id
    @chapterinbooks.each { | chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)

      assert_kind_of Chapterinbook, @chapterinbook
      assert_equal @chapterinbook.bookchaptertype_id, Bookchaptertype.find(@chapterinbook.bookchaptertype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_bookchaptertype_id
    @chapterinbooks.each { | chapterinbook|
      @chapterinbook = Chapterinbook.find(chapterinbooks(chapterinbook.to_sym).id)
      assert_kind_of Chapterinbook, @chapterinbook
      @chapterinbook.bookchaptertype_id = 100000
      begin
        return true if @chapterinbook.save
      rescue StandardError => x
        return false
      end
    }
  end

end
