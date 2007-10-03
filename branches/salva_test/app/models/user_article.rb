class UserArticle < ActiveRecord::Base
  validates_presence_of :article_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :article_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:article_id]

  belongs_to :article
  belongs_to :user

  validates_associated :article
  validates_associated :user
end
