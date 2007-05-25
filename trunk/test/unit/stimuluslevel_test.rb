require File.dirname(__FILE__) + '/../test_helper'
require 'stimuluslevel'
require 'stimulustype'

class StimuluslevelTest < Test::Unit::TestCase
  fixtures :stimulustypes, :stimuluslevels

  def setup
    @stimuluslevels = %w(a b c)
    @mystimuluslevel = Stimuluslevel.new({:name => 'd', :stimulustype_id => 4})
  end
  
  # Right - CRUD
  def test_creating_stimuluslevels_from_yaml
    @stimuluslevels.each { | stimuluslevel|
      @stimuluslevel = Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id)
      assert_kind_of Stimuluslevel, @stimuluslevel
      assert_equal stimuluslevels(stimuluslevel.to_sym).id, @stimuluslevel.id
      assert_equal stimuluslevels(stimuluslevel.to_sym).name, @stimuluslevel.name
      assert_equal stimuluslevels(stimuluslevel.to_sym).stimulustype_id, @stimuluslevel.stimulustype_id
    }
  end
  
  def test_updating_stimuluslevels_name
    @stimuluslevels.each { |stimuluslevel|
      @stimuluslevel = Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id)
      assert_equal stimuluslevels(stimuluslevel.to_sym).name, @stimuluslevel.name
      @stimuluslevel.name = @stimuluslevel.name.chars.reverse * 2 
      assert @stimuluslevel.update
      assert_not_equal stimuluslevels(stimuluslevel.to_sym).name, @stimuluslevel.name
    }
  end  

  def test_deleting_stimuluslevels
    @stimuluslevels.each { |stimuluslevel|
      @stimuluslevel = Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id)
      @stimuluslevel.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @stimuluslevel = Stimuluslevel.new
     assert !@stimuluslevel.save
   end

   def test_creating_duplicated_stimuluslevel
     @stimuluslevel = Stimuluslevel.new({:name => 'A', :stimulustype_id => 1 })
     @stimuluslevel.id = 1
     assert !@stimuluslevel.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @mystimuluslevel.id = 1.6
     assert !@mystimuluslevel.valid?
   end

   def test_bad_values_for_name
     @mystimuluslevel.name = nil
     assert !@mystimuluslevel.valid?

     @mystimuluslevel.name = 'AB' 
     assert !@mystimuluslevel.valid?

     @mystimuluslevel.name = 'AB' * 800
     assert !@mystimuluslevel.valid?
   end

   def test_bad_values_for_stimuluslevel_id
     # Checking constraints for name
     # Nil name
     @mystimuluslevel.stimulustype_id = nil
     assert !@mystimuluslevel.valid?

     @mystimuluslevel.stimulustype_id = 3.1416
     assert !@mystimuluslevel.valid?
   end
   #Cross-Checking test
 
 def test_cross_checking_for_stimuluslevel_id
   @stimuluslevels.each { | stimuluslevel|
      @stimuluslevel = Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id)
      assert_kind_of Stimuluslevel, @stimuluslevel
      assert_equal @stimuluslevel.stimulustype_id, Stimulustype.find(@stimuluslevel.stimulustype_id).id 
    }
 end 


 def catch_exception_when_update_invalid_key(record)
   begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
end

 def test_cross_checking_with_bad_values_for_stimuluslevel_id
   @stimuluslevels.each { | stimuluslevel|
     @stimuluslevel = Stimuluslevel.find(stimuluslevels(stimuluslevel.to_sym).id)
     assert_kind_of Stimuluslevel, @stimuluslevel
     @stimuluslevel.stimulustype_id =7858
     begin 
            return true if @stimuluslevel.update
     rescue StandardError => x
            return false
     end
   }
 end
end
