class Bookedition < ActiveRecord::Base
  # attr_accessor :book_attributes, :edition, :isbn, :pages, :year, :month, :mediatype_id, :editionstatus_id,
                  :bookedition_roleinbooks_attributes
  validates_presence_of :edition, :mediatype_id, :year, :month
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :mediatype_id,  :greater_than => 0, :only_integer => true
  validates_numericality_of :editionstatus_id, :allow_nil => true, :greater_than => 0, :only_integer =>true

  belongs_to :book
  belongs_to :mediatype
  belongs_to :editionstatus
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  accepts_nested_attributes_for :book

  has_many :bookedition_publishers
  has_many :publishers, :through => :bookedition_publishers
  accepts_nested_attributes_for :bookedition_publishers

  has_many :bookedition_roleinbooks
  has_many :users, :through => :bookedition_roleinbooks
  accepts_nested_attributes_for :bookedition_roleinbooks
  user_association_methods_for :bookedition_roleinbooks

  has_paper_trail

  scope :recent, :order => 'year DESC, month DESC',  :limit => 20
  scope :published, :conditions => 'editionstatus_id = 1'
  scope :inprogress, :conditions => 'editionstatus_id != 1'

  scope :authors, -> { joins(:bookedition_roleinbooks).
                  where("bookedition_roleinbooks.roleinbook_id = 1 OR bookedition_roleinbooks.roleinbook_id = 2") }

  scope :collaborators, -> { joins(:bookedition_roleinbooks).
                  where("bookedition_roleinbooks.roleinbook_id != 1 AND bookedition_roleinbooks.roleinbook_id != 2") }

  scope :user_id_eq, lambda { |user_id|
    joins(:bookedition_roleinbooks).
    where(:bookedition_roleinbooks => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
      bookedition_without_user_sql = BookeditionRoleinbook.select('DISTINCT(bookedition_id) as bookedition_id').where(["bookedition_roleinbooks.user_id !=  ?", user_id]).to_sql
      bookedition_with_user_sql = BookeditionRoleinbook.select('DISTINCT(bookedition_id) as bookedition_id').where(["bookedition_roleinbooks.user_id =  ?", user_id]).to_sql
      sql = "bookeditions.id IN (#{bookedition_without_user_sql}) AND bookeditions.id NOT IN (#{bookedition_without_user_sql})"
      where(sql)
  }

  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [ book.to_s, edition, publishers_to_s, book.country.name,
     isbn_text, date ].compact.join(', ')
  end

  def publishers_to_s
    publishers.collect { |record| record.name }.compact.join(', ')
  end

  def isbn_text
    "ISBN: #{isbn}" unless isbn.to_s.strip.empty?
  end

  def authors
    bookedition_roleinbooks.authors
  end

  def collaborators
    bookedition_roleinbooks.collaborators
  end

  def editionstatus_name
    editionstatus_id.nil? ? '-' : editionstatus.name
  end

  def mediatype_name
    mediatype_id.nil? ? '-' : mediatype.name
  end

  def book_language
    book.language_name unless book_id.nil?
  end

  def book_country
    book.country_name unless book_id.nil?
  end
end
