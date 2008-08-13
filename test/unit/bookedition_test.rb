require File.dirname(__FILE__) + '/../test_helper'
require 'mediatype'
require 'editionstatus'
require 'edition'
require 'book'
require 'bookedition'

class BookeditionTest < Test::Unit::TestCase
  fixtures :countries, :booktypes, :books, :mediatypes, :editionstatuses, :bookeditions

  def setup
    @bookeditions = %w(sismologia earthquakes spacephysics)
    @mybookedition = Bookedition.new({:book_id => 4, :edition => 'Third edition', :pages => 300,  :editionstatus_id => 2, :mediatype_id => 1, :month => 3, :year => 2005})
  end

  # Right - CRUD
  def test_creating_bookedition_from_yaml
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      assert_equal bookeditions(bookedition.to_sym).id, @bookedition.id
      assert_equal bookeditions(bookedition.to_sym).book_id, @bookedition.book_id
      assert_equal bookeditions(bookedition.to_sym).edition, @bookedition.edition
      assert_equal bookeditions(bookedition.to_sym).pages, @bookedition.pages
      assert_equal bookeditions(bookedition.to_sym).mediatype_id, @bookedition.mediatype_id
      assert_equal bookeditions(bookedition.to_sym).editionstatus_id, @bookedition.editionstatus_id
      assert_equal bookeditions(bookedition.to_sym).month, @bookedition.month
      assert_equal bookeditions(bookedition.to_sym).year, @bookedition.year
    }
  end

  def test_updating_book_id
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).book_id, @bookedition.book_id
      @bookedition.book_id = 4
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).book_id, @bookedition.book_id
    }
  end

    def test_updating_edition
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).edition, @bookedition.edition
      @bookedition.edition = 'Cuarta'
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).edition, @bookedition.edition
    }
  end

   def test_updating_pages
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).pages, @bookedition.pages
      @bookedition.pages = 10
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).pages, @bookedition.pages
    }
  end

  def test_updating_mediatype_id
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).mediatype_id, @bookedition.mediatype_id
      @bookedition.mediatype_id = 3
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).mediatype_id, @bookedition.mediatype_id
    }
  end

  def test_updating_editionstatus_id
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).editionstatus_id, @bookedition.editionstatus_id
      @bookedition.editionstatus_id = 3
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).editionstatus_id, @bookedition.editionstatus_id
    }
  end

  def test_updating_year
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_equal bookeditions(bookedition.to_sym).year, @bookedition.year
      @bookedition.year = @bookedition.year - 2
      assert @bookedition.save
      assert_not_equal bookeditions(bookedition.to_sym).year, @bookedition.year
    }
  end

    def test_updating_month
    @bookeditions.each { |bookedition|
    @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
    assert_equal bookeditions(bookedition.to_sym).month, @bookedition.month
        if !@bookedition.month.nil?
           @bookedition.month == 12 ? @bookedition.month = @bookedition.month - 2 : @bookedition.month = @bookedition.month + 1
          else
          @bookedition.month = 3
          end
    assert @bookedition.save
    assert_not_equal bookeditions(bookedition.to_sym).month, @bookedition.month
    }
  end

  def test_deleting_bookeditions
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      @bookedition.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Bookedition.find(bookeditions(bookedition.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @bookedition = Bookedition.new
    assert !@bookedition.save
  end

   def test_creating_duplicated
     @bookedition = Bookedition.new({:book_id => 1, :edition => 'Tercera', :pages => 300, :editionstatus_id => 1, :mediatype_id => 1, :month => 3, :year => 200})
     assert !@bookedition.save
   end

   # Boundary
    def test_bad_values_for_id
     @mybookedition.id = 1.6
    assert !@mybookedition.valid?
    @mybookedition.id = 'mi_id'
    assert !@mybookedition.valid?
  end

  def test_bad_values_for_book_id
    @mybookedition.book_id= 1.6
    assert !@mybookedition.valid?
    @mybookedition.book_id = 'mi_id_texto'
    assert !@mybookedition.valid?
  end

  def test_bad_values_for_edition
    @mybookedition.edition = nil
    assert !@mybookedition.valid?
  end

    def test_bad_values_for_mediatype_id
    @mybookedition.mediatype_id = nil
    assert !@mybookedition.valid?
    @mybookedition.mediatype_id = 1.6
    assert !@mybookedition.valid?
    @mybookedition.mediatype_id = 'my_year'
    assert !@mybookedition.valid?
  end

   def test_bad_values_for_editionstatus_id
    @mybookedition.editionstatus_id = 1.6
    assert !@mybookedition.valid?
    @mybookedition.editionstatus_id = 'my_year'
    assert !@mybookedition.valid?
  end

  #cross-Checking test for book
  def test_cross_checking_for_book_id
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      assert_equal @bookedition.book_id, Book.find(@bookedition.book_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_book_id
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      @bookedition.book_id = 5
          begin
        return true if @bookedition.save
           rescue StandardError => x
        return false
      end
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  #cross check for edition
  def test_cross_checking_for_mediatype_id
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      assert_equal @bookedition.mediatype_id, Mediatype.find(@bookedition.mediatype_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_mediatype_id
    @bookeditions.each { |bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      @bookedition.mediatype_id = 100
      begin
        return true if @bookedition.save
       rescue StandardError => x
        return false
      end
    }
  end

    #cross check for editionstatus
  def test_cross_checking_for_editionstatus_id
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      assert_equal @bookedition.editionstatus_id, Editionstatus.find(@bookedition.editionstatus_id).id
    }
  end

  def test_cross_checking_with_bad_values_for_editstatus_id
    @bookeditions.each { | bookedition|
      @bookedition = Bookedition.find(bookeditions(bookedition.to_sym).id)
      assert_kind_of Bookedition, @bookedition
      @bookedition.editionstatus_id = 1
       begin
        return true if @bookedition.save
       rescue StandardError => x
        return false
      end
    }
  end
end
