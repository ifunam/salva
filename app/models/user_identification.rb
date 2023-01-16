class UserIdentification < ActiveRecord::Base
  # attr_accessor :idtype_id, :descr
  validates_presence_of :idtype_id, :descr
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :idtype_id, :greater_than =>0, :only_integer => true

  validates_uniqueness_of :user_id, :scope => [:idtype_id]

  belongs_to :user
  belongs_to :idtype
  # TODO: remove this for next release
  belongs_to :identification
end
