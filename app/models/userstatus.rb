class Userstatus < ActiveRecord::Base
  validates_presence_of :name
  # attr_accessor :name
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name
  default_scope -> { order(name: :asc) }

  has_many :users
# has_many :usersstatuses_comments
# has_many :users_logs, :foreign_key => "old_userstatus_id	"
end
