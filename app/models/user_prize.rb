class UserPrize < ActiveRecord::Base
  # attr_accessor :prize_attributes, :year, :month

  validates_presence_of  :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :year, :greater_than => 0, :only_integer => true

  belongs_to :prize
  accepts_nested_attributes_for :prize

  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope -> { order(year: :desc, month: :desc) }
  scope :adscription_id, lambda { |id|
    joins(:user => :user_adscription)
      .where(:user => {:user_adscription => {:adscription_id => id}})
  }

  # # search_methods :adscription_id

  def to_s
    [prize.to_s, date].join(', ')
  end
end
