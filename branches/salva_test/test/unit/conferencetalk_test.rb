require File.dirname(__FILE__) + '/../test_helper'
require 'talktype'
require 'conference'
require 'talkacceptance'
require 'modality'


class ConferenceTest < Test::Unit::TestCase
  fixtures :talkacceptances, :modalities, :talktypes, :conferencetypes, :conferencescopes, :countries,  :states, :conferences, :conferencetalks

  def setup
    @conferencetalks = %w(prueba001  prueba002  )
    @myconferencetalk = Conferencetalk.new({:title => ' Estudios sobre formacion de barrancos en Martess', :authors => 'Imelda Martinez, Gerardo Hessman  conference_id: 1', :conference_id => 1 , :talktype_id => 2, :talkacceptance_id => 1, :modality_id => 1})
  end

  # Right - CRUD
  def test_creating_conferencetalks_from_yaml
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal conferencetalks(conferencetalk.to_sym).id, @conferencetalk.id
      assert_equal conferencetalks(conferencetalk.to_sym).title, @conferencetalk.title
      assert_equal conferencetalks(conferencetalk.to_sym).talktype_id, @conferencetalk.talktype_id
      assert_equal conferencetalks(conferencetalk.to_sym).conference_id, @conferencetalk.conference_id
      assert_equal conferencetalks(conferencetalk.to_sym).modality_id, @conferencetalk.modality_id

    }
  end

  def test_updating_conferencetalks_title
    @conferencetalks.each { |conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_equal conferencetalks(conferencetalk.to_sym).title, @conferencetalk.title
      @conferencetalk.title = @conferencetalk.title.chars.reverse
      assert @conferencetalk.update
      assert_not_equal conferencetalks(conferencetalk.to_sym).title, @conferencetalk.title
    }
  end



  def test_deleting_conferencetalks
    @conferencetalks.each { |conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      @conferencetalk.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      }
    }
  end

   def test_creating_with_empty_attributes
     @conferencetalk = Conferencetalk.new
     assert !@conferencetalk.save
   end

   def test_creating_duplicated_conferencetalk
     @conferencetalk = Conferencetalk.new({:id => 1, :title => ' Estudios sobre formacion de barrancos en Martess', :authors => 'Imelda Martinez, Gerardo Hessman ', :conference_id => 1 , :talktype_id => 2, :talkacceptance_id => 1, :modality_id => 1 })
     assert !@conferencetalk.save
   end

     # Boundary
   def test_bad_values_for_id
     # Float number for ID
     @myconferencetalk.id = 1.6
     assert !@myconferencetalk.valid?

    # Negative numbers
     @myconferencetalk.id = -1
     assert !@myconferencetalk.valid?
   end

   def test_bad_values_for_title
     @myconferencetalk.title = nil
     assert !@myconferencetalk.valid?

     @myconferencetalk.title = 'AB'
     assert !@myconferencetalk.valid?

     @myconferencetalk.title = 'AB' * 800
     assert !@myconferencetalk.valid?
   end

   def test_bad_values_for_talktype_id

     @myconferencetalk.talktype_id = nil
     assert !@myconferencetalk.valid?

     # Float number for ID
     @myconferencetalk.talktype_id = 3.1416
     assert !@myconferencetalk.valid?

    # Negative numbers
     @myconferencetalk.talktype_id = -1
     assert !@myconferencetalk.valid?
   end

   def test_bad_values_for_talkacceptance_id
     @myconferencetalk.talkacceptance_id = nil
     assert !@myconferencetalk.valid?

     # Float number for ID
     @myconferencetalk.talkacceptance_id = 3.1416
     assert !@myconferencetalk.valid?

     # Negative numbers
     @myconferencetalk.talkacceptance_id = -1
     assert !@myconferencetalk.valid?
   end

   def test_bad_values_for_conference_id

     @myconferencetalk.conference_id = nil
     assert !@myconferencetalk.valid?

     # Float number for ID
     @myconferencetalk.conference_id = 3.1416
     assert !@myconferencetalk.valid?
   end

  def test_bad_values_for_modality_id
     @myconferencetalk.modality_id = nil
     assert !@myconferencetalk.valid?

     # Float number for ID
     @myconferencetalk.modality_id = 3.1416
     assert !@myconferencetalk.valid?

     # Negative numbers
     @myconferencetalk.modality_id = -1
     assert !@myconferencetalk.valid?
   end

  #Cross-Checking test
 def test_cross_checking_for_conferencetalktype_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.talktype_id, Talktype.find(@conferencetalk.talktype_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetalktype_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.talktype_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

  #Cross-Checking test
 def test_cross_checking_for_conferencetalktype_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.talktype_id, Talktype.find(@conferencetalk.talktype_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetalktype_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.talktype_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end
    #Cross-Checking test
 def test_cross_checking_for_conferencetalktype_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.talktype_id, Talktype.find(@conferencetalk.talktype_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetalktype_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.talktype_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end
#Cross-Checking test
 def test_cross_checking_for_conferencetalktype_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.talktype_id, Talktype.find(@conferencetalk.talktype_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetalktype_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.talktype_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_conferencetalkconference_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.conference_id, Conference.find(@conferencetalk.conference_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetalktype_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.conference_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

   def test_cross_checking_for_conferencetalkacceptance_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.talkacceptance_id, Talkacceptance.find(@conferencetalk.talkacceptance_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencetacceptance_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.talkacceptance_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end
   def test_cross_checking_for_conferencemodality_id
   @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      assert_equal @conferencetalk.modality_id, Modality.find(@conferencetalk.modality_id).id
    }
 end
 def catch_exception_when_update_invalid_key(record)
   begin
     return true if record.update
   rescue ActiveRecord::StatementInvalid => bang
     return false
   end
 end

  def test_cross_checking_with_bad_values_for_conferencemodality_id
    @conferencetalks.each { | conferencetalk|
      @conferencetalk = Conferencetalk.find(conferencetalks(conferencetalk.to_sym).id)
      assert_kind_of Conferencetalk, @conferencetalk
      @conferencetalk.modality_id = 50
      begin
        return true if @conferencetalk.update
      rescue StandardError => x
        return false
      end
    }
  end

end
