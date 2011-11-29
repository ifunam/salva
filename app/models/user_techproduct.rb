class UserTechproduct < ActiveRecord::Base
  before_validation :default_year

  validates_presence_of :year
  validates_numericality_of :id, :techproduct_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :userrole_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :techproduct
  belongs_to :userrole

  # Fix It: Move this code outside of the model
  def default_year
    self.year = Date.today.year if year.nil?
  end

  def author_with_role
    [user.author_name, "(#{userrole.name}, #{year})"].join(' ')
  end
end
