class UserLabOrGroup < ActiveRecord::Base
  # attr_accessor :user_id, :lab_or_group_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :lab_or_group_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => false
  validates_uniqueness_of :user_id, :scope => [:lab_or_group_id]

  belongs_to :user
  belongs_to :lab_or_group
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  scope :lab_or_group_id_eq, lambda { |lab_or_group_id| select('*').where :lab_or_group_id => lab_or_group_id }

  # search_methods :user_id, :lab_or_group_id_eq

  def to_s
    lab_or_group.to_s
  end
end
