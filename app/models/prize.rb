 class Prize < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_presence_of :name

  belongs_to :prizetype
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'
  belongs_to :institution

  has_many :user_prizes
  has_many :users, :through => :user_prizes

  def as_text
    ["#{prizetype.name}: #{name}", "Otorgado por: #{institution.name}"].join(', ')
  end
end
