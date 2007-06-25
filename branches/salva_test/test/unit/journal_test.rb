require File.dirname(__FILE__) + '/../test_helper'
require 'country'
require 'mediatype'
require 'publisher'
require 'journal'

class JournalTest < Test::Unit::TestCase
  fixtures :countries, :mediatypes, :publishers, :journals
  def setup
    @journals = %w(quo conozca)
    @myjournal = Journal.new({:name => 'Todo Ciencia', :country_id => 484, :publisher_id => 2, :mediatype_id => 1})
  end

  # Right - CRUD
  def test_creating_journals_from_yaml
    @journals.each { | journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_kind_of Journal, @journal
      assert_equal journals(journal.to_sym).id, @journal.id
      assert_equal journals(journal.to_sym).name, @journal.name
      assert_equal journals(journal.to_sym).mediatype_id, @journal.mediatype_id
      assert_equal journals(journal.to_sym).country_id, @journal.country_id
      assert_equal journals(journal.to_sym).publisher_id, @journal.publisher_id
    }
  end

  def test_updating_journals_name
      @journals.each { |journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_equal journals(journal.to_sym).name, @journal.name
      @journal.name = @journal.name.chars.reverse
      assert @journal.update
      assert_not_equal journals(journal.to_sym).name, @journal.name
    }
  end

  def test_deleting_journals
      @journals.each { |journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      @journal.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Journal.find(journals(journal.to_sym).id)
      }
    }
  end

   def test_creating_with_empty_attributes
     @journal = Journal.new
     assert !@journal.save
   end

   def test_creating_duplicated_journal
     @journal = Journal.new({:name => 'QUO', :mediatype_id => 2, :issn => nil, :country_id => 484})
     assert !@journal.save
   end

     # Boundary
   def test_bad_values_for_id
      @myjournal.id ='x'
     assert !@myjournal.valid

     # Float number for ID
     @myjournal.id = 1.6
     assert !@myjournal.valid?
   end

   def test_bad_values_for_name
     @myjournal.name = nil
     assert !@myjournal.valid?
   end

   def test_bad_values_for_mediatype_id
     # Checking constraints for name
     # Nil name
     @myjournal.mediatype_id = nil
     assert !@myjournal.valid?

     @myjournal.mediatype_id = 3.1416
     assert !@myjournal.valid?
   end

   #Cross-Checking test
   def test_cross_checking_for_mediatype_id
      @journals.each { | journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_kind_of Journal, @journal
      assert_equal @journal.mediatype_id, Mediatype.find(@journal.mediatype_id).id
      }
   end

   def catch_exception_when_update_invalid_key(record)
    begin
       return true if record.update
     rescue ActiveRecord::StatementInvalid => bang
       return false
     end
   end

   def test_cross_checking_with_bad_values_for_mediatype_id
    @journals.each { | journal|
     @journal = Journal.find(journals(journal.to_sym).id)
     assert_kind_of Journal, @journal
     @journal.mediatype_id = 10
     begin
            return true if @journal.update
     rescue StandardError => x
            return false
     end
     }
    end
    def test_cross_checking_for_country_id
      @journals.each { | journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_kind_of Journal, @journal
      assert_equal @journal.country_id, Country.find(@journal.country_id).id
     }
    end

   def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
   end

    def test_cross_checking_with_bad_values_for_country_id
     @journals.each { | journal|
     @journal = Journal.find(journals(journal.to_sym).id)
     assert_kind_of Journal, @journal
     @journal.country_id = 1000
     begin
            return true if @journal.update
     rescue StandardError => x
            return false
     end
     }
    end

    def test_bad_values_for_country_id
     # Checking constraints for name
     # Nil name
     @myjournal.country_id = nil
     assert !@myjournal.valid?

     @myjournal.country_id = 3.1416
     assert !@myjournal.valid?
    end

    def test_bad_values_for_publisher_id
     @myjournal.publisher_id = 3.1416
     assert !@myjournal.valid?
    end

    #Cross-Checking test
    def test_cross_checking_for_publisher_id
     @journals.each { | journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_kind_of Journal, @journal
      assert_equal @journal.publisher_id, Publisher.find(@journal.publisher_id).id
      }
    end

   def catch_exception_when_update_invalid_key(record)
     begin
       return true if record.update
     rescue ActiveRecord::StatementInvalid => bang
       return false
     end
   end

  def test_cross_checking_with_bad_values_for_publisher_id
     @journals.each { | journal|
      @journal = Journal.find(journals(journal.to_sym).id)
      assert_kind_of Journal, @journal
      @journal.publisher_id = 10
      begin
            return true if @journal.update
      rescue StandardError => x
            return false
      end
      }
  end
end
