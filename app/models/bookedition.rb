class Bookedition < ActiveRecord::Base
  attr_accessible :book_attributes, :edition, :isbn, :pages, :year, :mediatype_id, :editionstatus_id,
                  :bookedition_roleinbooks_attributes
  validates_presence_of :edition, :mediatype_id, :year
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

  scope :authors, joins(:bookedition_roleinbooks).
                  where("roleinbook_id = 1 OR roleinbook_id = 2")

  scope :collaborators, joins(:bookedition_roleinbooks).
                  where("roleinbook_id != 1 AND roleinbook_id != 2")

  scope :user_id_eq, lambda { |user_id|
    joins(:bookedition_roleinbooks).
    where(:bookedition_roleinbooks => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
      where("bookeditions.id IN (#{BookeditionRoleinbook.select('DISTINCT(bookedition_id) as bookedition_id').
      where(["bookedition_roleinbooks.user_id !=  ?", user_id]).to_sql}) AND bookeditions.id  NOT IN (#{BookeditionRoleinbook.select('DISTINCT(bookedition_id) as bookedition_id').
      where(["bookedition_roleinbooks.user_id =  ?", user_id]).to_sql})")
  }
  search_methods :user_id_eq, :user_id_not_eq

  def as_text
    [ book.as_text, edition, publishers_as_text, book.country.name,
     isbn_text, year ].compact.join(', ')
  end

  def publishers_as_text
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
end
