class Newspaperarticle < ActiveRecord::Base
  validates_presence_of :title, :authors, :newspaper_id, :newsdate

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :newspaper_id, :greater_than =>0, :only_integer => true

  belongs_to :newspaper
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_newspaperarticles
  has_many :users, :through => :user_newspaperarticles
  accepts_nested_attributes_for :user_newspaperarticles
  user_association_methods_for :user_newspaperarticles

  has_paper_trail

  default_scope :order => 'newsdate DESC, authors ASC, title ASC'

  scope :user_id_eq, lambda { |user_id| joins(:user_newspaperarticles).where(:user_newspaperarticles => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("newspaperarticles.id IN (#{UserNewspaperarticle.select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where(["user_newspaperarticles.user_id !=  ?", user_id]).to_sql}) AND newspaperarticles.id  NOT IN (#{UserNewspaperarticle.select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where(["user_newspaperarticles.user_id =  ?", user_id]).to_sql})") }
  scope :year_eq, lambda {|year| by_year(year, :field => :newsdate) }
  scope :among, lambda{ |start_date, end_date| where{{:newsdate.gteq => start_date} & {:newsdate.lteq => end_date}} }

  search_methods :user_id_eq, :user_id_not_eq, :year_eq
  search_methods :among, :type => [:date, :date], :splat_param => true

  def as_text
    [authors, title, newspaper.name_and_country, pages, I18n.localize(newsdate, :format => :long_without_day)].compact.join(', ')
  end
end
