class UserJournal < ActiveRecord::Base
validates_presence_of :journal_id, :roleinjournal_id, :startyear
validates_numericality_of :journal_id, :roleinjournal_id
belongs_to :journal
belongs_to :roleinjournal
end
