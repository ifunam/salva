class DepartmentHead < ActiveRecord::Base
  # attr_accessor :user_id, :adscription_id
  belongs_to :user
  belongs_to :adscription

  scope :one, lambda {|user| user.admin? ? all : where("user_id=?",user.id) }

end
