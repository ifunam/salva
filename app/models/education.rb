class Education < ActiveRecord::Base
  validates_presence_of  :startyear
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true

  validates_numericality_of :endyear, :credits, :allow_nil => true
  validates_inclusion_of :is_titleholder, :in => [true, false], :if => lambda { |record| record.is_studying_this == false}
  validates_inclusion_of :is_studying_this, :in => [true, false], :if => lambda { |record| record.is_titleholder == false}

  belongs_to :institutioncareer
  belongs_to :career
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope :order => 'endyear DESC, startyear DESC'

  def as_text
    [institutioncareer.career.name, institutioncareer.career.degree.name, start_date, end_date]
  end
end
