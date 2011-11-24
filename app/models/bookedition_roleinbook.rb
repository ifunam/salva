class BookeditionRoleinbook < ActiveRecord::Base
  belongs_to :bookedition
  belongs_to :roleinbook
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  scope :authors, where("roleinbook_id = 1 OR roleinbook_id = 2")
  scope :collaborators, where("roleinbook_id != 1 AND roleinbook_id != 2")

  def as_text
    "#{user.author_name} (#{roleinbook.name})"
  end
end
