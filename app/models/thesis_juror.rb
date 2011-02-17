class ThesisJuror < ActiveRecord::Base
  validates_presence_of :roleinjury_id, :year
  validates_numericality_of :roleinjury_id, :year
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury

  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  def as_text
    [user.fullname_or_email, "(#{roleinjury.name})"].join(' ')
  end
end
