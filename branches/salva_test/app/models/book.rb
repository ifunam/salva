class Book < ActiveRecord::Base
  validates_presence_of :title, :author, :country_id, :booktype_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :country_id, :booktype_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :volume_id, :orig_language_id,  :trans_language_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :country
  belongs_to :booktype
  belongs_to :volume
  belongs_to :orig_language, :class_name => 'Language', :foreign_key => 'orig_language_id'
  belongs_to :trans_language, :class_name => 'Language', :foreign_key => 'trans_language_id'

  validates_associated :country, :booktype, :volume, :orig_language, :trans_language

  has_many :bookeditions
  validates_associated :bookeditions
end
