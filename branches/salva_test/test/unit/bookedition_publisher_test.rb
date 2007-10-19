require File.dirname(__FILE__) + '/../test_helper'
require 'publisher'
require 'bookedition'
require 'bookedition_publisher'

class BookeditionPublisherTest < Test::Unit::TestCase
 fixtures  :publishers, :countries, :booktypes, :books, :editions, :mediatypes, :editionstatuses, :bookeditions, :bookedition_publishers
  def setup
    @bookedition_publishers = %w(sismologia_balkema earthquakes_adasi)
    @mybookedition_publisher = BookeditionPublisher.new({:publisher_id => 1, :bookedition_id => 3})
  end

  # Right - CRUD
  def test_creating_bookedition_publishers_from_yaml
    @bookedition_publishers.each { | bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      assert_kind_of BookeditionPublisher, @bookedition_publisher
      assert_equal bookedition_publishers(bookedition_publisher.to_sym).id, @bookedition_publisher.id
      assert_equal bookedition_publishers(bookedition_publisher.to_sym).bookedition_id, @bookedition_publisher.bookedition_id
      assert_equal bookedition_publishers(bookedition_publisher.to_sym).publisher_id, @bookedition_publisher.publisher_id
    }
  end

  def test_deleting_bookedition_publishers
    @bookedition_publishers.each { |bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      @bookedition_publisher.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @bookedition_publisher = BookeditionPublisher.new
    assert !@bookedition_publisher.save
  end

  def test_creating_duplicated_bookedition_publisher
    @bookedition_publisher = BookeditionPublisher.new({:publisher_id => 2, :bookedition_id => 1})
    assert !@bookedition_publisher.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mybookedition_publisher.id = 1.6
    assert !@mybookedition_publisher.valid?
    @mybookedition_publisher.id = 'mi_id'
    assert !@mybookedition_publisher.valid?
  end

  def test_bad_values_for_bookedition_id
    @mybookedition_publisher.bookedition_id = nil
    assert !@mybookedition_publisher.valid?

    @mybookedition_publisher.bookedition_id= 1.6
    assert !@mybookedition_publisher.valid?

    @mybookedition_publisher.bookedition_id = 'mi_id'
    assert !@mybookedition_publisher.valid?
  end

  def test_bad_values_for_publisher_id
    @mybookedition_publisher.publisher_id = nil
    assert !@mybookedition_publisher.valid?

    @mybookedition_publisher.publisher_id = 3.1416
    assert !@mybookedition_publisher.valid?
    @mybookedition_publisher.publisher_id = 'mi_id'
    assert !@mybookedition_publisher.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_publisher_id
    @bookedition_publishers.each { | bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      assert_kind_of BookeditionPublisher, @bookedition_publisher
      assert_equal @bookedition_publisher.publisher_id, Publisher.find(@bookedition_publisher.publisher_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_publisher_id
    @bookedition_publishers.each { | bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      assert_kind_of BookeditionPublisher, @bookedition_publisher
      @bookedition_publisher.publisher_id = 1000000
      begin
        return true if @bookedition_publisher.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_bookedition_id
    @bookedition_publishers.each { | bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)

      assert_kind_of BookeditionPublisher, @bookedition_publisher
      assert_equal @bookedition_publisher.bookedition_id, Bookedition.find(@bookedition_publisher.bookedition_id).id
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
    @bookedition_publishers.each { | bookedition_publisher|
      @bookedition_publisher = BookeditionPublisher.find(bookedition_publishers(bookedition_publisher.to_sym).id)
      assert_kind_of BookeditionPublisher, @bookedition_publisher
      @bookedition_publisher.bookedition_id = 100000
      begin
        return true if @bookedition_publisher.save
      rescue StandardError => x
        return false
      end
    }
  end

end
