class UserNewspaperarticle < ActiveRecord::Base
  # attr_accessor :newspaperarticle_id, :user_id, :ismainauthor

  validates_numericality_of :id, :newspaperarticle_id, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in=> [true, false]
  belongs_to :user
  belongs_to :newspaperarticle
  # attr_accessor :user_id

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where(["user_newspaperarticles.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where :user_id => user_id }

  scope :year_eq, lambda { |year|
    joins(:newspaperarticle).by_year(year, :field => :newsdate)
  }

  scope :adscription_id, lambda { |id|
    joins(:user => :user_adscription)
      .where(:user => {:user_adscription => {:adscription_id => id}})
  }

  # search_methods :year_eq, :adscription_id
end
