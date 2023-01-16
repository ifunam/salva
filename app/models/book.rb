class Book < ActiveRecord::Base
  # attr_accessor :authors, :title, :country_id, :language_id, :booktype_id, :volume, :booklink, :is_selected

  validates_presence_of :title, :authors, :country_id, :booktype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :booktype_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :language_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :country
  belongs_to :booktype
  belongs_to :language
  has_many :bookeditions
  default_scope  -> { order(authors: :asc, title: :asc) }
  scope :selected, -> { where(:is_selected => true) }

  def to_s
    [authors, title, volume].compact.join(', ')
  end

  def language_name
    language.name unless language_id.nil?
  end

  def country_name
    country.name unless country_id.nil?
  end
end
