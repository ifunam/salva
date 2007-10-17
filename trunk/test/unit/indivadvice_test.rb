require File.dirname(__FILE__) + '/../test_helper'
require 'indivadvicetarget'
require 'indivadvice'
require 'user'

class IndivadviceTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :indivadvicetargets, :indivadvices

    def setup
    @indivadvices = %w(prueba001 prueba002)
    @myindivadvice = Indivadvice.new({:user_id => 2, :indivadvicetarget_id => 3, :startyear => 2007 , :hours => 120, :indivname => 'miguel'})
  end


  # Right - CRUD
  def test_creating_indivadvices_from_yaml
    @indivadvices.each { | indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_kind_of Indivadvice, @indivadvice
      assert_equal indivadvices(indivadvice.to_sym).id, @indivadvice.id
      assert_equal indivadvices(indivadvice.to_sym).user_id, @indivadvice.user_id
      assert_equal indivadvices(indivadvice.to_sym).indivadvicetarget_id, @indivadvice.indivadvicetarget_id
      assert_equal indivadvices(indivadvice.to_sym).startyear, @indivadvice.startyear
    }
  end

  def test_updating_indivadvices_name
    @indivadvices.each { |indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_equal indivadvices(indivadvice.to_sym).indivname, @indivadvice.indivname
      @indivadvice.indivname = @indivadvice.indivname.chars.reverse
      assert @indivadvice.save
      assert_not_equal indivadvices(indivadvice.to_sym).indivname, @indivadvice.indivname
    }
  end



  def test_deleting_indivadvices
    @indivadvices.each { |indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      @indivadvice.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      }
    }
  end

   def test_creating_with_empty_attributes
     @indivadvice = Indivadvice.new
     assert !@indivadvice.save
   end

   def test_creating_duplicated_indivadvice
     @indivadvice = Indivadvice.new({:user_id => 2, :indivadvicetarget_id => 3, :startyear => 2007, :hours => 120, :indivname => 'miguel' })
     @indivadvice.id = 1
     assert !@indivadvice.save
   end

     # Boundary
   def test_bad_values_for_id
     # Float number for ID
     @myindivadvice.id = 1.6
     assert !@myindivadvice.valid?

    # Negative numbers
     @myindivadvice.id = -1
     assert !@myindivadvice.valid?
   end

   def test_bad_values_for_user
     @myindivadvice.user_id = nil
     assert !@myindivadvice.valid?

     @myindivadvice.user_id = 1.6
     assert !@myindivadvice.valid?

     @myindivadvice.user_id = -1
     assert !@myindivadvice.valid?
   end

   def test_bad_values_for_indivadvicetarget_id
     # Checking constraints for name
     # Nil name
     @myindivadvice.indivadvicetarget_id = nil
     assert !@myindivadvice.valid?

     # Float number for ID
     @myindivadvice.indivadvicetarget_id = 3.1416
     assert !@myindivadvice.valid?

    # Negative numbers
     @myindivadvice.indivadvicetarget_id = -1
     assert !@myindivadvice.valid?
   end

   def test_bad_values_for_startyear
     # Checking constraints for name
     # Nil name
     @myindivadvice.startyear = nil
     assert !@myindivadvice.valid?

     # Float number for ID
     @myindivadvice.startyear = 3.1416
     assert !@myindivadvice.valid?

    # Negative numbers
     @myindivadvice.startyear = -1
     assert !@myindivadvice.valid?
   end

   def test_bad_values_for_hours
     # Checking constraints for name
     # Nil name
     @myindivadvice.hours = nil
     assert !@myindivadvice.valid?

     # Float number for ID
     @myindivadvice.hours = 3.1416
     assert !@myindivadvice.valid?

    # Negative numbers
     @myindivadvice.hours = -1
     assert !@myindivadvice.valid?
   end
def test_bad_values_for_indivname
     @myindivadvice.indivname = nil
     assert !@myindivadvice.valid?

     @myindivadvice.indivname = 'AB'
       assert !@myindivadvice.valid?

     @myindivadvice.indivname = 'AB' * 800
      assert !@myindivadvice.valid?
   end

   #Cross-Checking test

 def test_cross_checking_for_indivadvicetarget
   @indivadvices.each { | indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_kind_of Indivadvice, @indivadvice
      assert_equal @indivadvice.indivadvicetarget_id, Indivadvicetarget.find(@indivadvice.indivadvicetarget_id).id

  }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.save
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_indivadvicetype_id
    @indivadvices.each { | indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_kind_of Indivadvice, @indivadvice
      @indivadvice.indivadvicetarget_id = 50
      begin
        return true if @indivadvice.save
      rescue StandardError => x
        return false
      end
    }
  end


 def test_cross_checking_for_user_id
   @indivadvices.each { | indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_kind_of Indivadvice, @indivadvice
      assert_equal @indivadvice.user_id, User.find(@indivadvice.user_id).id
    }
 end

 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.save
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_indivadvicecountry_id
    @indivadvices.each { | indivadvice|
      @indivadvice = Indivadvice.find(indivadvices(indivadvice.to_sym).id)
      assert_kind_of Indivadvice, @indivadvice
      @indivadvice.user_id = 50
      begin
        return true if @indivadvice.save
      rescue StandardError => x
        return false
      end
    }
  end

end



