class UserRoleingroup < ModelComposedKeys
  set_table_name "user_roleingroups"
  set_primary_keys :user_id
  belongs_to :user
  belongs_to :roleingroup 
end
