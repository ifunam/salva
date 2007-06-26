class BookeditionRoleinbook < ModelComposedKeys
  set_table_name "bookedition_roleinbooks"
  set_primary_keys :user_id, :bookedition_id
  validates_presence_of :bookedition_id
  validates_presence_of :roleinbook_id
  validates_presence_of :user_id

  belongs_to :bookedition
  #belongs_to :roleinbook
  #belongs_to :user

  attr_accessor :book_id
end
