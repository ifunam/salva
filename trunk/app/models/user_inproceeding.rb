class UserInproceeding < ModelComposedKeys
  set_table_name "user_inproceedings"
  set_primary_keys :user_id, :inproceeding_id
  validates_presence_of :inproceeding_id, :userrole_id
  validates_numericality_of :inproceeding_id, :userrole_id
  validates_uniqueness_of :user_id, :scope => [:inproceeding_id, :userrole_id], :message => 'El rol del usuario esta duplicado' 
  belongs_to :inproceeding
  belongs_to :userrole
end
