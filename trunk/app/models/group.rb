class Group < ActiveRecord::Base
  acts_as_tree :foreign_key => "group_id"

  validates_presence_of :name
  validates_numericality_of :group_id
  belongs_to :group
  validates_uniqueness_of :name
end
