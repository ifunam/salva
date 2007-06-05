class UserJournal < ModelComposedKeys
  set_table_name "user_journals"
  set_primary_keys :user_id, :journal_id
  validates_presence_of :journal_id, :roleinjournal_id, :startyear
  validates_numericality_of :journal_id, :roleinjournal_id
  validates_uniqueness_of :user_id, :scope => [:journal_id, :roleinjournal_id], :message => 'El rol del usuario esta duplicado' 
  belongs_to :journal
  belongs_to :roleinjournal
end
