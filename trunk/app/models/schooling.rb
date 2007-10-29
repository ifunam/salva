class Schooling < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :startyear
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :institutioncareer_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :endyear, :credits, :allow_nil => true
  validates_inclusion_of :is_titleholder, :in => [true], :if => lambda { |record| record.is_studying_this == false}
  validates_inclusion_of :is_studying_this, :in => [true], :if => lambda { |record| record.is_titleholder == false}
  validates_uniqueness_of :user_id, :scope => [:institutioncareer_id] 
  belongs_to :institutioncareer
end
