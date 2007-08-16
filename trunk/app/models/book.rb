class Book < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :country_id
  validates_presence_of :booktype_id

  belongs_to :country
  belongs_to :booktype
  belongs_to :volume
  belongs_to :orig_language,
  :class_name => 'Language',
  :foreign_key => 'orig_language_id'
  belongs_to :trans_language,
  :class_name => 'Language',
  :foreign_key => 'trans_language_id'

  has_many :bookedition
end
