class UserProceeding < ModelComposedKeys
  set_table_name "user_proceedings"

  set_primary_keys :user_id, :proceeding_id
  validates_presence_of :proceeding_id, :roleproceeding_id
  validates_numericality_of :proceeding_id, :roleproceeding_id
  validates_uniqueness_of :user_id, :scope => [:proceeding_id, :roleproceeding_id], :message => 'El rol del usuario esta duplicado'

  belongs_to :proceeding
  belongs_to :roleproceeding
end
