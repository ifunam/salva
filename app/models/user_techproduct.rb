class UserTechproduct < ActiveRecord::Base
  # attr_accessor :user_id, :techproduct_id, :userrole_id, :year
  before_validation :default_year

  validates_presence_of :year
  validates_numericality_of :id, :techproduct_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :userrole_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  scope :user_id_not_eq, lambda { |user_id| 
    select('DISTINCT(techproduct_id) as techproduct_id').where("user_techproducts.user_id != ?", user_id)
  }

  scope :user_id_eq, lambda { |user_id|
    select('DISTINCT(techproduct_id) as techproduct_id').where :user_id => user_id
  }

  scope :adscription_id, lambda { |id|
    joins(:user => :user_adscription)
      .where(:user => {:user_adscription => {:adscription_id => id}})
  }

  # search_methods :adscription_id

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
