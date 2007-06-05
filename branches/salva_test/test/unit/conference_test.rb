require File.dirname(__FILE__) + '/../test_helper'
require 'conferencetype'
require 'conference'

class ConferenceTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :countries, :conferencetypes, :conferencescopes, :conferences

  def setup
    @conferences = %w(congreso coloquio)
    @myconference = Conference.new({:name => 'Encuentro', :conferencetype_id => 3})
  end
  
  # Right - CRUD
  def test_creating_conferences_from_yaml
    @conferences.each { | conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      assert_kind_of Conference, @conference
      assert_equal conferences(conference.to_sym).id, @conference.id
      assert_equal conferences(conference.to_sym).name, @conference.name
      assert_equal conferences(conference.to_sym).conferencetype_id, @conference.conferencetype_id
    }
  end
  
  def test_updating_conferences_name
    @conferences.each { |conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      assert_equal conferences(conference.to_sym).name, @conference.name
      @conference.name = @conference.name.chars.reverse 
      assert @conference.update
      assert_not_equal conferences(conference.to_sym).name, @conference.name
    }
  end  

  def test_deleting_conferences
    @conferences.each { |conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      @conference.destroy
      assert_raise (ActiveRecord::RecordNotFound) { 
        Conference.find(conferences(conference.to_sym).id) 
      }
    }
  end 

   def test_creating_with_empty_attributes
     @conference = Conference.new
     assert !@conference.save
   end

   def test_creating_duplicated_conference
     @conference = Conference.new({:name => 'Congreso', :conferencetype_id => 1})
     @conference.id = 1
     assert !@conference.save
   end

     # Boundary 
   def test_bad_values_for_id
     # Float number for ID 
     @myconference.id = 1.6
     assert !@myconference.valid?

    # Negative numbers
     @myconference.id = -1
     assert !@myconference.valid?
   end

   def test_bad_values_for_name
     @myconference.name = nil
     assert !@myconference.valid?

     @myconference.name = 'AB' 
     assert !@myconference.valid?

     @myconference.name = 'AB' * 800
     assert !@myconference.valid?
   end

   def test_bad_values_for_conferencetype_id
     # Checking constraints for name
     # Nil name
     @myconference.conferencetype_id = nil
     assert !@myconference.valid?

     # Float number for ID 
     @myconference.conferencetype_id = 3.1416
     assert !@myconference.valid?

    # Negative numbers
     @myconference.conferencetype_id = -1
     assert !@myconference.valid?
   end
 
  #Cross-Checking test 
 def test_cross_checking_for_conferencetype_id
   @conferences.each { | conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      assert_kind_of Conference, @conference
      assert_equal @conference.conferencetype_id, Conferencetype.find(@conference.conferencetype_id).id 
    }
 end 

 def test_cross_checking_for_country_id
   @conferences.each { | conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      assert_kind_of Conference, @conference
      assert_equal @conference.country_id, Country.find(@conference.country_id).id 
    }
 end 

 def test_cross_checking_for_country_id
   @conferences.each { | conference|
      @conference = Conference.find(conferences(conference.to_sym).id)
      assert_kind_of Conference, @conference
      assert_equal @conference.conferencescope_id, Conferencescope.find(@conference.conferencescope_id).id 
    }
 end 


end

