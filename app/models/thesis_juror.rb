class ThesisJuror < ActiveRecord::Base
  attr_accessible :roleinjury_id, :year, :user_id, :thesis_id
  validates_presence_of :roleinjury_id, :year
  validates_numericality_of :roleinjury_id, :year
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury

  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where(["thesis_jurors.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where :user_id => user_id }

  def as_text
    [user.fullname_or_email, "(#{roleinjury.name})"].join(' ')
  end
end
