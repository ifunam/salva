class Book < ActiveRecord::Base
  validates_presence_of :title, :message => "Proporcione el título"
  validates_presence_of :author, :message => "Proporcione el autor"
  validates_presence_of :country_id, :message => "Proporcione el país"
  validates_presence_of :booktype_id,:message => "Proporcione el tipo de libro"
  validates_numericality_of :country_id, :booktype_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  #validates_uniqueness_of :title
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
  has_many :projectbooks
end
