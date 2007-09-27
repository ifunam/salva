class UserJournal < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :journal_id, :roleinjournal_id, :startyear
  validates_numericality_of :journal_id, :roleinjournal_id, :user_id, :only_integer => true
  validates_uniqueness_of :user_id, :scope =>[:journal_id, :roleinjournal_id]
  belongs_to :user
  belongs_to :journal
  belongs_to :roleinjournal
end
