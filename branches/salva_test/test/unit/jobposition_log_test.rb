require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'user'
require 'jobposition'

class JobpositionLogTest < Test::Unit::TestCase
  fixtures :userstatuses, :users, :jobposition_logs

  def setup
    @jobposition_logs_keys = %w(juana panchito)
    @myjobposition_log = JobpositionLog.new({:user_id => 1, :worker_key => 6788345290, :academic_years => 20, :administrative_years => 10})
  end

  # Right - CRUD
  def test_creating_jobposition_logs_from_yaml
    @jobposition_logs_keys.each { | key |
      @jobposition_log = JobpositionLog.find(jobposition_logs(key.to_sym).id)
      assert_kind_of JobpositionLog, @jobposition_log
      assert_equal jobposition_logs(key.to_sym).id, @jobposition_log.id
      assert_equal jobposition_logs(key.to_sym).user_id, @jobposition_log.user_id
      assert_equal jobposition_logs(key.to_sym).worker_key, @jobposition_log.worker_key
      assert_equal jobposition_logs(key.to_sym).academic_years, @jobposition_log.academic_years
      assert_equal jobposition_logs(key.to_sym).administrative_years, @jobposition_log.administrative_years
    }
  end

  def test_upgrading_worker_key
    @jobposition_logs_keys.each { |key|
      @jobposition_log = JobpositionLog.find(jobposition_logs(key.to_sym).id)
      assert_equal jobposition_logs(key.to_sym).worker_key, @jobposition_log.worker_key
      @jobposition_log.worker_key = @jobposition_log.worker_key.chars.reverse
      @jobposition_log.save
      assert_not_equal jobposition_logs(key.to_sym).worker_key, @jobposition_log.worker_key
    }
  end

  def test_deleting_jobposition_logs
    @jobposition_logs_keys.each { |key|
      @jobposition_log = JobpositionLog.find(jobposition_logs(key.to_sym).id)
      @jobposition_log.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        JobpositionLog.find(jobposition_logs(key.to_sym).id)
      }
    }
  end

  def test_uniqueness
     @myjobposition_log = JobpositionLog.new({:user_id => 1, :worker_key => 6788345290, :academic_years => 20, :administrative_years => 10})
     assert @myjobposition_log.save
     @myjobposition_dup = JobpositionLog.new({:user_id => 1, :worker_key => 6788345290, :academic_years => 20, :administrative_years => 10})
     assert !@myjobposition_dup.save
   end

  def test_creating_with_empty_attributes
     @myjobposition_log = JobpositionLog.new
     assert !@myjobposition_log.save
   end

   def test_creating_with_missing_attributes
     @myjobposition_log = JobpositionLog.new({ :user_id => 1 })
     assert !@myjobposition_log.save

     @myjobposition_log = JobpositionLog.new({ :user_id => 1, :worker_key => 11212991981 })
     assert !@myjobposition_log.save

     @myjobposition_log = JobpositionLog.new({ :worker_key => 11212991981, :academic_years => 10 })
     assert !@myjobposition_log.save
   end

   def test_bad_values_for_id
     # Float number for ID
     @myjobposition_log.id = 1.6
     assert !@myjobposition_log.valid?

     @myjobposition_log.id = 'xx'
     assert !@myjobposition_log.valid?

     @myjobposition_log.id = -1
     assert !@myjobposition_log.valid?
   end

   def test_bad_values_for_worker_key
     @myjobposition_log.worker_key = nil
     assert !@myjobposition_log.valid?
   end

   def test_bad_values_for_academic_years
     # Float number for ID
     @myjobposition_log.academic_years = 1.6
     assert !@myjobposition_log.valid?

     @myjobposition_log.academic_years = 'xx'
     assert !@myjobposition_log.valid?

     @myjobposition_log.academic_years = -1
     assert !@myjobposition_log.valid?

     @myjobposition_log.academic_years = 0
     assert !@myjobposition_log.valid?

     @myjobposition_log.academic_years = 91
     assert !@myjobposition_log.valid?
   end

   def test_bad_values_for_administrative_years
     # Float number for ID
     @myjobposition_log.administrative_years = 1.6
     assert !@myjobposition_log.valid?

     @myjobposition_log.administrative_years = 'xx'
     assert !@myjobposition_log.valid?

     @myjobposition_log.administrative_years = -1
     assert !@myjobposition_log.valid?

     @myjobposition_log.administrative_years = 0
     assert !@myjobposition_log.valid?

     @myjobposition_log.administrative_years = 91
     assert !@myjobposition_log.valid?
   end
end
