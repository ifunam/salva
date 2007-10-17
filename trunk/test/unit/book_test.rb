require File.dirname(__FILE__) + '/../test_helper'
require 'booktype'
require 'country'
require 'book'


class BookTest < Test::Unit::TestCase
  fixtures :countries, :booktypes, :books

  def setup
    @books = %w(introduccion_a_la_sismologia earthquakes_mexican_studies fundamentals_of_spacephysics)
    @mybook = Book.new({ :title => ' Introduccion a la Sismologia_sas' , :author => 'M. Fujimori', :country_id => 484, :booktype_id => 3 })
  end

  # Right - CRUD
  def test_creating_book_from_yaml
    @books.each { | book|
      @book = Book.find(books(book.to_sym).id)
      assert_kind_of Book, @book
      assert_equal books(book.to_sym).id, @book.id
      assert_equal books(book.to_sym).booktype_id, @book.booktype_id
      assert_equal books(book.to_sym).country_id, @book.country_id
      assert_equal books(book.to_sym).title, @book.title
      assert_equal books(book.to_sym).author, @book.author
    }
  end

  def test_updating_book_id
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      assert_equal books(book.to_sym).id, @book.id
      @book.id = 4
      assert @book.save
      assert_not_equal books(book.to_sym).id, @book.id
    }
  end

    def test_updating_country_id
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      assert_equal books(book.to_sym).country_id, @book.country_id
      @book.country_id = 804
      assert @book.save
      assert_not_equal books(book.to_sym).country_id, @book.country_id
    }
  end

   def test_updating_title
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      assert_equal books(book.to_sym).title, @book.title
      @book.title = 10
      assert @book.save
      assert_not_equal books(book.to_sym).title, @book.title
    }
  end

   def test_updating_booktype_id
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      assert_equal books(book.to_sym).booktype_id, @book.booktype_id
      @book.booktype_id = 1
       assert @book.save
      assert_not_equal books(book.to_sym).booktype_id, @book.booktype_id
    }
  end

      def test_updating_author
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      assert_equal books(book.to_sym).author, @book.author
      @book.author = 3
      assert @book.save
      assert_not_equal books(book.to_sym).author, @book.author
    }
  end

  def test_deleting_books
    @books.each { |book|
      @book = Book.find(books(book.to_sym).id)
      @book.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Book.find(books(book.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @book = Book.new
    assert !@book.save
  end

   # def test_creating_duplicated
#      @book = Book.new({ :title => 'Introduccion a la Sismologia' , :author => 'M. Fujimori', :country_id => 392, :booktype_id => 3 })
#     assert !@book.save
#    end

   # Boundary
    def test_bad_values_for_id
     @mybook.id = 1.6
    assert !@mybook.valid?
    @mybook.id = 'mi_id'
    assert !@mybook.valid?
  end

  def test_bad_values_for_bootype_id
    @mybook.booktype_id= 1.6
    assert !@mybook.valid?
    @mybook.booktype_id = 'mi_id_texto'
    assert !@mybook.valid?
  end

    def test_bad_values_for_country_id
    @mybook.country_id = nil
    assert !@mybook.valid?
    @mybook.country_id = 1.6
    assert !@mybook.valid?
    @mybook.country_id = 'my_year'
    assert !@mybook.valid?
  end

  #cross-Checking test for book
  def test_cross_checking_for_book_id
    @books.each { | book|
      @book = Book.find(books(book.to_sym).id)
      assert_kind_of Book, @book
      assert_equal @book.booktype_id, Booktype.find(@book.booktype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_booktype_id
    @books.each { | book|
      @book = Book.find(books(book.to_sym).id)
      assert_kind_of Book, @book
      @book.booktype_id = 5
          begin
        return true if @book.save
           rescue StandardError => x
        return false
      end
    }
  end

  #cross check for edition
  def test_cross_checking_for_country_id
    @books.each { | book|
      @book = Book.find(books(book.to_sym).id)
      assert_kind_of Book, @book
      assert_equal @book.country_id, Country.find(@book.country_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_country_id
    @books.each { | book|
      @book = Book.find(books(book.to_sym).id)
      assert_kind_of Book, @book
      @book.country_id = 10
       begin
        return true if @book.save
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

end
