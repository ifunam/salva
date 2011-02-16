class UserThesis < ActiveRecord::Base
  validates_presence_of  :roleinthesis_id
  validates_numericality_of :id, :user_id, :thesis_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinthesis_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinthesis
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  def as_text
    [user.fullname_or_email, "(#{roleinthesis.name})"].join(' ')
  end
end

