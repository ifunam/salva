class UserJournal < ActiveRecord::Base
  validates_presence_of :user_id, :journal_id, :roleinjournal_id, :startyear
  validates_numericality_of :journal_id, :roleinjournal_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :journal_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleinjournal_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:journal_id, :roleinjournal_id]

  belongs_to :user
  belongs_to :journal
  belongs_to :roleinjournal
end
