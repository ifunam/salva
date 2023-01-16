class Language < ActiveRecord::Base
  # attr_accessor :name
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :name
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  
  has_many :user_languages
  has_many :books

  default_scope -> { order(name: :asc) }
end
