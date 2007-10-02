class UserArticle < ActiveRecord::Base
  validates_presence_of :article_id
  validates_numericality_of :article_id
  belongs_to :article
  belongs_to :user
end
