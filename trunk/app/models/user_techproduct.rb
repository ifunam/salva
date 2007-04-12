class UserTechproduct <  ModelComposedKeys
  set_table_name "user_techproducts"
  set_primary_keys :user_id, :techproduct_id
  validates_presence_of :techproduct_id
  validates_numericality_of :techproduct_id, :userrole_id
  belongs_to :techproduct
  belongs_to :userrole
end
