# has_and_belongs_to_many es posible resolverlo mejor con hasmany through
class UserTechproduct <  ModelComposedKeys
  set_table_name "user_techproducts"
  set_primary_keys :user_id, :techproduct_id
  validates_presence_of :techproduct_id
  validates_numericality_of :techproduct_id, :userrole_id, :year
  belongs_to :techproduct
  belongs_to :userrole
end
