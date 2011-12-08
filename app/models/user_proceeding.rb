class UserProceeding < ActiveRecord::Base
  validates_presence_of :roleproceeding_id
  validates_numericality_of :id, :user_id, :proceeding_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleproceeding_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding

  def author_with_role
    "#{user.author_name} (#{roleproceeding.name})"
  end
end
