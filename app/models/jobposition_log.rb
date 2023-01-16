class JobpositionLog < ActiveRecord::Base
  # attr_accessor :worker_key, :worker_number, :academic_years, :administrative_years

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_presence_of :worker_key
  #validates_presence_of :academic_years, :if => lambda { |record| record.administrative_years.nil? }
  #validates_presence_of :administrative_years, :if => lambda { |record| record.academic_years.nil? }
  validates_numericality_of :academic_years, :administrative_years, :allow_nil => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 90, :only_integer => true
  validates_uniqueness_of :user_id, :worker_key

  belongs_to :user
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
end
