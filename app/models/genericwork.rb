# encoding: utf-8
class Genericwork < ActiveRecord::Base
  # attr_accessor :authors, :title, :reference, :vol, :pages, :isbn_issn, :year, :month,
                  :user_genericworks_attributes, :genericworkstatus_id, :genericworktype_id,
                  :publisher_id, :institution_id

  validates_presence_of :authors, :title, :genericworktype_id, :genericworkstatus_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :genericworktype_id, :genericworkstatus_id, :year, :only_integer => true
  validates_numericality_of :institution_id, :publisher_id,  :allow_nil => true, :only_integer => true

  belongs_to :genericworktype
  belongs_to :genericworkstatus
  belongs_to :institution
  belongs_to :publisher
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_genericworks
  has_many :users, :through => :user_genericworks
  accepts_nested_attributes_for :user_genericworks
  user_association_methods_for :user_genericworks

  has_paper_trail

  default_scope -> { order(year: :desc, month: :desc, authors: :asc, title: :asc) }

  scope :popular_science, -> { joins(:genericworktype).where(:genericworktype => { :genericworkgroup_id => 1 }) }
  scope :outreach_works, -> { joins(:genericworktype).where(:genericworktype => { :genericworkgroup_id => 6 }) }
  scope :other_works, -> { joins(:genericworktype).where(:genericworktype => { :genericworkgroup_id => 5 }) }
  scope :teaching_products, -> { joins(:genericworktype).where(:genericworktype => { :genericworkgroup_id => 4 }) }
  scope :technical_reports, -> { joins(:genericworktype).where(:genericworktype => { :name => 'Reportes técnicos' }) }

  scope :user_id_eq, lambda { |user_id| joins(:user_genericworks).where(:user_genericworks => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("genericworks.id IN (#{UserGenericwork.select('DISTINCT(genericwork_id) as genericwork_id').where(["user_genericworks.user_id !=  ?", user_id]).to_sql}) AND genericworks.id  NOT IN (#{UserGenericwork.select('DISTINCT(genericwork_id) as genericwork_id').where(["user_genericworks.user_id =  ?", user_id]).to_sql})") }

  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [authors, title, "Tipo de trabajo: #{genericworktype.name}", "Status: #{genericworkstatus.name}", institution_name, pages, date].compact.join(', ')
  end

  def institution_name
    institution.name unless institution.nil?
  end

  def institution_and_country
    institution.name_and_country unless institution.nil?
  end

  def institution_country
    institution.country.name unless institution.nil?
  end

  def publisher_name
    publisher.name unless publisher.nil?
  end

end
