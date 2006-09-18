class Permission < ModelComposedKeys
  set_table_name "permissions"
  set_primary_keys :roleingroup_id, :controller_id

  validates_numericality_of :roleingroup_id, :controller_id
  belongs_to  :roleingroup
  belongs_to :controller
end
