class Techproduct < ActiveRecord::Base
  validates_presence_of :title, :authors
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :techproducttype_id, :techproductstatus_id, :greater_than => 0, :only_integer => true

  belongs_to :techproducttype
  belongs_to :techproductstatus
  belongs_to :institution
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  has_many :user_techproducts
  has_many :users, :through => :user_techproducts
  accepts_nested_attributes_for :user_techproducts
  user_association_methods_for :user_techproducts

  default_scope :order => 'user_techproducts.year DESC, authors ASC, title ASC', :joins => :user_techproducts
  scope :user_id_eq, lambda { |user_id| joins(:user_techproducts).where(:user_techproducts => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("techproducts.id IN (#{UserTechproduct.select('DISTINCT(techproduct_id) as techproduct_id').where(["user_techproducts.user_id !=  ?", user_id]).to_sql}) AND techproducts.id  NOT IN (#{UserTechproduct.select('DISTINCT(techproduct_id) as techproduct_id').where(["user_techproducts.user_id =  ?", user_id]).to_sql})") }
  scope :year_eq, lambda { |year| joins(:user_techproducts).where(:user_techproducts => {:year => year}) }

  search_methods :user_id_eq, :user_id_not_eq, :year_eq

  def as_text
    [authors, title, "Tipo de trabajo: #{techproducttype.name}", "Status: #{techproductstatus.name}", year].compact.join(', ')
  end

  def institution_name
    institution.name_and_country unless institution.nil?
  end

  def year
    user_techproducts.first.year unless user_techproducts.first.nil?
  end
end
